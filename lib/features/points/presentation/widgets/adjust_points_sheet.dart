import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/dialog_save_button.dart';
import '../../../../l10n/l10n.dart';

const _quickAmounts = [10, 25, 50, 100, 250];

// Returns true once the points were saved.
Future<bool> showAdjustPointsSheet(
  BuildContext context, {
  required String name,
  required int balance,
  required Future<void> Function(int amount, String reason) onSave,
}) async =>
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (_) =>
          AdjustPointsSheet(name: name, balance: balance, onSave: onSave),
    ) ??
    false;

class AdjustPointsSheet extends StatefulWidget {
  final String name;
  final int balance;
  final Future<void> Function(int amount, String reason) onSave;

  const AdjustPointsSheet({
    super.key,
    required this.name,
    required this.balance,
    required this.onSave,
  });

  @override
  State<AdjustPointsSheet> createState() => _AdjustPointsSheetState();
}

class _AdjustPointsSheetState extends State<AdjustPointsSheet> {
  final _amount = TextEditingController();
  final _reason = TextEditingController();
  bool _remove = false;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    _reason.dispose();
    super.dispose();
  }

  int get _value => int.tryParse(_amount.text.trim()) ?? 0;
  int get _change => _remove ? -_value : _value;
  bool get _tooMany => _remove && _value > widget.balance;
  bool get _ready =>
      _value > 0 &&
      _value <= 100000 &&
      !_tooMany &&
      _reason.text.trim().isNotEmpty;

  void _setAmount(int value) {
    _amount.text = '$value';
    _amount.selection = TextSelection.collapsed(offset: _amount.text.length);
    setState(() => _error = null);
  }

  void _setReason(String text) {
    _reason.text = text;
    _reason.selection = TextSelection.collapsed(offset: text.length);
    setState(() => _error = null);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    if (!_ready) {
      setState(() => _error = l10n.adjustPointsInvalid);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.onSave(_change, _reason.text.trim());
      if (mounted) Navigator.of(context).pop(true);
    } on FirebaseFunctionsException catch (e) {
      debugPrint('Points not adjusted: ${e.code} ${e.message}');
      if (mounted) {
        setState(() {
          _saving = false;
          _error = e.code == 'failed-precondition'
              ? l10n.adjPtsTooMany(l10n.pointsTotal(widget.balance))
              : l10n.actionFailed;
        });
      }
    } catch (e) {
      debugPrint('Points not adjusted: $e');
      if (mounted) {
        setState(() {
          _saving = false;
          _error = l10n.actionFailed;
        });
      }
    }
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(top: 18, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = _remove ? AppColors.danger : AppColors.primary;
    final after = widget.balance + _change;
    final reasons = [
      l10n.adjPtsReason1,
      l10n.adjPtsReason2,
      l10n.adjPtsReason3,
      l10n.adjPtsReason4,
    ];

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.adjustPoints,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.name,
              style: const TextStyle(color: AppColors.textMuted),
            ),
            const SizedBox(height: 14),
            _Balance(
              before: widget.balance,
              after: _value > 0 ? after : null,
              color: color,
              invalid: _tooMany,
            ),
            const SizedBox(height: 14),
            _AddRemove(
              remove: _remove,
              onChanged: _saving
                  ? null
                  : (v) => setState(() {
                      _remove = v;
                      _error = null;
                    }),
            ),
            _label(l10n.adjPtsAmount),
            TextField(
              controller: _amount,
              enabled: !_saving,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              onChanged: (_) => setState(() => _error = null),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: color,
              ),
              decoration: InputDecoration(
                prefixText: _remove ? '− ' : '+ ',
                prefixStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
                hintText: '0',
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final a in _quickAmounts)
                  ChoiceChip(
                    label: Text('${_remove ? '−' : '+'}$a'),
                    selected: _value == a,
                    onSelected: _saving ? null : (_) => _setAmount(a),
                  ),
              ],
            ),
            if (_tooMany)
              DialogError(l10n.adjPtsTooMany(l10n.pointsTotal(widget.balance))),
            _label(l10n.adjustPointsReason),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final r in reasons)
                  ActionChip(
                    label: Text(r),
                    onPressed: _saving ? null : () => _setReason(r),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _reason,
              enabled: !_saving,
              maxLength: 200,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) => setState(() => _error = null),
              decoration: InputDecoration(
                hintText: l10n.adjPtsReasonHint,
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            if (!_tooMany) DialogError(_error),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: DialogSaveButton(
                saving: _saving,
                label: _value > 0
                    ? (_remove
                          ? l10n.adjPtsSaveRemove(l10n.pointsTotal(_value))
                          : l10n.adjPtsSaveAdd(l10n.pointsTotal(_value)))
                    : l10n.save,
                onPressed: _ready ? _save : null,
              ),
            ),
            TextButton(
              onPressed: _saving
                  ? null
                  : () => Navigator.of(context).pop(false),
              child: Text(l10n.cancel),
            ),
          ],
        ),
      ),
    );
  }
}

class _Balance extends StatelessWidget {
  final int before;
  final int? after;
  final Color color;
  final bool invalid;

  const _Balance({
    required this.before,
    required this.after,
    required this.color,
    required this.invalid,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget column(String label, String value, Color valueColor) => Expanded(
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          column(l10n.adjPtsBalance, '$before', AppColors.text),
          Icon(
            Icons.arrow_forward_rounded,
            color: after == null ? AppColors.border : color,
          ),
          column(
            l10n.adjPtsNewBalance,
            after == null ? '–' : '$after',
            after == null
                ? AppColors.textMuted
                : invalid
                ? AppColors.danger
                : color,
          ),
        ],
      ),
    );
  }
}

class _AddRemove extends StatelessWidget {
  final bool remove;
  final ValueChanged<bool>? onChanged;

  const _AddRemove({required this.remove, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget pill(bool isRemove, IconData icon, String text) {
      final selected = remove == isRemove;
      final color = isRemove ? AppColors.danger : AppColors.primary;
      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onChanged == null ? null : () => onChanged!(isRemove),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? color : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: selected ? Colors.white : AppColors.textMuted,
                ),
                const SizedBox(width: 6),
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          pill(false, Icons.add_rounded, l10n.adjPtsAdd),
          pill(true, Icons.remove_rounded, l10n.adjPtsRemove),
        ],
      ),
    );
  }
}

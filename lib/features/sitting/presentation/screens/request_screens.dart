import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../heat/domain/heat.dart' show heatDay;
import '../../../moderation/presentation/widgets/flag_actions.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/sitting_repository.dart';
import '../../domain/sitting.dart';
import '../providers/sitting_provider.dart';
import '../widgets/sitting_widgets.dart';
import 'chat_screens.dart';
import 'sitter_screens.dart';
import '../../../../core/utils/screen_space.dart';

String sittingError(AppLocalizations l10n, Object e) => switch (e) {
  SittingException(code: 'failed-precondition') => l10n.sitNotAvailableNow,
  SittingException(code: 'already-exists') => l10n.sitAlreadyReviewed,
  _ => l10n.actionFailed,
};

Future<void> runSitting(
  BuildContext context,
  Future<void> Function() action, {
  String? success,
}) async {
  final l10n = context.l10n;
  try {
    await action();
    if (success != null && context.mounted) {
      SnackbarUtils.showSuccess(context, success);
    }
  } catch (e) {
    debugPrint('Pet sitting action failed: $e');
    if (context.mounted) {
      SnackbarUtils.showError(context, sittingError(l10n, e));
    }
  }
}

Future<bool> confirmDialog(
  BuildContext context,
  String title,
  String text,
) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.sitYes),
          ),
        ],
      ),
    ) ==
    true;

class RequestFormScreen extends ConsumerStatefulWidget {
  const RequestFormScreen({super.key});

  @override
  ConsumerState<RequestFormScreen> createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends ConsumerState<RequestFormScreen> {
  final Set<String> _petIds = {};
  SittingService _service = SittingService.visits;
  late DateTime _start = heatDay(DateTime.now()).add(const Duration(days: 1));
  late DateTime _end = _start;
  final _notes = TextEditingController();
  final _budget = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _notes.dispose();
    _budget.dispose();
    super.dispose();
  }

  Future<void> _pick(bool start) async {
    final today = heatDay(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: start ? _start : _end,
      firstDate: start ? today : _start,
      lastDate: today.add(const Duration(days: 365)),
    );
    if (picked == null) return;
    final day = heatDay(picked);
    setState(() {
      if (start) {
        _start = day;
        if (_end.isBefore(day)) _end = day;
      } else {
        _end = day;
      }
    });
  }

  Future<void> _publish(List<Pet> pets) async {
    final l10n = context.l10n;
    final uid = ref.read(authStateProvider).value?.uid;
    final profile = ref.read(userProfileProvider).value;
    if (uid == null || profile == null) return;
    final chosen = [
      for (final p in pets)
        if (_petIds.contains(p.id)) p,
    ];
    if (chosen.isEmpty) {
      SnackbarUtils.showError(context, l10n.sitChoosePets);
      return;
    }
    setState(() => _busy = true);
    await runSitting(context, () async {
      await ref
          .read(sittingRepositoryProvider)
          .createRequest(
            ownerId: uid,
            ownerName: profile.name,
            pets: chosen,
            service: _service,
            start: _start,
            end: _end,
            city: profile.city!,
            lat: profile.homeLat!,
            lng: profile.homeLng!,
            notes: _notes.text,
            budget: _budget.text,
          );
      if (mounted) Navigator.of(context).pop();
    }, success: l10n.sitRequestPublished);
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final profile = ref.watch(userProfileProvider).value;
    final pets = ref.watch(myPetsProvider).value ?? const <Pet>[];
    final hasPlace =
        profile?.city != null &&
        profile?.homeLat != null &&
        profile?.homeLng != null;
    Widget dateTile(String label, DateTime d, bool start) => Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () => _pick(start),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            Text(
              sittingDates(l10n, d, d),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.sitNewRequest),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: AbsorbPointer(
        absorbing: _busy,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(16, 8, 16, endSpace(context)),
          children: [
            if (!hasPlace)
              SittingCard(
                tint: AppColors.danger,
                child: Text(l10n.sitNeedCity),
              ),
            SittingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepTitle(1, l10n.sitWhichPets),
                  if (pets.isEmpty)
                    Text(
                      l10n.sitAddPetFirst,
                      style: const TextStyle(color: AppColors.textMuted),
                    ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final p in pets)
                        _PickTile(
                          selected: _petIds.contains(p.id),
                          onTap: () => setState(
                            () => _petIds.contains(p.id)
                                ? _petIds.remove(p.id)
                                : _petIds.add(p.id),
                          ),
                          icon: FaIcon(
                            speciesIcon(p.species),
                            size: 16,
                            color: sittingColor,
                          ),
                          label: p.name,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SittingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepTitle(2, l10n.sitWhatService),
                  StatGrid(
                    tiles: [
                      for (final sv in SittingService.values)
                        _PickTile(
                          wide: true,
                          selected: _service == sv,
                          onTap: () => setState(() => _service = sv),
                          icon: Icon(
                            sv.icon,
                            size: 22,
                            color: _service == sv ? Colors.white : sittingColor,
                          ),
                          label: sv.label(l10n),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SittingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepTitle(3, l10n.sitWhen),
                  Row(
                    children: [
                      dateTile(l10n.sitFrom, _start, true),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          color: AppColors.textMuted,
                        ),
                      ),
                      dateTile(l10n.sitTo, _end, false),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: InfoPill(
                      icon: Icons.calendar_month_rounded,
                      text: l10n.sitDaysTotal(sittingDays(_start, _end)),
                      color: sittingColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SittingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepTitle(4, l10n.sitNotes),
                  TextField(
                    controller: _notes,
                    maxLength: 800,
                    maxLines: 5,
                    minLines: 2,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: l10n.sitNotesHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _budget,
                    maxLength: 40,
                    decoration: InputDecoration(
                      labelText: l10n.sitBudget,
                      hintText: l10n.sitBudgetHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  if (hasPlace)
                    InfoPill(
                      icon: Icons.lock_outline_rounded,
                      text: l10n.sitShownArea(profile!.city!),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const SafetyNote(),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: sittingColor,
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: hasPlace && pets.isNotEmpty
                  ? () => _publish(pets)
                  : null,
              child: _busy
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        color: Colors.white,
                      ),
                    )
                  : Text(l10n.sitPublish),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestDetailScreen extends ConsumerWidget {
  final String requestId;

  const RequestDetailScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final me = ref.watch(authStateProvider).value?.uid;
    final state = ref.watch(sittingRequestProvider(requestId));
    final r = state.value;
    final repo = ref.read(sittingRepositoryProvider);
    void open(Widget screen) =>
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.sitRequest),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (r != null && me != null && r.ownerId != me)
            PopupMenuButton<String>(
              onSelected: (v) async {
                if (v == 'report') {
                  await flagWith(
                    context,
                    (reason, note) => repo.flag(
                      reporterId: me,
                      kind: SittingFlagKind.request,
                      targetId: r.id,
                      targetOwnerId: r.ownerId,
                      reason: reason,
                      note: note,
                    ),
                  );
                } else if (v == 'block' && context.mounted) {
                  final blocked = await blockUser(
                    context,
                    ref,
                    userId: r.ownerId,
                    name: r.ownerName,
                  );
                  if (blocked && context.mounted) Navigator.of(context).pop();
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(value: 'report', child: Text(l10n.sitReport)),
                PopupMenuItem(
                  value: 'block',
                  child: Text(l10n.blockUser(r.ownerName)),
                ),
              ],
            ),
        ],
      ),
      body: r == null
          ? Center(
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : Text(l10n.sitNotFound),
            )
          : ListView(
              padding: EdgeInsets.fromLTRB(16, 8, 16, endSpace(context)),
              children: [
                _RequestSummary(request: r),
                const SizedBox(height: 12),
                ...switch (roleIn(r, me)) {
                  RequestRole.owner => _ownerActions(context, ref, r, open),
                  _ => _visitorActions(context, ref, r, me, open),
                },
              ],
            ),
    );
  }

  List<Widget> _ownerActions(
    BuildContext context,
    WidgetRef ref,
    SittingRequest r,
    void Function(Widget) open,
  ) {
    final l10n = context.l10n;
    final repo = ref.read(sittingRepositoryProvider);
    final offers =
        ref.watch(offersOnProvider(r.id)).value ?? const <SittingOffer>[];
    final reviewed = ref.watch(reviewedProvider(r.id)).value ?? false;
    final me = ref.read(authStateProvider).value?.uid;
    return [
      if (r.status == SittingStatus.booked ||
          r.status == SittingStatus.done) ...[
        SittingCard(
          tint: AppColors.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.sitBookedWith(r.sitterName),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () =>
                        openChatWith(context, ref, r.sitterId!, r.sitterName),
                    icon: const Icon(Icons.chat_bubble_outline_rounded),
                    label: Text(l10n.sitChat),
                  ),
                  OutlinedButton(
                    onPressed: () =>
                        open(SitterProfileScreen(uid: r.sitterId!)),
                    child: Text(l10n.sitViewProfile),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
      if (canConfirm(r, me)) ...[
        _ConfirmCard(request: r),
        const SizedBox(height: 12),
      ] else if (r.status == SittingStatus.booked && r.ownerConfirmed)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            l10n.sitWaitingOtherConfirm,
            style: const TextStyle(color: AppColors.textMuted),
          ),
        ),
      if (r.status == SittingStatus.done)
        reviewed
            ? Text(
                l10n.sitThanksReview,
                style: const TextStyle(color: AppColors.primary),
              )
            : FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: sittingColor,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () => showReviewSheet(context, ref, r),
                icon: const Icon(Icons.star_outline_rounded),
                label: Text(l10n.sitLeaveReview(r.sitterName)),
              ),
      if (r.status == SittingStatus.open) ...[
        SittingTitle(l10n.sitOffersTitle(offers.length)),
        if (offers.isEmpty)
          Text(
            l10n.sitNoOffersYet,
            style: const TextStyle(color: AppColors.textMuted),
          ),
        for (final o in offers)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SittingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SittingAvatar(name: o.sitterName, radius: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          o.sitterName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      SittingChip(o.status.label(l10n), color: o.status.color),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(o.message),
                  if (o.price.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      l10n.sitPrice(o.price),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (o.status == OfferStatus.pending)
                        BusyButton(
                          kind: BusyKind.filled,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          before: () => confirmDialog(
                            context,
                            l10n.sitAcceptTitle(o.sitterName),
                            l10n.sitAcceptText,
                          ),
                          onPressed: () => runSitting(
                            context,
                            () => repo.acceptOffer(o),
                            success: l10n.sitAccepted,
                          ),
                          icon: const Icon(Icons.check_rounded, size: 18),
                          label: Text(l10n.sitAccept),
                        ),
                      OutlinedButton(
                        onPressed: () =>
                            open(SitterProfileScreen(uid: o.sitterId)),
                        child: Text(l10n.sitViewProfile),
                      ),
                      OutlinedButton(
                        onPressed: () => openChatWith(
                          context,
                          ref,
                          o.sitterId,
                          o.sitterName,
                        ),
                        child: Text(l10n.sitChat),
                      ),
                      if (o.status == OfferStatus.pending)
                        BusyButton(
                          kind: BusyKind.text,
                          onPressed: () => runSitting(
                            context,
                            () => repo.setOfferStatus(o, OfferStatus.declined),
                          ),
                          label: Text(l10n.sitDecline),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
      if (r.status == SittingStatus.open ||
          r.status == SittingStatus.booked) ...[
        const SizedBox(height: 12),
        BusyButton(
          kind: BusyKind.text,
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          before: () =>
              confirmDialog(context, l10n.sitCloseTitle, l10n.sitCloseText),
          onPressed: () => runSitting(context, () => repo.closeRequest(r.id)),
          icon: const Icon(Icons.close_rounded),
          label: Text(
            r.status == SittingStatus.booked
                ? l10n.sitCancelBooking
                : l10n.sitCloseRequest,
          ),
        ),
      ],
    ];
  }

  List<Widget> _visitorActions(
    BuildContext context,
    WidgetRef ref,
    SittingRequest r,
    String? me,
    void Function(Widget) open,
  ) {
    final l10n = context.l10n;
    final repo = ref.read(sittingRepositoryProvider);
    final mine = (ref.watch(myOffersProvider).value ?? const <SittingOffer>[])
        .where((o) => o.requestId == r.id)
        .firstOrNull;
    final sitter = ref.watch(mySitterProfileProvider).value;
    final bookedMe = roleIn(r, me) == RequestRole.bookedSitter;
    return [
      OutlinedButton.icon(
        onPressed: () => openChatWith(context, ref, r.ownerId, r.ownerName),
        icon: const Icon(Icons.chat_bubble_outline_rounded),
        label: Text(l10n.sitChatWith(r.ownerName)),
      ),
      const SizedBox(height: 12),
      if (bookedMe) ...[
        SittingCard(
          tint: AppColors.primary,
          child: Text(
            l10n.sitYouAreBooked,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (canConfirm(r, me))
          _ConfirmCard(request: r)
        else if (r.status == SittingStatus.booked && r.sitterConfirmed)
          Text(
            l10n.sitWaitingOtherConfirm,
            style: const TextStyle(color: AppColors.textMuted),
          ),
      ] else if (mine != null)
        SittingCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: SittingTitle(l10n.sitYourOffer)),
                  SittingChip(
                    mine.status.label(l10n),
                    color: mine.status.color,
                  ),
                ],
              ),
              Text(mine.message),
              if (mine.status == OfferStatus.pending)
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: BusyButton(
                    kind: BusyKind.text,
                    onPressed: () => runSitting(
                      context,
                      () => repo.setOfferStatus(mine, OfferStatus.withdrawn),
                    ),
                    label: Text(l10n.sitWithdraw),
                  ),
                ),
            ],
          ),
        )
      else if (r.status == SittingStatus.open)
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: sittingColor,
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: () => sitter == null
              ? open(const SitterFormScreen())
              : _offerSheet(context, ref, r, sitter),
          icon: const Icon(Icons.send_rounded),
          label: Text(
            sitter == null ? l10n.sitBecomeSitterToOffer : l10n.sitSendOffer,
          ),
        ),
    ];
  }

  Future<void> _offerSheet(
    BuildContext context,
    WidgetRef ref,
    SittingRequest r,
    SitterProfile sitter,
  ) async {
    final l10n = context.l10n;
    final message = TextEditingController();
    final price = TextEditingController();
    String? error;
    final send = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            0,
            20,
            MediaQuery.viewInsetsOf(context).bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SittingTitle(l10n.sitSendOffer),
              TextField(
                controller: message,
                autofocus: true,
                maxLength: 500,
                maxLines: 4,
                minLines: 2,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: l10n.sitOfferMessage,
                  hintText: l10n.sitOfferMessageHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: price,
                maxLength: 40,
                decoration: InputDecoration(
                  labelText: l10n.sitOfferPrice,
                  hintText: l10n.sitBudgetHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    error!,
                    style: const TextStyle(color: AppColors.danger),
                  ),
                ),
              BusyButton(
                kind: BusyKind.filled,
                style: FilledButton.styleFrom(
                  backgroundColor: sittingColor,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () async {
                  if (message.text.trim().isEmpty) return;
                  try {
                    await ref
                        .read(sittingRepositoryProvider)
                        .sendOffer(
                          r,
                          sitterId: sitter.uid,
                          sitterName: sitter.name,
                          message: message.text,
                          price: price.text,
                        );
                    if (context.mounted) Navigator.pop(context, true);
                  } catch (e) {
                    debugPrint('Offer not sent: $e');
                    setState(() => error = sittingError(l10n, e));
                  }
                },
                icon: const Icon(Icons.send_rounded, size: 18),
                label: Text(l10n.sitSend),
              ),
            ],
          ),
        ),
      ),
    );
    if (send == true && context.mounted) {
      SnackbarUtils.showSuccess(context, l10n.sitOfferSent);
    }
    message.dispose();
    price.dispose();
  }
}

class _RequestSummary extends ConsumerWidget {
  final SittingRequest request;

  const _RequestSummary({required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final r = request;
    final reviewed =
        r.status == SittingStatus.done &&
        (ref.watch(reviewedProvider(r.id)).value ?? false);
    final reached = switch (r.status) {
      SittingStatus.open => 0,
      SittingStatus.booked => 1,
      SittingStatus.done => reviewed ? 3 : 2,
      SittingStatus.closed => -1,
    };
    Widget line(IconData icon, String text) => Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: sittingColor.withValues(alpha: 0.1),
            child: Icon(icon, size: 16, color: sittingColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                text,
                style: const TextStyle(height: 1.35, color: AppColors.text),
              ),
            ),
          ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: sittingGradient,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: sittingColor.withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              DateBadge(date: r.start, color: AppColors.primaryDark),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(r.service.icon, size: 18, color: Colors.white),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            r.service.label(l10n),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${sittingDates(l10n, r.start, r.end)} · ${l10n.sitDaysTotal(sittingDays(r.start, r.end))}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        r.status.label(l10n),
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: r.status.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (reached >= 0) ...[
          const SizedBox(height: 12),
          SittingCard(
            child: StatusTimeline(
              steps: [
                l10n.sitStepPublished,
                l10n.sitStatusBooked,
                l10n.sitStepConfirmed,
                l10n.sitStepReviewed,
              ],
              reached: reached,
            ),
          ),
        ],
        const SizedBox(height: 12),
        SittingCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              line(
                Icons.pets_rounded,
                '${r.petNames.join(', ')} (${speciesList(l10n, r.species)})',
              ),
              line(Icons.place_outlined, r.city),
              line(Icons.person_outline_rounded, r.ownerName),
              if (r.budget.isNotEmpty) line(Icons.payments_outlined, r.budget),
              if (r.notes.isNotEmpty) line(Icons.notes_rounded, r.notes),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConfirmCard extends ConsumerWidget {
  final SittingRequest request;

  const _ConfirmCard({required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return SittingCard(
      tint: sittingColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.sitConfirmTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.sitConfirmText,
            style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          const SizedBox(height: 10),
          BusyButton(
            kind: BusyKind.filled,
            style: FilledButton.styleFrom(backgroundColor: sittingColor),
            onPressed: () => runSitting(
              context,
              () => ref.read(sittingRepositoryProvider).confirm(request.id),
              success: l10n.sitConfirmed,
            ),
            icon: const Icon(Icons.verified_rounded),
            label: Text(l10n.sitConfirmButton),
          ),
        ],
      ),
    );
  }
}

Future<void> showReviewSheet(
  BuildContext context,
  WidgetRef ref,
  SittingRequest r,
) async {
  final l10n = context.l10n;
  final text = TextEditingController();
  var stars = 0;
  String? error;
  final send = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: AppColors.surface,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          0,
          20,
          MediaQuery.viewInsetsOf(context).bottom + endSpace(context),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SittingTitle(l10n.sitLeaveReview(r.sitterName)),
            Text(
              l10n.sitReviewHint,
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 1; i <= 5; i++)
                  IconButton(
                    onPressed: () => setState(() => stars = i),
                    icon: Icon(
                      i <= stars
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 36,
                      color: AppColors.accent,
                    ),
                  ),
              ],
            ),
            TextField(
              controller: text,
              maxLength: 800,
              maxLines: 4,
              minLines: 2,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l10n.sitReviewText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  error!,
                  style: const TextStyle(color: AppColors.danger),
                ),
              ),
            BusyButton(
              kind: BusyKind.filled,
              style: FilledButton.styleFrom(
                backgroundColor: sittingColor,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () async {
                if (stars == 0) return;
                try {
                  await ref
                      .read(sittingRepositoryProvider)
                      .review(r.id, stars, text.text);
                  if (context.mounted) Navigator.pop(context, true);
                } catch (e) {
                  debugPrint('Review not sent: $e');
                  setState(() => error = sittingError(l10n, e));
                }
              },
              icon: const Icon(Icons.send_rounded, size: 18),
              label: Text(l10n.sitSend),
            ),
          ],
        ),
      ),
    ),
  );
  if (send == true && context.mounted) {
    SnackbarUtils.showSuccess(context, l10n.sitThanksReview);
  }
  text.dispose();
}

class _PickTile extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final Widget icon;
  final String label;
  final bool wide;

  const _PickTile({
    required this.selected,
    required this.onTap,
    required this.icon,
    required this.label,
    this.wide = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        gradient: selected && wide ? sittingGradient : null,
        color: selected
            ? (wide ? null : sittingColor.withValues(alpha: 0.1))
            : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? sittingColor : AppColors.border,
          width: selected ? 2 : 1,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: wide
                ? const EdgeInsets.all(12)
                : const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: wide
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      icon,
                      const SizedBox(height: 8),
                      Text(
                        label,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: selected ? Colors.white : AppColors.text,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon,
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          label,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      if (selected) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 18,
                          color: sittingColor,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

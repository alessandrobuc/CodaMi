import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../data/emergency_repository.dart';
import '../../domain/emergency.dart';
import '../providers/emergency_provider.dart';
import '../widgets/emergency_widgets.dart';
import 'contact_form_screen.dart';

class AdminContactsScreen extends ConsumerStatefulWidget {
  const AdminContactsScreen({super.key});

  @override
  ConsumerState<AdminContactsScreen> createState() =>
      _AdminContactsScreenState();
}

class _AdminContactsScreenState extends ConsumerState<AdminContactsScreen> {
  final _search = TextEditingController();
  bool _seeding = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _edit([EmergencyContact? contact]) => Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => ContactFormScreen(contact: contact),
    ),
  );

  Future<void> _addTestContacts() async {
    setState(() => _seeding = true);
    try {
      await ref.read(emergencyRepositoryProvider).addTestContacts();
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, context.l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _seeding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(allContactsProvider);
    final all = state.value ?? const <EmergencyContact>[];
    final query = _search.text.trim().toLowerCase();
    final contacts = [
      for (final c in all)
        if (query.isEmpty ||
            c.name.toLowerCase().contains(query) ||
            (c.city ?? '').toLowerCase().contains(query))
          c,
    ];
    final hasTest = all.any((c) => c.isTest);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.emergencyContacts),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _edit,
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.addContact),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
        children: [
          TextField(
            controller: _search,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: l10n.searchContacts,
              prefixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (!hasTest && state.hasValue)
            OutlinedButton.icon(
              onPressed: _seeding ? null : _addTestContacts,
              icon: const Icon(Icons.science_rounded),
              label: Text(l10n.addTestContacts),
            ),
          const SizedBox(height: 8),
          if (state.isLoading && !state.hasValue)
            const Padding(
              padding: EdgeInsets.all(40),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (contacts.isEmpty)
            EmptyState(
              icon: const Icon(Icons.contact_phone_rounded),
              title: l10n.noEmergencyContacts,
              message: l10n.noEmergencyContactsAdmin,
            )
          else
            for (final c in contacts) ...[
              ContactCard(contact: c, onEdit: () => _edit(c)),
              const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }
}

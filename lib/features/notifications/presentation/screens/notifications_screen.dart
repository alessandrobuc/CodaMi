import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../../reports/presentation/providers/reports_provider.dart';
import '../../../reports/presentation/screens/report_detail_screen.dart';
import '../../../reports/presentation/widgets/reports_widget.dart';
import '../../domain/entities/notification_entity.dart';
import '../providers/notifications_provider.dart';
import '../../../../l10n/l10n.dart';
import '../../../emergency/presentation/screens/emergency_screen.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsProvider);
    final items = state.value ?? const <AppNotification>[];
    final unread = items.where((n) => !n.read).toList();
    final uid = ref.watch(authStateProvider).value?.uid;
    final today = DateTime.now().subtract(const Duration(hours: 24));
    final recent = [
      for (final n in items)
        if (n.createdAt == null || n.createdAt!.isAfter(today)) n,
    ];
    final earlier = [
      for (final n in items)
        if (!recent.contains(n)) n,
    ];

    void open(AppNotification n) {
      if (uid != null && !n.read) {
        ref.read(notificationsRepositoryProvider).markRead(uid, n.id);
      }
      if (n.emergencyId case final id?) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => EmergencyScreen(emergencyId: id)),
        );
        return;
      }
      final id = n.reportId;
      if (id == null) return;
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => ReportByIdScreen(reportId: id)));
    }

    Widget section(String title, List<AppNotification> list, int offset) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 10),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: AppColors.textMuted,
                ),
              ),
            ),
            for (final (i, n) in list.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child:
                    Dismissible(
                          key: ValueKey(n.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            if (uid != null) {
                              ref
                                  .read(notificationsRepositoryProvider)
                                  .delete(uid, n.id);
                            }
                          },
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            padding: const EdgeInsetsDirectional.only(end: 24),
                            decoration: BoxDecoration(
                              color: AppColors.danger.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: AppColors.danger,
                            ),
                          ),
                          child: _NotificationTile(
                            notification: n,
                            onTap: () => open(n),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: (40 * (i + offset)).ms, duration: 300.ms)
                        .slideY(begin: 0.12, end: 0),
              ),
          ],
        );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 12, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_rounded),
                      color: AppColors.text,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        context.l10n.notificationsTitle,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    if (unread.isNotEmpty && uid != null)
                      TextButton(
                        onPressed: () => ref
                            .read(notificationsRepositoryProvider)
                            .markAllRead(uid, unread.map((n) => n.id)),
                        child: Text(context.l10n.markAllRead),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: state.isLoading && !state.hasValue
                    ? const Center(child: CircularProgressIndicator())
                    : state.hasError && !state.hasValue
                    ? Center(
                        child: EmptyState(
                          icon: const Icon(Icons.cloud_off_rounded),
                          color: AppColors.lostPin,
                          title: context.l10n.notificationsLoadError,
                          message: context.l10n.checkConnection,
                        ),
                      )
                    : items.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: EmptyState(
                            icon: const Icon(Icons.notifications_none_rounded),
                            title: context.l10n.allCaughtUp,
                            message: context.l10n.notificationsEmpty,
                          ),
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                        children: [
                          if (recent.isNotEmpty)
                            section(
                              context.l10n.notificationsNew.toUpperCase(),
                              recent,
                              0,
                            ),
                          if (earlier.isNotEmpty)
                            section(
                              context.l10n.notificationsEarlier.toUpperCase(),
                              earlier,
                              recent.length,
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Built from the report fields so it follows the app language; older
// notifications only have the text the server stored.
(String, String) _text(AppLocalizations l10n, AppNotification n) {
  final pet = n.petName;
  final city = n.city;
  if (pet == null || city == null) return (n.title, n.body);
  final street = n.placeDetail;
  final lost = n.reportType == ReportType.lost;
  if (n.kind == NotificationKind.reportResolved) {
    return lost
        ? (l10n.notifBackHomeTitle(pet), l10n.notifBackHomeBody(pet, city))
        : (l10n.notifReunitedTitle(pet), l10n.notifReunitedBody(city));
  }
  if (lost) {
    return (
      l10n.notifLostTitle(city),
      street == null
          ? l10n.notifLostBodyIn(pet, city)
          : l10n.notifLostBodyNear(pet, street, city),
    );
  }
  return (
    l10n.notifFoundTitle(city),
    street == null
        ? l10n.notifFoundBodyIn(pet, city)
        : l10n.notifFoundBodyNear(pet, street, city),
  );
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const _NotificationTile({required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final n = notification;
    final (title, body) = _text(context.l10n, n);
    final resolved = n.kind == NotificationKind.reportResolved;
    final emergency = n.kind == NotificationKind.emergency;
    final color = emergency
        ? AppColors.danger
        : resolved
        ? AppColors.primary
        : reportColor(n.reportType);
    final icon = emergency
        ? Icons.emergency_rounded
        : resolved
        ? Icons.home_rounded
        : n.reportType == ReportType.lost
        ? Icons.search_rounded
        : Icons.volunteer_activism_rounded;

    return Material(
      color: n.read ? AppColors.surface : color.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: n.read ? AppColors.border : color.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox.expand(child: PetImage.url(n.photoUrl)),
                    ),
                    PositionedDirectional(
                      end: -4,
                      bottom: -4,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(icon, size: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: n.read
                                  ? FontWeight.w600
                                  : FontWeight.w800,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                        if (!n.read)
                          Container(
                            width: 9,
                            height: 9,
                            margin: const EdgeInsetsDirectional.only(start: 8),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: AppColors.textMuted,
                      ),
                    ),
                    if (n.createdAt != null) ...[
                      const SizedBox(height: 5),
                      Text(
                        timeAgo(context.l10n, n.createdAt!),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportByIdScreen extends ConsumerWidget {
  final String reportId;

  const ReportByIdScreen({super.key, required this.reportId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportProvider(reportId));
    final report = state.value;
    if (report != null) return ReportDetailScreen(report: report);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.background, elevation: 0),
      body: Center(
        child: state.isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(24),
                child: EmptyState(
                  icon: const Icon(Icons.search_off_rounded),
                  title: context.l10n.reportNotAvailable,
                  message: context.l10n.reportRemoved,
                ),
              ),
      ),
    );
  }
}

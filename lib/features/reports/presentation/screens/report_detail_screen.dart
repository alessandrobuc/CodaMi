import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../moderation/presentation/widgets/flag_actions.dart';
import '../../../moderation/presentation/widgets/moderation_panel.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../domain/entities/reports_entity.dart';
import '../providers/reports_provider.dart';
import '../widgets/report_actions.dart';
import '../widgets/reports_widget.dart';
import '../../../../l10n/labels.dart';
import '../../../moderation/presentation/widgets/held_photo_notice.dart';

class ReportDetailScreen extends ConsumerStatefulWidget {
  final Report report;

  const ReportDetailScreen({super.key, required this.report});

  @override
  ConsumerState<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends ConsumerState<ReportDetailScreen> {
  final _pageController = PageController();
  int _page = 0;
  bool _resolving = false;
  bool _deleting = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _open(Uri uri, String failure) async {
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && mounted) SnackbarUtils.showError(context, failure);
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, failure);
    }
  }

  void _call(Report r) =>
      _open(Uri(scheme: 'tel', path: r.contactPhone), context.l10n.callFailed);

  void _whatsapp(Report r) {
    final digits = r.contactPhone!.replaceAll(RegExp(r'[^0-9]'), '');
    final text = Uri.encodeComponent(
      r.type == ReportType.lost
          ? context.l10n.whatsappMessageLost(r.petName)
          : context.l10n.whatsappMessageFound(r.petName),
    );
    _open(
      Uri.parse('https://wa.me/$digits?text=$text'),
      context.l10n.whatsappFailed,
    );
  }

  void _email(Report r) => _open(
    Uri(
      scheme: 'mailto',
      path: r.contactEmail,
      query:
          'subject=${Uri.encodeComponent(r.type == ReportType.lost ? context.l10n.emailSubjectLost(r.petName) : context.l10n.emailSubjectFound(r.petName))}',
    ),
    context.l10n.emailFailed,
  );

  Future<void> _share(Report r) async {
    final l10n = context.l10n;
    final title = r.type == ReportType.lost
        ? l10n.shareTitleLost(r.petName)
        : l10n.shareTitleFound(r.petName);
    await SharePlus.instance.share(
      ShareParams(
        subject: title,
        text:
            '$title\n'
            '🐾 ${r.species.label(l10n)}\n'
            '📍 ${r.placeLabel(l10n)}\n'
            '🕒 ${dateTimeLabel(l10n, r.eventAt)}\n'
            '${r.activeReward == null ? '' : '🎁 ${l10n.rewardAmount(euroAmount(r.activeReward!))}\n'}'
            '\n'
            '${r.description}\n\n'
            '${l10n.shareFooter}',
      ),
    );
  }

  void _setBusy(bool resolving, bool value) {
    if (!mounted) return;
    setState(() => resolving ? _resolving = value : _deleting = value);
  }

  Future<void> _resolve(Report r) =>
      resolveReport(context, ref, r, onBusy: (v) => _setBusy(true, v));

  Future<void> _delete(Report r) async {
    final deleted = await deleteReport(
      context,
      ref,
      r,
      onBusy: (v) => _setBusy(false, v),
    );
    if (deleted && mounted) Navigator.of(context).pop();
  }

  Future<void> _block(Report r) async {
    final blocked = await blockOwner(context, ref, r);
    if (blocked && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final report =
        ref.watch(reportProvider(widget.report.id)).value ?? widget.report;
    final isOwner = ref.watch(authStateProvider).value?.uid == report.ownerId;
    final isStaff = ref.watch(userRoleProvider).isStaff;
    final textTheme = Theme.of(context).textTheme;
    final color = reportColor(report.type);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height * 0.48,
            pinned: true,
            stretch: true,
            backgroundColor: AppColors.primaryDark,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: _GlassButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            actions: [
              if (!report.isHidden)
                _GlassButton(
                  icon: Icons.ios_share_rounded,
                  onTap: () => _share(report),
                ),
              if (!isOwner && !isStaff) ...[
                const SizedBox(width: 8),
                _MoreMenu(
                  ownerName: report.ownerName,
                  onFlag: () => flagReport(context, ref, report),
                  onBlock: () => _block(report),
                ),
              ],
              const SizedBox(width: 12),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: report.photoUrls.isEmpty
                        ? 1
                        : report.photoUrls.length,
                    onPageChanged: (i) => setState(() => _page = i),
                    itemBuilder: (_, i) {
                      final image = PetImage.url(
                        report.photoUrls.isEmpty ? null : report.photoUrls[i],
                      );
                      return i == 0
                          ? Hero(tag: 'report-photo-${report.id}', child: image)
                          : image;
                    },
                  ),
                  const IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 0.25, 0.7, 1],
                          colors: [
                            Color(0x66000000),
                            Colors.transparent,
                            Colors.transparent,
                            Color(0x55000000),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (report.photoUrls.length > 1)
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: _PageDots(
                        count: report.photoUrls.length,
                        index: _page,
                      ),
                    ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(24),
              child: Container(
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              MediaQuery.paddingOf(context).bottom + 24,
            ),
            sliver: SliverList.list(
              children: [
                if (isOwner) HeldPhotoNotice(photoUrls: report.photoUrls),
                Row(
                  children: [
                    ReportTypeBadge(type: report.type, large: true),
                    const SizedBox(width: 8),
                    if (report.activeReward case final reward?) ...[
                      RewardBadge(amount: reward, large: true),
                      const SizedBox(width: 8),
                    ],
                    if (!report.isOpen)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              report.resolvedLabel(context.l10n),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    Text(
                      timeAgo(context.l10n, report.createdAt ?? report.eventAt),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        report.petName,
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                          height: 1.15,
                        ),
                      ),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: speciesColor(
                          report.species,
                        ).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: FaIcon(
                          speciesIcon(report.species),
                          size: 18,
                          color: speciesColor(report.species),
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.15),
                const SizedBox(height: 18),
                _InfoRow(
                  icon: Icons.location_on_rounded,
                  color: color,
                  label:
                      '${report.type == ReportType.lost ? context.l10n.lastSeen : context.l10n.foundAt}'
                      '${report.areaRadius == null ? '' : ' · ${context.l10n.areaAbout(report.areaRadius!)}'}',
                  value: report.placeLabel(context.l10n),
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.schedule_rounded,
                  color: AppColors.accent,
                  label: context.l10n.when,
                  value: dateTimeLabel(context.l10n, report.eventAt),
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.person_rounded,
                  color: AppColors.primary,
                  label: context.l10n.postedBy,
                  value: isOwner ? context.l10n.you : report.ownerName,
                ),
                if (report.activeReward case final reward?) ...[
                  const SizedBox(height: 16),
                  _Card(
                    title: context.l10n.reward,
                    icon: Icons.redeem_rounded,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          euroAmount(reward),
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.rewardText,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          context.l10n.rewardNote,
                          style: const TextStyle(
                            fontSize: 12.5,
                            height: 1.4,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 100.ms, duration: 350.ms),
                ],
                const SizedBox(height: 16),
                _Card(
                  title: context.l10n.description,
                  icon: Icons.notes_rounded,
                  child: Text(
                    report.description,
                    style: const TextStyle(color: AppColors.text, height: 1.5),
                  ),
                ).animate().fadeIn(delay: 150.ms, duration: 350.ms),
                const SizedBox(height: 16),
                if (isStaff)
                  ModerationPanel(report: report)
                else if (report.isHidden && !isOwner)
                  const _HiddenNotice()
                else if (isOwner)
                  _OwnerActions(
                    report: report,
                    resolving: _resolving,
                    deleting: _deleting,
                    onResolve: () => _resolve(report),
                    onDelete: () => _delete(report),
                    onCall: () => _call(report),
                    onEmail: () => _email(report),
                  )
                else if (report.isOpen)
                  _ContactCard(
                    report: report,
                    onCall: () => _call(report),
                    onWhatsapp: () => _whatsapp(report),
                    onEmail: () => _email(report),
                  ).animate().fadeIn(delay: 250.ms, duration: 350.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _GlassButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FrostedPill(
        padding: const EdgeInsets.all(9),
        child: Icon(icon, color: Colors.white, size: 21),
      ),
    );
  }
}

class _MoreMenu extends StatelessWidget {
  final String ownerName;
  final VoidCallback onFlag;
  final VoidCallback onBlock;

  const _MoreMenu({
    required this.ownerName,
    required this.onFlag,
    required this.onBlock,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return PopupMenuButton<VoidCallback>(
      tooltip: '',
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (action) => action(),
      itemBuilder: (_) => [
        PopupMenuItem(
          value: onFlag,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.flag_outlined),
            title: Text(l10n.flagListing),
          ),
        ),
        PopupMenuItem(
          value: onBlock,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.block_rounded, color: AppColors.danger),
            title: Text(
              l10n.blockUser(ownerName),
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ),
      ],
      child: const FrostedPill(
        padding: EdgeInsets.all(9),
        child: Icon(Icons.more_vert_rounded, color: Colors.white, size: 21),
      ),
    );
  }
}

class _HiddenNotice extends StatelessWidget {
  const _HiddenNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.textMuted.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.visibility_off_rounded,
            color: AppColors.textMuted,
            size: 26,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.l10n.hiddenListingNotice,
              style: const TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  final int count;
  final int index;

  const _PageDots({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == index ? 20 : 7,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: i == index ? 1 : 0.55),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _Card({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final Report report;
  final VoidCallback onCall;
  final VoidCallback onWhatsapp;
  final VoidCallback onEmail;

  const _ContactCard({
    required this.report,
    required this.onCall,
    required this.onWhatsapp,
    required this.onEmail,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhone = report.contactPhone != null;
    final buttons = [
      if (hasPhone)
        _ContactButton(
          icon: const Icon(Icons.call_rounded, color: Colors.white, size: 20),
          label: context.l10n.call,
          color: AppColors.primary,
          onTap: onCall,
        ),
      if (hasPhone && report.whatsapp)
        _ContactButton(
          icon: const FaIcon(
            FontAwesomeIcons.whatsapp,
            color: Colors.white,
            size: 20,
          ),
          label: 'WhatsApp',
          color: const Color(0xFF25D366),
          onTap: onWhatsapp,
        ),
      if (report.contactEmail != null)
        _ContactButton(
          icon: const Icon(Icons.mail_rounded, color: Colors.white, size: 20),
          label: context.l10n.email,
          color: AppColors.accent,
          onTap: onEmail,
        ),
    ];

    return _Card(
      title: report.type == ReportType.lost
          ? context.l10n.contactTitleLost(report.petName)
          : context.l10n.contactTitleFound,
      icon: Icons.forum_rounded,
      child: buttons.isEmpty
          ? Text(
              context.l10n.noContactShared,
              style: const TextStyle(color: AppColors.textMuted),
            )
          : Row(
              children: [
                for (final (i, b) in buttons.indexed) ...[
                  if (i > 0) const SizedBox(width: 10),
                  Expanded(child: b),
                ],
              ],
            ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OwnerActions extends StatelessWidget {
  final Report report;
  final bool resolving;
  final bool deleting;
  final VoidCallback onResolve;
  final VoidCallback onDelete;

  final VoidCallback onCall;
  final VoidCallback onEmail;

  const _OwnerActions({
    required this.report,
    required this.resolving,
    required this.deleting,
    required this.onResolve,
    required this.onDelete,
    required this.onCall,
    required this.onEmail,
  });

  @override
  Widget build(BuildContext context) {
    final delete = TextButton.icon(
      onPressed: deleting ? null : onDelete,
      icon: deleting
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.delete_outline_rounded),
      label: Text(context.l10n.deleteReport),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.danger,
        minimumSize: const Size.fromHeight(48),
      ),
    );

    if (report.isHidden) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [const _HiddenNotice(), const SizedBox(height: 8), delete],
      );
    }

    if (!report.isOpen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.celebration_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    report.type == ReportType.lost
                        ? context.l10n.resolvedThanksLost(report.petName)
                        : context.l10n.resolvedThanksFound,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),
          const SizedBox(height: 8),
          delete,
        ],
      );
    }

    final phone = report.contactPhone;
    final email = report.contactEmail;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (phone != null || email != null) ...[
          _Card(
            title: context.l10n.yourContactDetails,
            icon: Icons.contact_phone_rounded,
            child: Column(
              children: [
                if (phone != null)
                  _ContactLine(
                    icon: Icons.call_rounded,
                    color: AppColors.primary,
                    value: phone,
                    onTap: onCall,
                  ),
                if (phone != null && email != null)
                  const Divider(height: 1, color: AppColors.border),
                if (email != null)
                  _ContactLine(
                    icon: Icons.mail_rounded,
                    color: AppColors.accent,
                    value: email,
                    onTap: onEmail,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        ElevatedButton.icon(
          onPressed: resolving ? null : onResolve,
          icon: resolving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.check_circle_rounded),
          label: Text(
            report.type == ReportType.lost
                ? context.l10n.markPetAsFound(report.petName)
                : context.l10n.markReturnedToOwner,
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        delete,
      ],
    );
  }
}

class _ContactLine extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final VoidCallback onTap;

  const _ContactLine({
    required this.icon,
    required this.color,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: value));
        HapticFeedback.selectionClick();
        SnackbarUtils.showSuccess(context, context.l10n.copiedToClipboard);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: color.withValues(alpha: 0.4),
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

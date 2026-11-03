import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/points.dart';
import 'points_widgets.dart';

const _inactiveColor = Color(0xFF8A9A94);
const _stillUsingColor = Color(0xFF0E7490);

extension InviteBucketView on InviteBucket {
  Color get color => switch (this) {
    InviteBucket.active => AppColors.primary,
    InviteBucket.inactive => _inactiveColor,
    InviteBucket.waiting => pointsColor,
  };

  String label(AppLocalizations l10n) => switch (this) {
    InviteBucket.active => l10n.inviteBucketActive,
    InviteBucket.inactive => l10n.inviteBucketInactive,
    InviteBucket.waiting => l10n.inviteBucketWaiting,
  };
}

extension ReferralStatusView on ReferralStatus {
  String label(AppLocalizations l10n) => switch (this) {
    ReferralStatus.pending => l10n.inviteStatusPending,
    ReferralStatus.qualified => l10n.inviteStatusQualified,
    ReferralStatus.review => l10n.inviteStatusReview,
    ReferralStatus.rejected => l10n.inviteStatusRejected,
    ReferralStatus.expired => l10n.inviteStatusExpired,
  };
}

class InviteCountTile extends StatelessWidget {
  final int value;
  final String label;
  final Color color;
  final IconData? icon;

  const InviteCountTile({
    super.key,
    required this.value,
    required this.label,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    '$value',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.2,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// Tiles in rows of [perRow], each row as tall as its tallest tile.
class _TileGrid extends StatelessWidget {
  final List<Widget> tiles;
  final int perRow;

  const _TileGrid({required this.tiles, required this.perRow});

  @override
  Widget build(BuildContext context) {
    const gap = 8.0;
    return Column(
      children: [
        for (var i = 0; i < tiles.length; i += perRow) ...[
          if (i > 0) const SizedBox(height: gap),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var j = i; j < i + perRow; j++) ...[
                  if (j > i) const SizedBox(width: gap),
                  Expanded(
                    child: j < tiles.length ? tiles[j] : const SizedBox(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// Active / inactive / waiting, for the user's own invites.
class InviteBucketCounts extends StatelessWidget {
  final InviteCounts counts;

  const InviteBucketCounts({super.key, required this.counts});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    int value(InviteBucket b) => switch (b) {
      InviteBucket.active => counts.active,
      InviteBucket.inactive => counts.inactive,
      InviteBucket.waiting => counts.waiting,
    };
    return _TileGrid(
      perRow: 3,
      tiles: [
        for (final bucket in InviteBucket.values)
          InviteCountTile(
            value: value(bucket),
            label: bucket.label(l10n),
            color: bucket.color,
          ),
      ],
    );
  }
}

// Every count, for the admin side.
class InviteCountsGrid extends StatelessWidget {
  final InviteCounts counts;

  const InviteCountsGrid({super.key, required this.counts});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        _TileGrid(
          perRow: 2,
          tiles: [
            InviteCountTile(
              value: counts.qrOpens,
              label: l10n.inviteQrScans,
              color: AppColors.primaryDark,
              icon: Icons.qr_code_2_rounded,
            ),
            InviteCountTile(
              value: counts.linkOpens,
              label: l10n.inviteLinkOpens,
              color: AppColors.primaryDark,
              icon: Icons.link_rounded,
            ),
            InviteCountTile(
              value: counts.joined,
              label: l10n.inviteSignedUp,
              color: AppColors.text,
            ),
            InviteCountTile(
              value: counts.stillUsing,
              label: l10n.inviteStillUsing,
              color: _stillUsingColor,
            ),
          ],
        ),
        const SizedBox(height: 8),
        InviteBucketCounts(counts: counts),
      ],
    );
  }
}

class InviteCountsHelp extends StatelessWidget {
  final int stillUsingDays;

  const InviteCountsHelp({super.key, required this.stillUsingDays});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '${l10n.inviteBucketsHelp} '
            '${l10n.inviteStillUsingHelp(stillUsingDays)}',
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: AppColors.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}

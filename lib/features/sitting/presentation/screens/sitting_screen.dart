import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../domain/sitting.dart';
import '../providers/sitting_provider.dart';
import '../widgets/sitting_widgets.dart';
import 'chat_screens.dart';
import 'request_screens.dart';
import 'sitter_screens.dart';
import '../../../../core/utils/screen_space.dart';

class SittingScreen extends ConsumerStatefulWidget {
  const SittingScreen({super.key});

  @override
  ConsumerState<SittingScreen> createState() => _SittingScreenState();
}

class _SittingScreenState extends ConsumerState<SittingScreen> {
  int _km = 25;
  PetSpecies? _species;

  void _open(Widget screen) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

  Widget _filters() {
    final l10n = context.l10n;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Row(
        children: [
          for (final km in sittingDistancesKm) ...[
            ChoiceChip(
              label: Text('$km km'),
              selected: _km == km,
              showCheckmark: false,
              shape: const StadiumBorder(),
              onSelected: (_) => setState(() => _km = km),
            ),
            const SizedBox(width: 6),
          ],
          const SizedBox(width: 6),
          for (final s in PetSpecies.values) ...[
            FilterChip(
              label: Text(s.label(l10n)),
              selected: _species == s,
              showCheckmark: false,
              shape: const StadiumBorder(),
              onSelected: (on) => setState(() => _species = on ? s : null),
            ),
            const SizedBox(width: 6),
          ],
        ],
      ),
    );
  }

  Widget _list<T>(
    AsyncValue<List<T>> state, {
    required List<Widget> Function(List<T>) build,
    required String empty,
    required IconData icon,
  }) {
    return switch (state) {
      AsyncData(:final value) when build(value).isEmpty => ListView(
        children: [
          _filters(),
          SittingEmpty(icon: icon, text: empty),
        ],
      ),
      AsyncData(:final value) => ListView(
        padding: EdgeInsets.only(bottom: endSpace(context)),
        children: [
          _filters(),
          for (final w in build(value))
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: w,
            ),
        ],
      ),
      AsyncError() => Center(child: Text(context.l10n.actionFailed)),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final profile = ref.watch(userProfileProvider).value;
    final lat = profile?.homeLat, lng = profile?.homeLng;
    final unread = ref.watch(unreadChatsProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(l10n.sitTitle),
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          actions: [
            IconButton(
              tooltip: l10n.sitChats,
              onPressed: () => _open(const ChatsScreen()),
              icon: Badge(
                isLabelVisible: unread > 0,
                label: Text('$unread'),
                child: const Icon(Icons.chat_bubble_outline_rounded),
              ),
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: _Welcome(
                  unread: unread,
                  onNew: () => _open(const RequestFormScreen()),
                  onChats: () => _open(const ChatsScreen()),
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              primary: false,
              automaticallyImplyLeading: false,
              toolbarHeight: 0,
              backgroundColor: AppColors.background,
              surfaceTintColor: Colors.transparent,
              bottom: SittingTabs(
                tabs: [
                  Tab(text: l10n.sitTabRequests),
                  Tab(text: l10n.sitTabSitters),
                  Tab(text: l10n.sitTabMine),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _list<SittingRequest>(
                ref.watch(openRequestsProvider),
                icon: Icons.event_note_outlined,
                empty: l10n.sitNoRequestsNearby,
                build: (list) => [
                  for (final r in nearby(
                    [
                      for (final r in list)
                        if (_species == null || r.species.contains(_species)) r,
                    ],
                    lat: lat,
                    lng: lng,
                    km: _km,
                    latOf: (r) => r.lat,
                    lngOf: (r) => r.lng,
                  ))
                    RequestCard(
                      request: r,
                      km: kmBetween(lat, lng, r.lat, r.lng),
                      onTap: () => _open(RequestDetailScreen(requestId: r.id)),
                    ),
                ],
              ),
              _list<SitterProfile>(
                ref.watch(sittersProvider),
                icon: Icons.person_search_outlined,
                empty: l10n.sitNoSittersNearby,
                build: (list) => [
                  for (final s in nearby(
                    [
                      for (final s in list)
                        if (_species == null || s.species.contains(_species)) s,
                    ],
                    lat: lat,
                    lng: lng,
                    km: _km,
                    latOf: (s) => s.lat,
                    lngOf: (s) => s.lng,
                  ))
                    SitterCard(
                      sitter: s,
                      km: kmBetween(lat, lng, s.lat, s.lng),
                      onTap: () => _open(SitterProfileScreen(uid: s.uid)),
                    ),
                ],
              ),
              const _Mine(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Mine extends ConsumerWidget {
  const _Mine();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final requests = ref.watch(myRequestsProvider).value ?? const [];
    final sitter = ref.watch(mySitterProfileProvider);
    final offers = ref.watch(myOffersProvider).value ?? const [];
    void open(Widget screen) =>
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 12, 16, endSpace(context)),
      children: [
        StatGrid(
          perRow: 3,
          tiles: [
            StatTile(
              icon: Icons.event_note_rounded,
              value: '${requests.length}',
              label: l10n.sitMyRequests,
            ),
            StatTile(
              icon: Icons.local_offer_outlined,
              value: '${offers.length}',
              label: l10n.sitMyOffers,
              color: AppColors.rewardText,
            ),
            StatTile(
              icon: Icons.forum_outlined,
              value: '${ref.watch(unreadChatsProvider)}',
              label: l10n.sitChats,
              color: AppColors.primary,
            ),
          ],
        ),
        const SizedBox(height: 12),
        const SafetyNote(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: SittingTitle(l10n.sitMyRequests)),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: sittingColor),
              onPressed: () => open(const RequestFormScreen()),
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.sitNewRequest),
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (requests.isEmpty)
          Text(
            l10n.sitNoMyRequests,
            style: const TextStyle(color: AppColors.textMuted),
          ),
        for (final r in requests)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: RequestCard(
              request: r,
              onTap: () => open(RequestDetailScreen(requestId: r.id)),
            ),
          ),
        const SizedBox(height: 16),
        SittingTitle(l10n.sitMySitterProfile),
        switch (sitter) {
          AsyncData(value: final s?) => SittingCard(
            onTap: () => open(SitterProfileScreen(uid: s.uid)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SittingAvatar(name: s.name, photoUrl: s.photoUrl),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppColors.text,
                            ),
                          ),
                          Text(
                            s.active
                                ? l10n.sitProfileVisible
                                : l10n.sitProfilePaused,
                            style: TextStyle(
                              fontSize: 13,
                              color: s.active
                                  ? AppColors.primary
                                  : AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => open(SitterFormScreen(existing: s)),
                      child: Text(l10n.sitEdit),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RatingLine(sitter: s),
              ],
            ),
          ),
          AsyncData() => SittingCard(
            tint: sittingColor,
            onTap: () => open(const SitterFormScreen()),
            child: Row(
              children: [
                const Icon(
                  Icons.volunteer_activism_outlined,
                  color: sittingColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.sitBecomeSitter,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.sitBecomeSitterText,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: sittingColor),
              ],
            ),
          ),
          _ => const SizedBox(
            height: 60,
            child: Center(child: CircularProgressIndicator()),
          ),
        },
        if (offers.isNotEmpty) ...[
          const SizedBox(height: 16),
          SittingTitle(l10n.sitMyOffers),
          for (final o in offers)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _OfferRow(offer: o),
            ),
        ],
      ],
    );
  }
}

class _OfferRow extends ConsumerWidget {
  final SittingOffer offer;

  const _OfferRow({required this.offer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final r = ref.watch(sittingRequestProvider(offer.requestId)).value;
    return SittingCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RequestDetailScreen(requestId: offer.requestId),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              r == null
                  ? '…'
                  : '${r.service.label(l10n)} · ${sittingDates(l10n, r.start, r.end)} · ${r.city}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SittingChip(offer.status.label(l10n), color: offer.status.color),
        ],
      ),
    );
  }
}

class _Welcome extends StatelessWidget {
  final int unread;
  final VoidCallback onNew;
  final VoidCallback onChats;

  const _Welcome({
    required this.unread,
    required this.onNew,
    required this.onChats,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: sittingGradient,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: -14,
            top: -10,
            child: Icon(
              Icons.pets_rounded,
              size: 110,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.sitHeroText,
                  style: const TextStyle(
                    fontSize: 14.5,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Flexible(
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          foregroundColor: AppColors.primary,
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: onNew,
                        icon: const Icon(Icons.add_rounded, size: 18),
                        label: Text(
                          l10n.sitNewRequest,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white70),
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: onChats,
                        icon: const Icon(Icons.forum_outlined, size: 18),
                        label: Text(
                          unread > 0
                              ? '${l10n.sitChats} · $unread'
                              : l10n.sitChats,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

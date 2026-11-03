import 'package:CodaMi/features/points/domain/points.dart';
import 'package:CodaMi/features/points/presentation/providers/points_provider.dart';
import 'package:CodaMi/features/points/presentation/screens/admin_invites_screen.dart';
import 'package:CodaMi/features/points/presentation/widgets/invite_stats_widgets.dart';
import 'package:CodaMi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const counts = InviteCounts(
    qrOpens: 1234,
    linkOpens: 567,
    joined: 890,
    active: 456,
    inactive: 123,
    waiting: 78,
    stillUsing: 345,
  );
  final stats = InviteStats(
    code: 'QWE789',
    counts: counts,
    friends: [
      InvitedFriend(
        inviteeId: 'a',
        name: 'Alessandra Maria Bianchi-Ferraris',
        status: ReferralStatus.qualified,
        createdAt: DateTime(2026, 10, 1),
        lastActiveDay: DateTime(2026, 11, 3),
        stillUsing: true,
      ),
      const InvitedFriend(
        inviteeId: 'b',
        name: '',
        status: ReferralStatus.expired,
      ),
    ],
  );
  final ranking = InviteRanking(
    totals: counts,
    inviters: 250,
    rows: [
      for (var i = 0; i < 5; i++)
        InviteRankingRow(
          uid: 'u$i',
          name: 'Very Long User Name Number $i',
          email: 'x@y.z',
          code: 'ABC23$i',
          counts: counts,
        ),
    ],
  );

  for (final locale in const [Locale('en'), Locale('de'), Locale('ar')]) {
    Widget app(Widget home) => ProviderScope(
      overrides: [
        adminInviteStatsProvider.overrideWith((ref, uid) async => stats),
        adminInviteRankingProvider.overrideWith((ref, args) async => ranking),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );

    testWidgets('layouts fit on a small phone ($locale)', (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        app(const AdminUserInvitesScreen(uid: 'x', name: 'Marta')),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(app(const AdminInvitesScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.drag(find.byType(ListView), const Offset(0, -1500));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(
        app(
          const Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AdminUserInvitesCard(uid: 'x', name: 'M'),
                  InviteBucketCounts(counts: counts),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('boxes in a row are the same height ($locale)', (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        app(
          const Scaffold(
            body: SingleChildScrollView(
              child: InviteCountsGrid(counts: counts),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final boxes = tester
          .widgetList<InviteCountTile>(find.byType(InviteCountTile))
          .map((tile) => tester.getRect(find.byWidget(tile)))
          .toList();
      expect(boxes, hasLength(7));
      for (final row in [
        boxes.sublist(0, 2),
        boxes.sublist(2, 4),
        boxes.sublist(4),
      ]) {
        for (final box in row) {
          expect(box.top, row.first.top);
          expect(box.height, row.first.height);
        }
      }
    });
  }
}

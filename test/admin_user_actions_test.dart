import 'dart:async';

import 'package:CodaMi/features/admin/presentation/providers/admin_provider.dart';
import 'package:CodaMi/features/admin/presentation/screens/admin_user_screen.dart';
import 'package:CodaMi/features/auth/data/models/user_model.dart';
import 'package:CodaMi/features/auth/presentation/providers/auth_provider.dart';
import 'package:CodaMi/features/points/data/points_repository.dart';
import 'package:CodaMi/features/points/domain/points.dart';
import 'package:CodaMi/features/points/presentation/providers/points_provider.dart';
import 'package:CodaMi/features/profile/presentation/providers/profile_provider.dart';
import 'package:CodaMi/features/titles/data/titles_repository.dart';
import 'package:CodaMi/features/titles/domain/titles.dart';
import 'package:CodaMi/features/titles/presentation/providers/titles_provider.dart';
import 'package:CodaMi/features/titles/presentation/widgets/admin_user_titles_card.dart';
import 'package:CodaMi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Saving waits until the test lets it finish, so the spinner can be checked.
class _FakePoints implements PointsRepository {
  final done = Completer<void>();
  (String, int, String)? saved;

  @override
  Future<void> adjust(String uid, int amount, String reason) async {
    saved = (uid, amount, reason);
    await done.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeTitles implements TitlesRepository {
  final done = Completer<void>();
  (String, int, String)? donation;
  (String, TitleId, int?)? title;

  @override
  Stream<Achievements> watchAchievements(String uid) =>
      Stream.value(const Achievements());

  @override
  Stream<List<Donation>> watchDonations(String uid) => Stream.value(const []);

  @override
  Future<void> recordDonation(String uid, int cents, String note) async {
    donation = (uid, cents, note);
    await done.future;
  }

  @override
  Future<void> adminSetTitle(String uid, TitleId id, int? level) async {
    title = (uid, id, level);
    await done.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _app(Widget home, List overrides) => ProviderScope(
  overrides: [
    authStateProvider.overrideWith((ref) => Stream.value(null)),
    pointsConfigProvider.overrideWith(
      (ref) => Stream.value(const PointsConfig()),
    ),
    titlesConfigProvider.overrideWith(
      (ref) => Stream.value(const TitlesConfig()),
    ),
    ...overrides,
  ],
  child: MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: home),
  ),
);

void main() {
  testWidgets('adjusting points: add or remove, quick amounts, new balance', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final points = _FakePoints();
    await tester.pumpWidget(
      _app(const AdminUserScreen(uid: 'u1'), [
        adminUserProvider.overrideWith(
          (ref, uid) => Stream.value(
            UserModel(
              uid: 'u1',
              name: 'Ana',
              email: 'ana@x.it',
              createdAt: DateTime(2026),
              points: 120,
            ),
          ),
        ),
        userReportCountProvider.overrideWith((ref, uid) async => 0),
        userRoleProvider.overrideWithValue(UserRole.support),
        pointsRepositoryProvider.overrideWithValue(points),
      ]),
    );
    await tester.pumpAndSettle();

    final adjust = find.widgetWithIcon(OutlinedButton, Icons.exposure_rounded);
    await tester.scrollUntilVisible(
      adjust,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(adjust);
    await tester.pumpAndSettle();
    expect(find.text('Current balance'), findsOneWidget);
    expect(find.text('120'), findsOneWidget);

    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('−250'));
    await tester.pumpAndSettle();
    expect(find.text('They only have 120 points.'), findsOneWidget);
    expect(
      find.text('-130'),
      findsOneWidget,
      reason: 'the new balance shows red',
    );

    await tester.tap(find.text('−50'));
    await tester.tap(find.text('Correction'));
    await tester.pumpAndSettle();
    expect(find.text('They only have 120 points.'), findsNothing);
    expect(find.text('70'), findsOneWidget);

    await tester.tap(find.text('Remove 50 points'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(points.saved, ('u1', -50, 'Correction'));

    points.done.complete();
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(
      find.text('Current balance'),
      findsNothing,
      reason: 'closed after saving',
    );
    expect(find.text('Saved'), findsOneWidget);
  });

  testWidgets('recording a donation and giving a title show a spinner', (
    tester,
  ) async {
    final titles = _FakeTitles();
    await tester.pumpWidget(
      _app(const SingleChildScrollView(child: AdminUserTitlesCard(uid: 'u1')), [
        titlesRepositoryProvider.overrideWithValue(titles),
      ]),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Record a donation'));
    await tester.pumpAndSettle();
    final fields = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextField),
    );
    await tester.enterText(fields.at(0), '25');
    await tester.enterText(fields.at(1), 'Bank transfer');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(titles.donation, ('u1', 2500, 'Bank transfer'));
    titles.done.complete();
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Give a title'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Give a title'));
    await tester.pumpAndSettle();
    expect(titles.title, ('u1', TitleId.partner, 1));
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

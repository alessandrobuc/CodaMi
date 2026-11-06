import 'package:CodaMi/features/auth/presentation/providers/auth_provider.dart';
import 'package:CodaMi/features/donations/data/donations_repository.dart';
import 'package:CodaMi/features/donations/domain/donations.dart';
import 'package:CodaMi/features/points/domain/points.dart';
import 'package:CodaMi/features/points/presentation/providers/points_provider.dart';
import 'package:CodaMi/features/titles/data/titles_repository.dart';
import 'package:CodaMi/features/titles/domain/titles.dart';
import 'package:CodaMi/features/titles/presentation/providers/titles_provider.dart';
import 'package:CodaMi/features/titles/presentation/screens/achievements_screen.dart';
import 'package:CodaMi/features/titles/presentation/screens/admin_titles_screen.dart';
import 'package:CodaMi/features/titles/presentation/title_celebration.dart';
import 'package:CodaMi/features/titles/presentation/widgets/title_labels.dart';
import 'package:CodaMi/l10n/app_localizations.dart';
import 'package:CodaMi/l10n/app_localizations_en.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRepo implements TitlesRepository {
  @override
  Future<void> refresh() async {}

  @override
  Future<int> holders(TitleId id) async => 7;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const _mins = [1, 5, 15, 30];

void main() {
  const config = TitlesConfig(enabled: true);

  test('settings fall back to the agreed numbers', () {
    final d = TitlesConfig.fromMap(null);
    expect(d.enabled, isFalse);
    expect(d.levels[TitleId.rescuer], [1, 3, 10]);
    expect(d.bonus, [10, 25, 50]);
    expect(d.donorCents, [1000, 2500, 5000, 10000, 25000]);
    final c = TitlesConfig.fromMap({
      'enabled': true,
      'off': ['sitter', 'nope'],
      'levels': {
        'rescuer': [3, 2, 1],
        'advocate': [2, 4, 8],
      },
      'bonus': [0, 5, 9],
      'donorCents': [50, 100],
    });
    expect(c.off, {TitleId.sitter});
    expect(c.levels[TitleId.rescuer], [1, 3, 10], reason: 'levels must rise');
    expect(c.levels[TitleId.advocate], [2, 4, 8]);
    expect(c.bonus, [0, 5, 9]);
    expect(c.donorCents, defaultDonorCents);
    expect(TitlesConfig.fromMap(c.toMap()).levels, c.levels);
    expect(TitlesConfig.validLevels([1, 1, 2]), isFalse);
    expect(TitlesConfig.validDonor([100, 200, 300, 400, 500]), isTrue);
  });

  test('saved titles, counts and choices are read from the account', () {
    final a = Achievements.fromMap({
      'counts': {
        'reports': 6,
        'rescues': 1,
        'activeDays': 40,
        'donorCents': 3000,
      },
      'levels': {
        'contributor': 2,
        'rescuer': 1,
        'donor': 3,
        'king': 1,
        'trusted': 0,
      },
      'granted': {'partner': 1},
      'revoked': ['advocate'],
      'unlockedAt': {'rescuer_1': Timestamp.fromDate(DateTime(2026, 11, 6))},
      'main': 'rescuer',
      'hideDonor': true,
    });
    expect(a.levels, {
      TitleId.contributor: 2,
      TitleId.rescuer: 1,
      TitleId.donor: 3,
    });
    expect(a.count(TitleId.contributor), 6);
    expect(a.count(TitleId.donor), 3000);
    expect(a.revoked, {TitleId.advocate});
    expect(a.unlockedAt['rescuer_1'], DateTime(2026, 11, 6));
    expect(a.main, TitleId.rescuer);
    expect(a.hideDonor, isTrue);
    expect(
      a.unlockedKeys,
      containsAll(['contributor_1', 'contributor_2', 'donor_3']),
    );
    final pub = PublicTitles.fromMap({
      'title': {'id': 'rescuer', 'level': 2},
      'tags': [
        {'id': 'rescuer', 'level': 2},
        {'id': 'bad', 'level': 1},
      ],
    });
    expect(pub.title, const TitleLevel(TitleId.rescuer, 2));
    expect(pub.tags.length, 1);
  });

  test('progress to the next level and the next goal', () {
    final a = Achievements.fromMap({
      'counts': {'reports': 3, 'rescues': 2, 'shares': 1, 'invites': 4},
      'levels': {'contributor': 1, 'rescuer': 1},
    });
    final p = progressOf(TitleId.contributor, a, config, _mins);
    expect([p.level, p.current, p.next, p.maxLevel], [1, 3, 5, 3]);
    expect(p.fraction, closeTo(0.6, 0.001));
    final done = progressOf(
      TitleId.contributor,
      Achievements.fromMap({
        'counts': {'reports': 30},
        'levels': {'contributor': 3},
      }),
      config,
      _mins,
    );
    expect(done.complete, isTrue);
    expect(done.fraction, 1);
    expect(progressOf(TitleId.ambassador, a, config, _mins).maxLevel, 4);
    expect(progressOf(TitleId.donor, a, config, _mins).next, 1);
    expect(
      nextGoal(a, config, _mins),
      TitleId.ambassador,
      reason: '4 of 5 friends is the closest',
    );
  });

  test('on hold, switched off and given by hand', () {
    final held = Achievements.fromMap({
      'counts': {'activeDays': 200, 'sittings': 4},
    });
    expect(titlePaused(TitleId.trusted, held, config), isTrue);
    expect(titlePaused(TitleId.sitter, held, config), isTrue);
    expect(titlePaused(TitleId.contributor, held, config), isFalse);
    final off = const TitlesConfig(off: {TitleId.advocate});
    final partner = Achievements.fromMap({
      'levels': {'partner': 1},
    });
    final shown = shownTitles(off, partner);
    expect(shown, isNot(contains(TitleId.advocate)));
    expect(shown, contains(TitleId.partner));
    expect(
      shownTitles(off, const Achievements()),
      isNot(contains(TitleId.team)),
    );
  });

  test('a celebration only for levels not seen yet', () {
    final fresh = freshTitles(
      {'rescuer_1', 'rescuer_2', 'contributor_1', 'donor_3'},
      {'contributor_1'},
    );
    expect(
      fresh,
      containsAll([
        const TitleLevel(TitleId.rescuer, 2),
        const TitleLevel(TitleId.donor, 3),
      ]),
    );
    expect(fresh.length, 2);
    expect(freshTitles({'rescuer_1'}, {'rescuer_1'}), isEmpty);
  });

  test('names for every level', () {
    final l10n = AppLocalizationsEn();
    expect(
      const TitleLevel(TitleId.rescuer, 2).name(l10n),
      'Animal Rescuer ★★',
    );
    expect(const TitleLevel(TitleId.donor, 1).name(l10n), 'Supporter');
    expect(const TitleLevel(TitleId.donor, 6).name(l10n), 'Lifetime Supporter');
    expect(
      const TitleLevel(TitleId.ambassador, 1).name(l10n),
      'Friend of CodaMi',
    );
    expect(const TitleLevel(TitleId.partner, 1).name(l10n), 'Partner Shelter');
    expect(const TitleLevel(TitleId.donor, 4).emoji, '🥇');
    for (final id in TitleId.values) {
      expect(id.name(l10n), isNotEmpty);
      expect(id.how(l10n), isNotEmpty);
    }
    expect(centsLabel(2500), contains('25'));
  });

  for (final locale in const [Locale('en'), Locale('de'), Locale('ar')]) {
    Widget app(Widget home) => ProviderScope(
      overrides: [
        authStateProvider.overrideWith((ref) => Stream.value(null)),
        titlesRepositoryProvider.overrideWithValue(_FakeRepo()),
        titlesConfigProvider.overrideWith((ref) => Stream.value(config)),
        pointsConfigProvider.overrideWith(
          (ref) => Stream.value(const PointsConfig()),
        ),
        donationsConfigProvider.overrideWith(
          (ref) => Stream.value(const DonationsConfig(enabled: true)),
        ),
        myAchievementsProvider.overrideWith(
          (ref) => Stream.value(
            Achievements.fromMap({
              'counts': {
                'reports': 7,
                'rescues': 2,
                'helps': 1,
                'shares': 30,
                'activeDays': 120,
                'invites': 6,
                'donorCents': 3500,
              },
              'levels': {
                'contributor': 2,
                'rescuer': 1,
                'volunteer': 1,
                'advocate': 2,
                'trusted': 2,
                'ambassador': 2,
                'donor': 3,
                'partner': 1,
              },
              'main': 'rescuer',
            }),
          ),
        ),
        publicTitlesProvider.overrideWith(
          (ref, uid) => Stream.value(
            const PublicTitles(title: TitleLevel(TitleId.rescuer, 1)),
          ),
        ),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );

    testWidgets('achievement screens fit on a small phone ($locale)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(app(const AchievementsScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      for (var i = 0; i < 6; i++) {
        await tester.drag(find.byType(ListView), const Offset(0, -500));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }

      await tester.pumpWidget(const SizedBox());
      await tester.pumpWidget(app(const AdminTitlesScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      for (var i = 0; i < 8; i++) {
        await tester.drag(find.byType(ListView), const Offset(0, -600));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
    });
  }
}

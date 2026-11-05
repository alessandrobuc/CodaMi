import 'package:CodaMi/features/auth/presentation/providers/auth_provider.dart';
import 'package:CodaMi/features/notifications/domain/entities/notification_prefs.dart';
import 'package:CodaMi/features/points/presentation/providers/points_provider.dart';
import 'package:CodaMi/features/points/presentation/screens/invite_screen.dart';
import 'package:CodaMi/features/sharing/domain/sharing.dart';
import 'package:CodaMi/features/sharing/presentation/providers/sharing_provider.dart';
import 'package:CodaMi/features/sharing/presentation/screens/admin_share_reminders_screen.dart';
import 'package:CodaMi/features/sharing/presentation/screens/share_app_screen.dart';
import 'package:CodaMi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('settings fall back to the agreed defaults', () {
    const d = ShareReminderConfig();
    expect([d.enabled, d.firstDays, d.everyDays, d.maxCount], [false, 3, 7, 8]);
    final c = ShareReminderConfig.fromMap({
      'enabled': true,
      'firstDays': 0,
      'everyDays': 1,
      'maxCount': 20,
    });
    expect([c.enabled, c.firstDays, c.everyDays, c.maxCount], [true, 3, 7, 20]);
    expect(ShareReminderConfig.validEvery(2), isFalse);
    expect(ShareReminderConfig.validMax(53), isFalse);
  });

  test('open rate and the same-day guard', () {
    final s =
        ShareReminderStats.fromMap({'sent': 8, 'opened': 2, 'shares': 1}) +
        const ShareReminderStats(sent: 2, opened: 1);
    expect([s.sent, s.opened, s.shares, s.openRate], [10, 3, 1, 30]);
    expect(const ShareReminderStats().openRate, 0);

    final now = DateTime(2026, 11, 5, 19);
    shareReminderOpenedAt = null;
    expect(openedShareReminderToday(now), isFalse);
    shareReminderOpenedAt = DateTime(2026, 11, 5, 18, 5);
    expect(openedShareReminderToday(now), isTrue);
    expect(openedShareReminderToday(DateTime(2026, 11, 6, 9)), isFalse);
    shareReminderOpenedAt = null;
  });

  test('share reminders are their own notification switch, on by default', () {
    expect(AlertType.values.last, AlertType.share);
    final prefs = NotificationPrefs.fromMap({
      'share': {'enabled': false},
    });
    expect(prefs[AlertType.share].enabled, isFalse);
    expect(prefs[AlertType.lost].enabled, isTrue);
    expect(const NotificationPrefs()[AlertType.share].enabled, isTrue);
  });

  for (final locale in const [Locale('en'), Locale('de'), Locale('ar')]) {
    Widget app(Widget home) => ProviderScope(
      overrides: [
        authStateProvider.overrideWith((ref) => Stream.value(null)),
        myInviteCodeProvider.overrideWith((ref) async => 'ABC234'),
        myInvitesProvider.overrideWith((ref) => Stream.value(const [])),
        shareReminderConfigProvider.overrideWith(
          (ref) => Stream.value(const ShareReminderConfig(enabled: true)),
        ),
        shareReminderTotalsProvider.overrideWith(
          (ref) => Stream.value(
            const ShareReminderStats(sent: 120, opened: 30, shares: 12),
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

    testWidgets('share reminder screens fit on a small phone ($locale)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        app(const ShareAppScreen(fromReminder: true, preview: true)),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.textContaining('ABC234'), findsOneWidget);
      await tester.drag(find.byType(ListView), const Offset(0, -2000));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpWidget(
        app(
          const Scaffold(
            body: Center(child: JoinPoster(code: 'ABC234')),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(app(const AdminShareRemindersScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.drag(find.byType(ListView), const Offset(0, -2000));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}

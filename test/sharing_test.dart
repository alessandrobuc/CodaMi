import 'package:CodaMi/features/auth/presentation/providers/auth_provider.dart';
import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:CodaMi/features/reports/domain/entities/reports_entity.dart';
import 'package:CodaMi/features/reports/presentation/providers/reports_provider.dart';
import 'package:CodaMi/features/sharing/domain/sharing.dart';
import 'package:CodaMi/features/sharing/presentation/providers/sharing_provider.dart';
import 'package:CodaMi/features/sharing/presentation/screens/admin_sharing_screen.dart';
import 'package:CodaMi/features/sharing/presentation/share_sheet.dart';
import 'package:CodaMi/features/sharing/presentation/widgets/report_poster.dart';
import 'package:CodaMi/l10n/app_localizations.dart';
import 'package:CodaMi/l10n/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

Report report({
  ReportType type = ReportType.lost,
  ReportStatus status = ReportStatus.open,
  String name = 'Principessa Luna della Valle',
}) => Report(
  id: 'abc123',
  ownerId: 'u1',
  ownerName: 'Mario Rossi',
  type: type,
  petName: name,
  species: PetSpecies.dog,
  description: 'Shy, red collar',
  photoUrls: const [],
  country: 'IT',
  city: "Reggio nell'Emilia",
  cityKey: 'reggio',
  placeDetail: 'Via Emilia San Pietro',
  areaRadius: 500,
  lat: 44.7,
  lng: 10.6,
  eventAt: DateTime.utc(2026, 11, 3, 9),
  status: status,
  contactPhone: '+39 333 1234567',
  contactEmail: 'mario@example.com',
  reward: 150,
);

void main() {
  setUpAll(() => initializeDateFormatting('en'));

  test('report links carry the language and source', () {
    expect(reportLink('abc123'), 'https://codami-cd91e.web.app/r/abc123');
    expect(
      reportLink('abc123', lang: 'it', source: ShareTarget.whatsapp),
      'https://codami-cd91e.web.app/r/abc123?l=it&s=whatsapp',
    );
  });

  test('app links open the right report and nothing else', () {
    expect(reportIdOfLink(Uri.parse('codami://report/abc123')), 'abc123');
    expect(
      reportIdOfLink(Uri.parse('https://codami-cd91e.web.app/r/abc123?l=it')),
      'abc123',
    );
    expect(reportIdOfLink(Uri.parse('codami://other/abc')), isNull);
    expect(reportIdOfLink(Uri.parse('codami://report/a%2Fb')), isNull);
    expect(reportIdOfLink(Uri.parse('https://example.com/x')), isNull);
  });

  test('share texts have the status, link and no private contact', () {
    final l10n = AppLocalizationsEn();
    final link = reportLink('abc123', source: ShareTarget.more);
    final lost = shareMessage(l10n, report(), ShareKind.announce, link);
    expect(lost, contains('LOST Dog: Principessa Luna della Valle'));
    expect(lost, contains('€150'));
    expect(lost, contains(link));
    expect(lost, isNot(contains('333')));
    expect(lost, isNot(contains('mario@')));
    expect(lost, isNot(contains('#CodaMi')));

    final insta = shareMessage(
      l10n,
      report(),
      ShareKind.announce,
      link,
      hashtags: true,
    );
    expect(insta, contains('#CodaMi #LostPet #ReggionellEmilia'));

    final found = shareMessage(
      l10n,
      report(type: ReportType.found, name: ''),
      ShareKind.announce,
      link,
    );
    expect(found, contains('FOUND Dog'));
    expect(found, isNot(contains('€150')));

    final home = shareMessage(
      l10n,
      report(status: ReportStatus.resolved),
      ShareKind.reunited,
      link,
    );
    expect(home, contains('is back home'));
    expect(home, isNot(contains('€150')));
  });

  test('share numbers add up across days', () {
    final a = ShareStats.fromMap({
      'shares': 2,
      'views': 5,
      'byTarget': {'whatsapp': 2},
      'viewsBy': {'qr': 5},
    });
    final b = ShareStats.fromMap({
      'shares': 1,
      'byTarget': {'whatsapp': 1, 'tiktok': 'x'},
    });
    final sum = a + b;
    expect(sum.shares, 3);
    expect(sum.views, 5);
    expect(sum.byTarget, {'whatsapp': 3});
  });

  for (final locale in const [Locale('en'), Locale('de'), Locale('ar')]) {
    Widget app(Widget home) => ProviderScope(
      overrides: [
        reportProvider.overrideWith((ref, id) => Stream.value(null)),
        authStateProvider.overrideWith((ref) => Stream.value(null)),
        sharingConfigProvider.overrideWith(
          (ref) => Stream.value(const SharingConfig(popup: true)),
        ),
        shareTotalsProvider.overrideWith(
          (ref) => Stream.value(
            const ShareStats(
              shares: 12,
              views: 40,
              byTarget: {'whatsapp': 8, 'instagram': 4},
              viewsBy: {'whatsapp': 30, 'qr': 10},
            ),
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

    testWidgets('share screens fit on a small phone ($locale)', (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      for (final (r, kind) in [
        (report(), ShareKind.announce),
        (report(type: ReportType.found, name: ''), ShareKind.announce),
        (report(status: ReportStatus.resolved), ShareKind.reunited),
      ]) {
        await tester.pumpWidget(
          app(
            Scaffold(
              body: Center(
                child: ReportPoster(report: r, kind: kind, link: 'https://x'),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        await tester.pumpWidget(
          app(
            Scaffold(
              body: ShareSheet(report: r, kind: kind, prompt: true),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byIcon(Icons.close_rounded), findsOneWidget);
      }

      await tester.pumpWidget(app(const AdminSharingScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}

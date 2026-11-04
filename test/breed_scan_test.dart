import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:CodaMi/features/scanner/domain/breed_scan.dart';
import 'package:CodaMi/features/scanner/presentation/screens/admin_scanner_screen.dart';
import 'package:CodaMi/features/scanner/presentation/screens/scanner_screen.dart';
import 'package:CodaMi/features/scanner/presentation/providers/scanner_provider.dart';
import 'package:CodaMi/features/scanner/presentation/widgets/scanner_widgets.dart';
import 'package:CodaMi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final answer = {
    'animalFound': true,
    'species': 'dog',
    'speciesName': 'Cane',
    'mixed': true,
    'breeds': [
      {'name': 'Beagle', 'confidence': 22},
      {'name': 'Labrador Retriever', 'confidence': 64},
      {'name': '', 'confidence': 10},
    ],
    'photoQuality': 'poor',
    'info': {
      'size': 'Media',
      'weight': '20-30 kg',
      'lifeSpan': '',
      'temperament': 'Socievole',
    },
    'note': 'Orecchie da beagle',
  };

  test('the server answer becomes a scan, most likely breed first', () {
    final scan = BreedScan.fromMap(answer);
    expect(scan.animalFound, isTrue);
    expect(scan.species, PetSpecies.dog);
    expect(scan.top!.name, 'Labrador Retriever');
    expect(scan.others.map((b) => b.name), ['Beagle']);
    expect(scan.mixed, isTrue);
    expect(scan.poorPhoto, isTrue);
    expect(scan.facts.keys, [
      BreedFact.size,
      BreedFact.weight,
      BreedFact.temperament,
    ]);
    expect(scan.breedForPet, 'Labrador Retriever × Beagle');
  });

  test('no animal: nothing to show or save', () {
    final scan = BreedScan.fromMap({
      'animalFound': true,
      'breeds': const [],
      'info': {'size': 'Big'},
    });
    expect(scan.animalFound, isFalse);
    expect(scan.facts, isEmpty);
    expect(scan.breedForPet, '');
  });

  test('breed saved on a pet fits the 60-character field', () {
    final scan = BreedScan.fromMap({
      'animalFound': true,
      'mixed': true,
      'breeds': [
        {'name': 'A' * 50, 'confidence': 60},
        {'name': 'B' * 50, 'confidence': 30},
      ],
    });
    expect(scan.breedForPet.length, lessThanOrEqualTo(60));
  });

  test('confidence levels and settings', () {
    expect(ScanConfidence.of(85), ScanConfidence.high);
    expect(ScanConfidence.of(70), ScanConfidence.high);
    expect(ScanConfidence.of(45), ScanConfidence.medium);
    expect(ScanConfidence.of(12), ScanConfidence.low);
    final c = ScannerConfig.fromMap({
      'enabled': true,
      'dailyScans': 500,
      'model': 'not a model',
    });
    expect(c.enabled, isTrue);
    expect(c.dailyScans, 10);
    expect(c.model, defaultScannerModel);
    expect(scannerModelPattern.hasMatch('gemini-3.5-flash-lite'), isTrue);
    expect(scannerModelPattern.hasMatch('gemini-3/../x'), isFalse);
  });

  test('model list from the server', () {
    final m = ScannerModels.fromMap({
      'models': [
        {'id': 'gemini-3.8-flash', 'tier': 'flash'},
        {'id': 'gemini-3.5-flash-lite', 'tier': 'lite'},
        {'id': 'bad model', 'tier': 'pro'},
        {'tier': 'pro'},
      ],
      'recommended': 'gemini-3.8-flash',
      'fromGoogle': false,
    });
    expect(m.options.map((o) => o.$1), [
      'gemini-3.8-flash',
      'gemini-3.5-flash-lite',
    ]);
    expect(m.options[1].$2, ModelTier.lite);
    expect(m.fromGoogle, isFalse);
    expect(m.offers('gemini-3.8-flash'), isTrue);
    expect(m.offers('gemini-2.0-flash'), isFalse);
  });

  const models = ScannerModels(
    options: [
      ('gemini-4-argon', ModelTier.pro),
      ('gemini-3.8-flash', ModelTier.flash),
      ('gemini-3.5-flash-lite', ModelTier.lite),
    ],
  );

  for (final locale in const [Locale('en'), Locale('de'), Locale('ar')]) {
    Widget app(Widget home) => ProviderScope(
      overrides: [
        scannerConfigProvider.overrideWith(
          (ref) => Stream.value(const ScannerConfig()),
        ),
        scannerModelsProvider.overrideWith((ref) async => models),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );

    testWidgets('scanner screens fit on a small phone ($locale)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(app(const ScannerScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      final long = BreedScan.fromMap({
        ...answer,
        'breeds': [
          {'name': 'Cavalier King Charles Spaniel', 'confidence': 100},
          {'name': 'Nova Scotia Duck Tolling Retriever', 'confidence': 0},
        ],
        'info': {for (final f in BreedFact.values) f.name: 'x ' * 120},
      });
      await tester.pumpWidget(
        app(
          Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: BreedScanResult(scan: long),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Cavalier King Charles Spaniel'), findsOneWidget);

      await tester.pumpWidget(
        app(
          Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: ScannerPromoCard(onTap: () {}),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(app(const AdminScannerScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // The model picker lists Google's models and the choice is kept.
      await tester.ensureVisible(find.text('gemini-3.8-flash'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('gemini-3.8-flash'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('gemini-4-argon'), findsOneWidget);
      await tester.tap(find.text('gemini-3.5-flash-lite'));
      await tester.pumpAndSettle();
      expect(find.text('gemini-4-argon'), findsNothing);
      expect(find.text('gemini-3.5-flash-lite'), findsOneWidget);
    });
  }
}

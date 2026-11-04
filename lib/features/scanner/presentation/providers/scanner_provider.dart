import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/scanner_repository.dart';
import '../../domain/breed_scan.dart';

final scannerRepositoryProvider = Provider((ref) => ScannerRepository());

final scannerConfigProvider = StreamProvider<ScannerConfig>(
  (ref) => ref.watch(scannerRepositoryProvider).watchConfig(),
);

final scannerEnabledProvider = Provider<bool>(
  (ref) => ref.watch(scannerConfigProvider).value?.enabled ?? false,
);

final scannerModelsProvider = FutureProvider.autoDispose<ScannerModels>(
  (ref) => ref.watch(scannerRepositoryProvider).models(),
  retry: (_, _) => null,
);

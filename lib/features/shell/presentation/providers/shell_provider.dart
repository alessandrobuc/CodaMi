import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../reports/domain/entities/reports_entity.dart';

class ShellTab extends Notifier<int> {
  @override
  int build() => 0;

  void select(int index) => state = index;
}

final shellTabProvider = NotifierProvider<ShellTab, int>(ShellTab.new);

class MapFocus extends Notifier<Report?> {
  @override
  Report? build() => null;

  void show(Report report) => state = report;

  void clear() => state = null;
}

final mapFocusProvider = NotifierProvider<MapFocus, Report?>(MapFocus.new);

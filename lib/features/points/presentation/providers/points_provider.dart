import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../l10n/locale_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/points_repository.dart';
import '../../domain/points.dart';

final pointsConfigProvider = StreamProvider<PointsConfig>(
  (ref) => ref.watch(pointsRepositoryProvider).watchConfig(),
);

final pointsLedgerProvider = StreamProvider<List<PointsEntry>>((ref) {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return Stream.value(const []);
  return ref.watch(pointsRepositoryProvider).watchLedger(uid);
});

final myInvitesProvider = StreamProvider<List<Referral>>((ref) {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return Stream.value(const []);
  return ref.watch(pointsRepositoryProvider).watchInvitesBy(uid);
});

final myReferralProvider = StreamProvider<Referral?>((ref) {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return Stream.value(null);
  return ref.watch(pointsRepositoryProvider).watchMyReferral(uid);
});

final invitesToReviewProvider = StreamProvider<List<Referral>>(
  (ref) => ref.watch(pointsRepositoryProvider).watchToReview(),
);

class _Lifecycle with WidgetsBindingObserver {
  final void Function(AppLifecycleState) onChange;

  _Lifecycle(this.onChange);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => onChange(state);
}

// Seconds the app has been open on screen today (Italian day), kept on the phone.
class ActiveTime extends Notifier<int> {
  static const _tick = Duration(seconds: 15);
  static const _dayKey = 'active_day';
  static const _secondsKey = 'active_seconds';

  Timer? _timer;
  String _day = '';

  @override
  int build() {
    final lifecycle = _Lifecycle((state) {
      if (state == AppLifecycleState.resumed) {
        _start();
      } else if (state == AppLifecycleState.paused) {
        _timer?.cancel();
      }
    });
    WidgetsBinding.instance.addObserver(lifecycle);
    ref.onDispose(() {
      _timer?.cancel();
      WidgetsBinding.instance.removeObserver(lifecycle);
    });
    _load();
    return 0;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _day = romeDayKey(DateTime.now());
    if (prefs.getString(_dayKey) == _day) {
      state = prefs.getInt(_secondsKey) ?? 0;
    }
    _start();
  }

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(_tick, (_) => _add(_tick.inSeconds));
  }

  Future<void> _add(int seconds) async {
    final today = romeDayKey(DateTime.now());
    final next = today == _day ? state + seconds : seconds;
    _day = today;
    state = next;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dayKey, today);
    await prefs.setInt(_secondsKey, next);
  }
}

final activeTimeProvider = NotifierProvider<ActiveTime, int>(ActiveTime.new);

class DailyTaskView {
  final DailyTask task;
  final int points;
  final bool claimed;
  final bool ready;

  const DailyTaskView({
    required this.task,
    required this.points,
    required this.claimed,
    required this.ready,
  });

  bool get claimable => ready && !claimed;
}

class DailyView {
  final List<DailyTaskView> tasks;
  final int streak;
  final int streakDays;
  final int streakBonus;
  final int activeMinutes;
  final int minutesToday;

  const DailyView({
    required this.tasks,
    required this.streak,
    required this.streakDays,
    required this.streakBonus,
    required this.activeMinutes,
    required this.minutesToday,
  });

  bool get hasClaimable => tasks.any((t) => t.claimable);
}

final dailyViewProvider = Provider<DailyView>((ref) {
  final config = ref.watch(pointsConfigProvider).value ?? const PointsConfig();
  final daily =
      ref.watch(userProfileProvider).value?.daily ?? const DailyState();
  final minutes = ref.watch(activeTimeProvider) ~/ 60;
  final now = DateTime.now();
  final today = romeDayKey(now);
  final yesterday = romeDayKey(now.subtract(const Duration(days: 1)));
  return DailyView(
    tasks: [
      for (final task in DailyTask.values)
        if (config.pointsFor(task) > 0)
          DailyTaskView(
            task: task,
            points: config.pointsFor(task),
            claimed: daily.claimedToday(task, today),
            ready: task != DailyTask.active || minutes >= config.activeMinutes,
          ),
    ],
    streak: daily.currentStreak(today, yesterday),
    streakDays: config.streakDays,
    streakBonus: config.streakBonus,
    activeMinutes: config.activeMinutes,
    minutesToday: minutes,
  );
});

const _invitePromptSeenKey = 'invite_prompt_seen';

// Accounts on this phone that were already asked for an invite code after sign-up.
class InvitePromptSeenNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {
    ...?ref.read(sharedPreferencesProvider).getStringList(_invitePromptSeenKey),
  };

  Future<void> markSeen(String uid) async {
    if (state.contains(uid)) return;
    state = {...state, uid};
    await ref
        .read(sharedPreferencesProvider)
        .setStringList(_invitePromptSeenKey, state.toList());
  }
}

final invitePromptSeenProvider =
    NotifierProvider<InvitePromptSeenNotifier, Set<String>>(
      InvitePromptSeenNotifier.new,
    );

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/notifications_repository.dart';
import '../../data/push_service.dart';
import '../../domain/entities/notification_entity.dart';

final notificationsRepositoryProvider = Provider(
  (ref) => NotificationsRepository(),
);

final pushServiceProvider = Provider((ref) => PushService());

final notificationsProvider = StreamProvider<List<AppNotification>>((ref) {
  final uid = ref.watch(authStateProvider.select((s) => s.value?.uid));
  if (uid == null) return Stream.value(const []);
  return ref.watch(notificationsRepositoryProvider).watch(uid);
});

final unreadNotificationsProvider = Provider<int>(
  (ref) =>
      ref.watch(notificationsProvider).value?.where((n) => !n.read).length ?? 0,
);

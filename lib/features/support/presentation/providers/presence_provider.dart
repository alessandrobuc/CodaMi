import 'package:flutter_riverpod/flutter_riverpod.dart';

// Whether this operator accepts live chats; the admin shell sends it as presence.
class ChatAvailability extends Notifier<bool> {
  @override
  bool build() => true;

  void set(bool available) => state = available;
}

final chatAvailabilityProvider = NotifierProvider<ChatAvailability, bool>(
  ChatAvailability.new,
);

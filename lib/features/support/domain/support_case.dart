import 'package:cloud_firestore/cloud_firestore.dart';

// Same values as `functions/src/support.ts`.
enum CaseKind { chat, ticket }

enum CaseCategory { account, listing, app, other }

enum CaseStatus {
  open('open'),
  inProgress('in_progress'),
  waitingUser('waiting_user'),
  resolved('resolved'),
  closed('closed');

  const CaseStatus(this.value);

  final String value;

  bool get isActive => this != resolved && this != closed;

  static CaseStatus fromValue(Object? value) =>
      values.where((s) => s.value == value).firstOrNull ?? open;
}

T _enumOf<T extends Enum>(List<T> values, Object? name, T fallback) =>
    values.where((v) => v.name == name).firstOrNull ?? fallback;

DateTime? _time(Object? value) => value is Timestamp ? value.toDate() : null;

int _int(Object? value) => value is num ? value.toInt() : 0;

class SupportCase {
  final String id;
  final String reference;
  final CaseKind kind;
  final CaseCategory category;
  final String subject;
  final CaseStatus status;
  final String userId;
  final String userName;
  final String userEmail;
  final String? assignedTo;
  final String? assignedName;
  final bool awaitingStaff;
  final bool overdue;
  final String lastMessageText;
  final bool lastMessageByStaff;
  final int messageCount;
  final int responseCount;
  final int responseSecondsTotal;
  final int handlingSeconds;
  final DateTime? createdAt;
  final DateTime? assignedAt;
  final DateTime? firstResponseAt;
  final DateTime? awaitingSince;
  final DateTime? lastMessageAt;
  final DateTime? workStartedAt;
  final DateTime? resolvedAt;
  final DateTime? closedAt;

  const SupportCase({
    required this.id,
    required this.reference,
    required this.kind,
    required this.category,
    required this.subject,
    required this.status,
    required this.userId,
    this.userName = '',
    this.userEmail = '',
    this.assignedTo,
    this.assignedName,
    this.awaitingStaff = false,
    this.overdue = false,
    this.lastMessageText = '',
    this.lastMessageByStaff = false,
    this.messageCount = 0,
    this.responseCount = 0,
    this.responseSecondsTotal = 0,
    this.handlingSeconds = 0,
    this.createdAt,
    this.assignedAt,
    this.firstResponseAt,
    this.awaitingSince,
    this.lastMessageAt,
    this.workStartedAt,
    this.resolvedAt,
    this.closedAt,
  });

  factory SupportCase.fromMap(String id, Map<String, dynamic> map) =>
      SupportCase(
        id: id,
        reference: map['reference'] as String? ?? '',
        kind: _enumOf(CaseKind.values, map['kind'], CaseKind.ticket),
        category: _enumOf(
          CaseCategory.values,
          map['category'],
          CaseCategory.other,
        ),
        subject: map['subject'] as String? ?? '',
        status: CaseStatus.fromValue(map['status']),
        userId: map['userId'] as String? ?? '',
        userName: map['userName'] as String? ?? '',
        userEmail: map['userEmail'] as String? ?? '',
        assignedTo: map['assignedTo'] as String?,
        assignedName: map['assignedName'] as String?,
        awaitingStaff: map['awaitingStaff'] == true,
        overdue: map['overdue'] == true,
        lastMessageText: map['lastMessageText'] as String? ?? '',
        lastMessageByStaff: map['lastMessageBy'] == 'staff',
        messageCount: _int(map['messageCount']),
        responseCount: _int(map['responseCount']),
        responseSecondsTotal: _int(map['responseSecondsTotal']),
        handlingSeconds: _int(map['handlingSeconds']),
        createdAt: _time(map['createdAt']),
        assignedAt: _time(map['assignedAt']),
        firstResponseAt: _time(map['firstResponseAt']),
        awaitingSince: _time(map['awaitingSince']),
        lastMessageAt: _time(map['lastMessageAt']),
        workStartedAt: _time(map['workStartedAt']),
        resolvedAt: _time(map['resolvedAt']),
        closedAt: _time(map['closedAt']),
      );

  bool get isAssigned => assignedTo != null;

  Duration? get waitToTakeOver => createdAt == null || assignedAt == null
      ? null
      : assignedAt!.difference(createdAt!);

  Duration? get firstResponseTime =>
      createdAt == null || firstResponseAt == null
      ? null
      : firstResponseAt!.difference(createdAt!);

  Duration? get averageResponseTime => responseCount == 0
      ? null
      : Duration(seconds: responseSecondsTotal ~/ responseCount);

  // Includes the time of the current work period while the case is open.
  Duration handlingTime({DateTime? now}) {
    final running = workStartedAt == null
        ? Duration.zero
        : (now ?? DateTime.now()).difference(workStartedAt!);
    return Duration(seconds: handlingSeconds) +
        (running.isNegative ? Duration.zero : running);
  }

  Duration? waitingFor({DateTime? now}) => awaitingSince == null
      ? null
      : (now ?? DateTime.now()).difference(awaitingSince!);
}

class SupportMessage {
  final String id;
  final String senderId;
  final bool fromStaff;
  final String text;
  final DateTime? createdAt;

  const SupportMessage({
    required this.id,
    required this.senderId,
    required this.fromStaff,
    required this.text,
    this.createdAt,
  });

  factory SupportMessage.fromMap(String id, Map<String, dynamic> map) =>
      SupportMessage(
        id: id,
        senderId: map['senderId'] as String? ?? '',
        fromStaff: map['senderRole'] == 'staff',
        text: map['text'] as String? ?? '',
        createdAt: _time(map['createdAt']),
      );
}

enum CaseEventType {
  created,
  taken,
  reassigned,
  status,
  reopened,
  overdue,
  autoClosed,
}

class SupportEvent {
  final String id;
  final CaseEventType type;
  final String byName;
  final bool bySystem;
  final bool byUser;
  final String? fromName;
  final String? toName;
  final CaseStatus? toStatus;
  final DateTime? at;

  const SupportEvent({
    required this.id,
    required this.type,
    this.byName = '',
    this.bySystem = false,
    this.byUser = false,
    this.fromName,
    this.toName,
    this.toStatus,
    this.at,
  });

  factory SupportEvent.fromMap(String id, Map<String, dynamic> map) {
    final type = map['type'] == 'auto_closed'
        ? CaseEventType.autoClosed
        : _enumOf(CaseEventType.values, map['type'], CaseEventType.status);
    return SupportEvent(
      id: id,
      type: type,
      byName: map['byName'] as String? ?? '',
      bySystem: map['by'] == 'system',
      byUser: map['byUser'] == true || type == CaseEventType.reopened,
      fromName: map['fromName'] as String?,
      toName: map['toName'] as String?,
      toStatus: type == CaseEventType.status
          ? CaseStatus.fromValue(map['to'])
          : null,
      at: _time(map['at']),
    );
  }
}

class StaffStats {
  final int casesTaken;
  final int casesResolved;
  final int responses;
  final int responseSecondsTotal;
  final int handlingSecondsTotal;
  final DateTime? lastActiveAt;

  const StaffStats({
    this.casesTaken = 0,
    this.casesResolved = 0,
    this.responses = 0,
    this.responseSecondsTotal = 0,
    this.handlingSecondsTotal = 0,
    this.lastActiveAt,
  });

  factory StaffStats.fromMap(Map<String, dynamic>? map) => map == null
      ? const StaffStats()
      : StaffStats(
          casesTaken: _int(map['casesTaken']),
          casesResolved: _int(map['casesResolved']),
          responses: _int(map['responses']),
          responseSecondsTotal: _int(map['responseSecondsTotal']),
          handlingSecondsTotal: _int(map['handlingSecondsTotal']),
          lastActiveAt: _time(map['lastActiveAt']),
        );

  Duration? get averageResponse => responses == 0
      ? null
      : Duration(seconds: responseSecondsTotal ~/ responses);

  Duration? get averageHandling => casesResolved == 0
      ? null
      : Duration(seconds: handlingSecondsTotal ~/ casesResolved);
}

enum PresenceState { online, away, offline }

// Matches PRESENCE_TIMEOUT_MS on the server.
const presenceTimeout = Duration(minutes: 5);
const presenceHeartbeat = Duration(minutes: 2);

class StaffPresence {
  final PresenceState state;
  final DateTime? lastSeen;

  const StaffPresence({this.state = PresenceState.offline, this.lastSeen});

  factory StaffPresence.fromMap(Map<String, dynamic>? map) => StaffPresence(
    state: _enumOf(PresenceState.values, map?['state'], PresenceState.offline),
    lastSeen: _time(map?['lastSeen']),
  );

  PresenceState current({DateTime? now}) {
    if (lastSeen == null) return PresenceState.offline;
    final stale =
        (now ?? DateTime.now()).difference(lastSeen!) > presenceTimeout;
    return stale ? PresenceState.offline : state;
  }
}

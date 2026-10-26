// Petitions picked by the CodaMi team from external sites. Users read them
// here and sign on the original page. No backend types in this file.

enum PetitionTopic {
  pets,
  wildlife,
  farm,
  testing,
  entertainment,
  marine,
  other;

  static PetitionTopic fromValue(Object? value) =>
      values.where((t) => t.name == value).firstOrNull ?? other;
}

// The team's editorial decision. Users only see `published`.
enum PetitionReview {
  pending,
  approved,
  rejected,
  published;

  static PetitionReview fromValue(Object? value) =>
      values.where((r) => r.name == value).firstOrNull ?? pending;

  bool get needsChecks => this == approved || this == published;
}

// The state of the campaign on the original site.
enum PetitionStatus {
  active,
  completed,
  closed,
  unavailable;

  static PetitionStatus fromValue(Object? value) =>
      values.where((s) => s.name == value).firstOrNull ?? active;
}

class PetitionChecks {
  final bool exists;
  final bool genuine;
  final bool clearGoal;
  final bool notMisleading;

  const PetitionChecks({
    this.exists = false,
    this.genuine = false,
    this.clearGoal = false,
    this.notMisleading = false,
  });

  bool get all => exists && genuine && clearGoal && notMisleading;

  factory PetitionChecks.fromMap(Object? map) {
    if (map is! Map) return const PetitionChecks();
    return PetitionChecks(
      exists: map['exists'] == true,
      genuine: map['genuine'] == true,
      clearGoal: map['clearGoal'] == true,
      notMisleading: map['notMisleading'] == true,
    );
  }

  Map<String, bool> toMap() => {
    'exists': exists,
    'genuine': genuine,
    'clearGoal': clearGoal,
    'notMisleading': notMisleading,
  };

  PetitionChecks copyWith({
    bool? exists,
    bool? genuine,
    bool? clearGoal,
    bool? notMisleading,
  }) => PetitionChecks(
    exists: exists ?? this.exists,
    genuine: genuine ?? this.genuine,
    clearGoal: clearGoal ?? this.clearGoal,
    notMisleading: notMisleading ?? this.notMisleading,
  );
}

// Field limits, matched by firestore.rules.
class PetitionLimits {
  static const url = 500;
  static const title = 140;
  static const source = 80;
  static const country = 80;
  static const summary = 300;
  static const issue = 1500;
  static const action = 800;
  static const why = 800;
  static const rejectReason = 300;
  static const imageBytes = 5 * 1024 * 1024;
}

// Only full https links to a real host.
bool isPetitionUrl(String text) {
  final value = text.trim();
  if (value.isEmpty ||
      value.length > PetitionLimits.url ||
      RegExp(r'\s').hasMatch(value)) {
    return false;
  }
  final uri = Uri.tryParse(value);
  return uri != null &&
      uri.scheme == 'https' &&
      uri.host.contains('.') &&
      uri.userInfo.isEmpty;
}

// What the admin fills in. Saved as a whole on each change.
class PetitionDraft {
  final String url;
  final String title;
  final String source;
  final PetitionTopic topic;
  final String country;
  final DateTime? startedOn;
  final String summary;
  final String issue;
  final String action;
  final String why;
  final bool imagePermission;
  final PetitionReview review;
  final PetitionStatus status;
  final PetitionChecks checks;
  final String rejectReason;

  const PetitionDraft({
    required this.url,
    required this.title,
    required this.source,
    required this.topic,
    this.country = '',
    this.startedOn,
    required this.summary,
    required this.issue,
    required this.action,
    required this.why,
    this.imagePermission = false,
    this.review = PetitionReview.pending,
    this.status = PetitionStatus.active,
    this.checks = const PetitionChecks(),
    this.rejectReason = '',
  });

  PetitionDraft trimmed() => PetitionDraft(
    url: url.trim(),
    title: title.trim(),
    source: source.trim(),
    topic: topic,
    country: country.trim(),
    startedOn: startedOn,
    summary: summary.trim(),
    issue: issue.trim(),
    action: action.trim(),
    why: why.trim(),
    imagePermission: imagePermission,
    review: review,
    status: status,
    checks: checks,
    rejectReason: review == PetitionReview.rejected ? rejectReason.trim() : '',
  );
}

enum PetitionProblem {
  url,
  title,
  source,
  summary,
  issue,
  action,
  why,
  checks,
  imagePermission,
}

// Everything the form must fix before saving. Empty means it can be saved.
Set<PetitionProblem> petitionProblems(
  PetitionDraft draft, {
  required bool hasImage,
}) {
  final d = draft.trimmed();
  bool bad(String text, int max) => text.isEmpty || text.length > max;
  return {
    if (!isPetitionUrl(d.url)) PetitionProblem.url,
    if (bad(d.title, PetitionLimits.title)) PetitionProblem.title,
    if (bad(d.source, PetitionLimits.source)) PetitionProblem.source,
    if (bad(d.summary, PetitionLimits.summary)) PetitionProblem.summary,
    if (bad(d.issue, PetitionLimits.issue)) PetitionProblem.issue,
    if (bad(d.action, PetitionLimits.action)) PetitionProblem.action,
    if (bad(d.why, PetitionLimits.why)) PetitionProblem.why,
    if (d.review.needsChecks && !d.checks.all) PetitionProblem.checks,
    if (hasImage && !d.imagePermission) PetitionProblem.imagePermission,
  };
}

class Petition {
  final String id;
  final PetitionDraft draft;
  final String? imageUrl;
  final String? imagePath;
  final String createdBy;
  final String updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;

  const Petition({
    required this.id,
    required this.draft,
    this.imageUrl,
    this.imagePath,
    this.createdBy = '',
    this.updatedBy = '',
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
  });

  String get url => draft.url;
  String get title => draft.title;
  String get source => draft.source;
  PetitionTopic get topic => draft.topic;
  String get country => draft.country;
  String get summary => draft.summary;
  String get issue => draft.issue;
  String get action => draft.action;
  String get why => draft.why;
  PetitionReview get review => draft.review;
  PetitionStatus get status => draft.status;

  bool get canSign => status == PetitionStatus.active;
}

// Active campaigns first, then the most recently published.
List<Petition> sortForUsers(Iterable<Petition> petitions) =>
    [...petitions]..sort((a, b) {
      final active = (b.canSign ? 1 : 0) - (a.canSign ? 1 : 0);
      if (active != 0) return active;
      final at = a.publishedAt ?? a.updatedAt;
      final bt = b.publishedAt ?? b.updatedAt;
      if (at == null || bt == null) return 0;
      return bt.compareTo(at);
    });

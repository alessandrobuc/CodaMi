import 'package:cloud_firestore/cloud_firestore.dart';

enum NoteSection {
  added('new'),
  improved('improved'),
  fixed('fixed');

  const NoteSection(this.value);

  final String value;
}

// The notes of one version in one language.
class NoteItems {
  final Map<NoteSection, List<String>> items;

  const NoteItems([this.items = const {}]);

  factory NoteItems.fromMap(Object? map) {
    if (map is! Map) return const NoteItems();
    return NoteItems({
      for (final section in NoteSection.values)
        section: [
          for (final line in map[section.value] as List? ?? const [])
            if (line is String && line.trim().isNotEmpty) line.trim(),
        ],
    });
  }

  // Each non-empty line of the admin's text becomes one item.
  factory NoteItems.fromText(Map<NoteSection, String> text) => NoteItems({
    for (final MapEntry(:key, :value) in text.entries)
      key: [
        for (final line in value.split('\n'))
          if (line.trim().isNotEmpty) line.trim().replaceFirst(_bullet, ''),
      ],
  });

  static final _bullet = RegExp(r'^[-•*]\s*');

  List<String> of(NoteSection section) => items[section] ?? const [];

  bool get isEmpty => NoteSection.values.every((s) => of(s).isEmpty);

  String textOf(NoteSection section) => of(section).join('\n');

  Map<String, dynamic> toMap() => {
    for (final section in NoteSection.values) section.value: of(section),
  };
}

class ReleaseNote {
  final String version;
  final bool published;
  final Map<String, NoteItems> notes;
  final DateTime? updatedAt;

  const ReleaseNote({
    required this.version,
    required this.published,
    required this.notes,
    this.updatedAt,
  });

  factory ReleaseNote.fromMap(String id, Map<String, dynamic> map) {
    final notes = map['notes'];
    return ReleaseNote(
      version: map['version'] as String? ?? id,
      published: map['published'] == true,
      notes: {
        if (notes is Map)
          for (final MapEntry(:key, :value) in notes.entries)
            if (key is String && !NoteItems.fromMap(value).isEmpty)
              key: NoteItems.fromMap(value),
      },
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  // The user's language, then English, then Italian, then whatever exists.
  NoteItems itemsFor(String lang) =>
      notes[lang] ??
      notes['en'] ??
      notes['it'] ??
      notes.values.firstOrNull ??
      const NoteItems();

  Map<String, dynamic> toMap() => {
    'version': version,
    'code': versionCode(version),
    'published': published,
    'notes': {
      for (final MapEntry(:key, :value) in notes.entries)
        if (!value.isEmpty) key: value.toMap(),
    },
    'updatedAt': FieldValue.serverTimestamp(),
  };
}

final versionPattern = RegExp(r'^\d{1,3}(\.\d{1,3}){1,2}$');

bool isVersion(String text) => versionPattern.hasMatch(text);

// A number that sorts like the version: 1.10.0 → 1010000, above 1.9.0.
int versionCode(String version) {
  final parts = [for (final p in version.split('.')) int.tryParse(p) ?? 0];
  while (parts.length < 3) {
    parts.add(0);
  }
  return parts[0] * 1000000 + parts[1] * 1000 + parts[2];
}

int compareVersions(String a, String b) =>
    versionCode(a).compareTo(versionCode(b));

List<ReleaseNote> newestFirst(Iterable<ReleaseNote> notes) =>
    [...notes]..sort((a, b) => compareVersions(b.version, a.version));

// What this phone has already seen. `floor` is the version the app had when
// it was first opened; notes up to it are skipped, unless `includeFloor`
// (an existing user updating from a version without this feature).
class NotesSeen {
  final String floor;
  final bool includeFloor;
  final Set<String> shown;

  const NotesSeen({
    required this.floor,
    this.includeFloor = false,
    this.shown = const {},
  });
}

const maxNotesAtOnce = 3;

// The version code after which notes may still be unseen, or null when
// everything up to the installed version was already handled (no read needed).
int? notesToCheckAfter(NotesSeen seen, String current) {
  final floor = versionCode(seen.floor);
  var after = seen.includeFloor ? floor - 1 : floor;
  for (final v in seen.shown) {
    final code = versionCode(v);
    if (code > after) after = code;
  }
  return after < versionCode(current) ? after : null;
}

// Notes to show after an update: published, newer than the floor, not newer
// than the installed app, and not shown before. A note published after the
// update still shows on the next start.
List<ReleaseNote> unseenNotes(
  List<ReleaseNote> notes,
  String current,
  NotesSeen seen,
) {
  bool afterFloor(String v) {
    final c = compareVersions(v, seen.floor);
    return c > 0 || (c == 0 && seen.includeFloor);
  }

  return newestFirst([
    for (final n in notes)
      if (n.published &&
          afterFloor(n.version) &&
          compareVersions(n.version, current) <= 0 &&
          !seen.shown.contains(n.version))
        n,
  ]).take(maxNotesAtOnce).toList();
}

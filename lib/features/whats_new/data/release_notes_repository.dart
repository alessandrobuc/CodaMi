import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/release_note.dart';

class NotesPage {
  final List<ReleaseNote> notes;
  final DocumentSnapshot<Map<String, dynamic>>? last;
  final bool hasMore;

  const NotesPage(this.notes, this.last, {required this.hasMore});
}

class ReleaseNotesRepository {
  static const pageSize = 10;

  final FirebaseFirestore _db;

  ReleaseNotesRepository({FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _notes =>
      _db.collection('releaseNotes');

  // Newest first, one page at a time. Users only get published notes.
  Future<NotesPage> page({
    required bool publishedOnly,
    DocumentSnapshot<Map<String, dynamic>>? after,
  }) async {
    Query<Map<String, dynamic>> query = _notes;
    if (publishedOnly) query = query.where('published', isEqualTo: true);
    query = query.orderBy('code', descending: true).limit(pageSize);
    if (after != null) query = query.startAfterDocument(after);
    final snap = await query.get();
    return NotesPage(
      [for (final d in snap.docs) ReleaseNote.fromMap(d.id, d.data())],
      snap.docs.lastOrNull,
      hasMore: snap.docs.length == pageSize,
    );
  }

  // Published notes newer than [afterCode], up to the installed version.
  Future<List<ReleaseNote>> unseen({
    required int afterCode,
    required int upToCode,
  }) async {
    final snap = await _notes
        .where('published', isEqualTo: true)
        .where('code', isGreaterThan: afterCode)
        .where('code', isLessThanOrEqualTo: upToCode)
        .orderBy('code', descending: true)
        .limit(maxNotesAtOnce)
        .get();
    return [for (final d in snap.docs) ReleaseNote.fromMap(d.id, d.data())];
  }

  // Null when there's no note for [version], or users can't read it yet.
  Future<ReleaseNote?> find(String version) async {
    try {
      final doc = await _notes.doc(version).get();
      return doc.exists ? ReleaseNote.fromMap(doc.id, doc.data()!) : null;
    } on FirebaseException {
      return null;
    }
  }

  Future<bool> exists(String version) async =>
      (await _notes.doc(version).get()).exists;

  Future<void> save(ReleaseNote note) =>
      _notes.doc(note.version).set(note.toMap());

  Future<void> delete(String version) => _notes.doc(version).delete();
}

final releaseNotesRepositoryProvider = Provider(
  (ref) => ReleaseNotesRepository(),
);

// Which notes this phone has seen, so each version shows only once.
class NotesSeenStore {
  static const _floorKey = 'notes_floor';
  static const _includeKey = 'notes_floor_included';
  static const _shownKey = 'notes_shown';

  final SharedPreferences _prefs;

  NotesSeenStore(this._prefs);

  NotesSeen? read() {
    final floor = _prefs.getString(_floorKey);
    if (floor == null) return null;
    return NotesSeen(
      floor: floor,
      includeFloor: _prefs.getBool(_includeKey) ?? false,
      shown: {...?_prefs.getStringList(_shownKey)},
    );
  }

  Future<NotesSeen> start(String version, {required bool updated}) async {
    await _prefs.setString(_floorKey, version);
    await _prefs.setBool(_includeKey, updated);
    return NotesSeen(floor: version, includeFloor: updated);
  }

  Future<void> markShown(Iterable<String> versions) => _prefs.setStringList(
    _shownKey,
    {...?_prefs.getStringList(_shownKey), ...versions}.toList(),
  );
}

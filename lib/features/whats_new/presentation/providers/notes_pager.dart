import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../data/release_notes_repository.dart';
import '../../domain/release_note.dart';

// Loads version notes one page at a time, newest first.
class NotesPager extends ChangeNotifier {
  final ReleaseNotesRepository _repo;
  final bool publishedOnly;

  NotesPager(this._repo, {required this.publishedOnly});

  List<ReleaseNote> notes = const [];
  bool loading = false;
  bool loaded = false;
  bool hasMore = true;
  bool failed = false;
  DocumentSnapshot<Map<String, dynamic>>? _last;

  Future<void> refresh() {
    notes = const [];
    _last = null;
    hasMore = true;
    loaded = false;
    return more();
  }

  Future<void> more() async {
    if (loading || !hasMore) return;
    loading = true;
    failed = false;
    notifyListeners();
    try {
      final page = await _repo.page(publishedOnly: publishedOnly, after: _last);
      notes = [...notes, ...page.notes];
      _last = page.last ?? _last;
      hasMore = page.hasMore;
    } catch (e) {
      debugPrint('Notes not loaded: $e');
      failed = true;
    }
    loading = false;
    loaded = true;
    notifyListeners();
  }
}

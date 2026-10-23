import 'package:flutter_test/flutter_test.dart';
import 'package:CodaMi/features/whats_new/domain/release_note.dart';

ReleaseNote note(String version, {bool published = true, String lang = 'en'}) =>
    ReleaseNote(
      version: version,
      published: published,
      notes: {
        lang: NoteItems({
          NoteSection.added: ['Something new in $version'],
        }),
      },
    );

void main() {
  test('versions compare by number, not text', () {
    expect(compareVersions('1.10.0', '1.9.0'), greaterThan(0));
    expect(compareVersions('1.2', '1.2.0'), 0);
    expect(compareVersions('1.0.0', '1.0.1'), lessThan(0));
    expect(isVersion('1.1.0'), isTrue);
    expect(isVersion('1.1'), isTrue);
    expect(isVersion('v1.1'), isFalse);
    expect(isVersion('1'), isFalse);
  });

  test('a fresh install sees no notes, even for its own version', () {
    final notes = [note('1.1.0'), note('1.0.0')];
    expect(unseenNotes(notes, '1.1.0', const NotesSeen(floor: '1.1.0')), isEmpty);
  });

  test('an update shows the new versions once, newest first', () {
    final notes = [note('1.0.0'), note('1.1.0'), note('1.2.0'), note('1.3.0')];
    const seen = NotesSeen(floor: '1.0.0');
    final shown = unseenNotes(notes, '1.2.0', seen);
    expect(shown.map((n) => n.version), ['1.2.0', '1.1.0']);

    final again = unseenNotes(
      notes,
      '1.2.0',
      const NotesSeen(floor: '1.0.0', shown: {'1.1.0', '1.2.0'}),
    );
    expect(again, isEmpty);
  });

  test('existing users see the notes of the version that added this screen', () {
    final notes = [note('1.1.0')];
    const seen = NotesSeen(floor: '1.1.0', includeFloor: true);
    expect(unseenNotes(notes, '1.1.0', seen).single.version, '1.1.0');
  });

  test('drafts and future versions stay hidden, and at most 3 show', () {
    final notes = [
      note('1.1.0'),
      note('1.2.0', published: false),
      note('1.3.0'),
      note('1.4.0'),
      note('1.5.0'),
      note('2.0.0'),
    ];
    final shown = unseenNotes(notes, '1.5.0', const NotesSeen(floor: '1.0.0'));
    expect(shown.map((n) => n.version), ['1.5.0', '1.4.0', '1.3.0']);
  });

  test('notes fall back to English when a language is missing', () {
    final n = ReleaseNote(
      version: '1.1.0',
      published: true,
      notes: {
        'en': const NoteItems({NoteSection.fixed: ['Fixed']}),
        'it': const NoteItems({NoteSection.fixed: ['Corretto']}),
      },
    );
    expect(n.itemsFor('it').of(NoteSection.fixed), ['Corretto']);
    expect(n.itemsFor('de').of(NoteSection.fixed), ['Fixed']);
  });

  test('each non-empty line becomes one item, without bullets', () {
    final items = NoteItems.fromText({
      NoteSection.added: '- Map pins\n\n• Invite codes \n',
      NoteSection.fixed: '',
    });
    expect(items.of(NoteSection.added), ['Map pins', 'Invite codes']);
    expect(items.of(NoteSection.fixed), isEmpty);
    expect(NoteItems.fromMap(items.toMap()).of(NoteSection.added), [
      'Map pins',
      'Invite codes',
    ]);
  });

  test('version codes sort like versions', () {
    expect(versionCode('1.10.0'), greaterThan(versionCode('1.9.9')));
    expect(versionCode('1.2'), versionCode('1.2.0'));
    expect(versionCode('2.0.0'), 2000000);
  });

  test('the server is only asked when an unseen version can exist', () {
    // Fresh install of 1.1.0: nothing to check, no read.
    expect(notesToCheckAfter(const NotesSeen(floor: '1.1.0'), '1.1.0'), isNull);
    // Updated from 1.0.0 to 1.1.0: check versions after 1.0.0.
    expect(
      notesToCheckAfter(const NotesSeen(floor: '1.0.0'), '1.1.0'),
      versionCode('1.0.0'),
    );
    // 1.1.0 already shown: no read until the next update.
    expect(
      notesToCheckAfter(
        const NotesSeen(floor: '1.0.0', shown: {'1.1.0'}),
        '1.1.0',
      ),
      isNull,
    );
    // Existing user: the installed version itself still counts.
    expect(
      notesToCheckAfter(
        const NotesSeen(floor: '1.1.0', includeFloor: true),
        '1.1.0',
      ),
      versionCode('1.1.0') - 1,
    );
  });

  test('saved notes carry the sortable code', () {
    expect(note('1.10.2').toMap()['code'], 1010002);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:CodaMi/features/petitions/domain/petition.dart';

void main() {
  const filled = PetitionDraft(
    url: 'https://www.change.org/p/ban-circus-animals',
    title: 'Ban wild animals in circuses',
    source: 'Change.org',
    topic: PetitionTopic.entertainment,
    summary: 'A call to end wild animal acts.',
    issue: 'Wild animals are kept in small cages on the road.',
    action: 'Pass a national ban.',
    why: 'Travelling shows cause lasting stress.',
  );
  const allChecks = PetitionChecks(
    exists: true,
    genuine: true,
    clearGoal: true,
    notMisleading: true,
  );

  PetitionDraft with_({
    String? url,
    String? title,
    PetitionReview? review,
    PetitionChecks? checks,
    bool imagePermission = false,
  }) => PetitionDraft(
    url: url ?? filled.url,
    title: title ?? filled.title,
    source: filled.source,
    topic: filled.topic,
    summary: filled.summary,
    issue: filled.issue,
    action: filled.action,
    why: filled.why,
    review: review ?? PetitionReview.pending,
    checks: checks ?? const PetitionChecks(),
    imagePermission: imagePermission,
  );

  test('only full https links are accepted', () {
    expect(isPetitionUrl('https://www.change.org/p/x'), isTrue);
    expect(isPetitionUrl('  https://care2.com/petitions/1 '), isTrue);
    expect(isPetitionUrl('http://www.change.org/p/x'), isFalse);
    expect(isPetitionUrl('www.change.org/p/x'), isFalse);
    expect(isPetitionUrl('javascript:alert(1)'), isFalse);
    expect(isPetitionUrl('https://localhost/p'), isFalse);
    expect(isPetitionUrl('https://user@evil.com/p'), isFalse);
    expect(isPetitionUrl('https://a.org/has space'), isFalse);
    expect(isPetitionUrl('https://a.org/${'x' * 600}'), isFalse);
  });

  test('a complete draft can be saved as pending without checks', () {
    expect(petitionProblems(filled, hasImage: false), isEmpty);
  });

  test('missing fields and a bad link are reported', () {
    final problems = petitionProblems(
      with_(url: 'change.org', title: '   '),
      hasImage: false,
    );
    expect(problems, {PetitionProblem.url, PetitionProblem.title});
  });

  test('approving or publishing needs every check', () {
    for (final review in [PetitionReview.approved, PetitionReview.published]) {
      expect(
        petitionProblems(
          with_(review: review, checks: allChecks.copyWith(genuine: false)),
          hasImage: false,
        ),
        {PetitionProblem.checks},
      );
      expect(
        petitionProblems(
          with_(review: review, checks: allChecks),
          hasImage: false,
        ),
        isEmpty,
      );
    }
    expect(
      petitionProblems(with_(review: PetitionReview.rejected), hasImage: false),
      isEmpty,
    );
  });

  test('an image needs the permission box', () {
    expect(petitionProblems(with_(), hasImage: true), {
      PetitionProblem.imagePermission,
    });
    expect(
      petitionProblems(with_(imagePermission: true), hasImage: true),
      isEmpty,
    );
  });

  test('the reject reason is only kept for rejected petitions', () {
    const draft = PetitionDraft(
      url: 'https://a.org/p',
      title: 't',
      source: 's',
      topic: PetitionTopic.other,
      summary: 's',
      issue: 'i',
      action: 'a',
      why: 'w',
      review: PetitionReview.approved,
      rejectReason: 'old note',
    );
    expect(draft.trimmed().rejectReason, isEmpty);
  });

  test('users see active campaigns first, newest first', () {
    Petition p(String id, PetitionStatus status, int day) => Petition(
      id: id,
      draft: PetitionDraft(
        url: filled.url,
        title: id,
        source: 's',
        topic: PetitionTopic.other,
        summary: 's',
        issue: 'i',
        action: 'a',
        why: 'w',
        status: status,
      ),
      publishedAt: DateTime(2026, 10, day),
    );
    final sorted = sortForUsers([
      p('closedNew', PetitionStatus.closed, 25),
      p('activeOld', PetitionStatus.active, 1),
      p('activeNew', PetitionStatus.active, 20),
    ]);
    expect(sorted.map((e) => e.id), ['activeNew', 'activeOld', 'closedNew']);
  });
}

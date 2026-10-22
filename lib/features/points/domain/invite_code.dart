// Must match CODE_ALPHABET and CODE_LENGTH in functions/src/points.ts.
const inviteCodeAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
const inviteCodeLength = 6;

final _codePattern = RegExp(
  '(?<![A-Z0-9])[$inviteCodeAlphabet]{$inviteCodeLength}(?![A-Z0-9])',
);

bool isInviteCode(String code) =>
    code.length == inviteCodeLength &&
    code.split('').every(inviteCodeAlphabet.contains);

// Accepts a typed code ("abc-234"), the shared link (…referrer=ABC234…)
// or the whole shared message, and returns the code or null.
String? extractInviteCode(String input) {
  final text = input.trim().toUpperCase();
  if (text.isEmpty) return null;

  final fromLink = RegExp(r'REFERRER(?:=|%3D)([A-Z0-9]+)').firstMatch(text);
  if (fromLink != null && isInviteCode(fromLink.group(1)!)) {
    return fromLink.group(1);
  }

  final compact = text.replaceAll(RegExp(r'[\s\-_.]'), '');
  if (isInviteCode(compact)) return compact;

  final found = _codePattern.allMatches(text).map((m) => m.group(0)!).toSet();
  return found.length == 1 ? found.single : null;
}

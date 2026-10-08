String compactCount(int value, {bool more = false}) {
  final suffix = more ? '+' : '';
  if (value < 1000) return '$value$suffix';
  final (n, unit) = value < 1000000
      ? (value / 1000, 'k')
      : (value / 1000000, 'M');
  final text = n < 10 ? _oneDecimal(n) : '${n.floor()}';
  return '$text$unit$suffix';
}

String _oneDecimal(double n) {
  final tenths = (n * 10).floor();
  return tenths % 10 == 0
      ? '${tenths ~/ 10}'
      : '${tenths ~/ 10}.${tenths % 10}';
}

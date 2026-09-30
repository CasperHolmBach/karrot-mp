// "₩13,000" / "Free"
String formatPrice(int price) {
  if (price == 0) return 'Free';
  final digits = price.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return '₩$buffer';
}

// "just now" / "3 min ago" / "1 hr ago" / "2 days ago"
String timeAgo(DateTime t, {DateTime? now}) {
  final diff = (now ?? DateTime.now()).difference(t);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inHours < 1) return '${diff.inMinutes} min ago';
  if (diff.inDays < 1) return '${diff.inHours} hr ago';
  if (diff.inDays == 1) return '1 day ago';
  return '${diff.inDays} days ago';
}

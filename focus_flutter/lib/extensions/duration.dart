///
extension DurationX on Duration {
  /// Returns a string representation of [Duration].
  String get asText {
    if (this == Duration.zero) {
      return 'n/a';
    }
    if (inDays > 0) {
      return '$inDays days';
    }
    if (inHours > 0) {
      return '$inHours hours';
    }
    if (inMinutes > 0) {
      return '$inMinutes minutes';
    }
    return '$inSeconds seconds';
  }
}

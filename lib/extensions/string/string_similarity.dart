extension StringSimilarity on String? {
  /// Returns a fraction between 0 and 1, which indicates the degree of similarity between the two strings. 0 indicates completely different strings, 1 indicates identical strings. The comparison is case-sensitive.
  ///
  /// ##### Arguments
  /// - other (String?): The second string
  ///
  /// (Order does not make a difference)
  ///
  /// ##### Returns
  /// (number): A fraction from 0 to 1, both inclusive. Higher number indicates more similarity.
  double similarityTo(String? other) {
    String? first = this;
    String? second = other;

    // if both are null
    if (first == null && second == null) {
      return 1;
    }
    // as both are not null if one of them is null then return 0
    if (first == null || second == null) {
      return 0;
    }

    // remove all whitespace
    first = first.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    second = second.replaceAll(RegExp(r'\s+\b|\b\s'), '');

    // if both are empty strings
    if (first.isEmpty && second.isEmpty) {
      return 1;
    }
    // if only one is empty string
    if (first.isEmpty || second.isEmpty) {
      return 0;
    }
    // identical
    if (first == second) {
      return 1;
    }
    // both are 1-letter strings
    if (first.length == 1 && second.length == 1) {
      return 0;
    }
    // if either is a 1-letter string
    if (first.length < 2 || second.length < 2) {
      return 0;
    }

    final firstBigrams = <String, int>{};
    for (var i = 0; i < first.length - 1; i++) {
      final bigram = first.substring(i, i + 2);
      final count =
          firstBigrams.containsKey(bigram) ? firstBigrams[bigram]! + 1 : 1;
      firstBigrams[bigram] = count;
    }

    var intersectionSize = 0;
    for (var i = 0; i < second.length - 1; i++) {
      final bigram = second.substring(i, i + 2);
      final count =
          firstBigrams.containsKey(bigram) ? firstBigrams[bigram]! : 0;

      if (count > 0) {
        firstBigrams[bigram] = count - 1;
        intersectionSize++;
      }
    }

    return (2.0 * intersectionSize) / (first.length + second.length - 2);
  }
}

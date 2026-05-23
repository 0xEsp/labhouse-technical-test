extension NumOptional on num? {
  bool operator >(int other) {
    return (this ?? 0) > other;
  }
}

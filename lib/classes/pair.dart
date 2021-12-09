/// Helper class that can contain two elements of given types.
class Pair<T1, T2> {
  /// First element of type [T1].
  final T1 a;

  /// Second element of type [T2].
  final T2 b;

  Pair(this.a, this.b);

  @override
  bool operator ==(Object other) {
    return other is Pair && a == other.a && b == other.b;
  }

  @override
  // TODO: implement this better sometime whatever lmao
  int get hashCode => a.hashCode * b.hashCode;
}

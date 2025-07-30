extension FutureExtensions<T> on Future<T> {
  Future<T> delay([Duration duration = const Duration(milliseconds: 300)]) =>
      Future.delayed(duration).then((_) => this);
}

extension BoolExtensions on bool {
  String get asYesNo => this ? 'Yes' : 'No';

  bool get not => !this;

  T choose<T>(T ifTrue, T ifFalse) => this ? ifTrue : ifFalse;
}

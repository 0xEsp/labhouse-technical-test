enum Routes {
  home('/home');

  final String path;

  const Routes(this.path);

  String get name => path.replaceFirst('/', '');
}

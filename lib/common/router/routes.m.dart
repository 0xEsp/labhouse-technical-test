enum Routes {
  home('/home'),
  rankingDetail('/ranking-detail');

  final String path;

  const Routes(this.path);

  String get name => path.replaceFirst('/', '');
}

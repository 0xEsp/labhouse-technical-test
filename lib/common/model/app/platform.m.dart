enum Platform {
  iOS(name: 'IOS'),
  android(name: 'ANDROID');

  final String name;

  const Platform({required this.name});
}

class SongsModel {
  final String title;
  final String subtitle;
  final String extension;
  final int id;
  final String data;
  const SongsModel(
      {required this.id,
      required this.data,
      required this.extension,
      required this.subtitle,
      required this.title});
}

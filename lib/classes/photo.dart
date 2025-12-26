class Photo {
  final String url;
  final String filename;

  Photo({required this.url, required this.filename});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(url: json['url'], filename: json['filename']);
  }

  String get label {
    String rawDate = filename.split('/').last.replaceAll('.jpg', '');

    try {
      List<String> parts = rawDate.split('-');
      return "${parts[2]}/${parts[1]}/${parts[0]}";
    } catch (e) {
      return rawDate;
    }
  }
}

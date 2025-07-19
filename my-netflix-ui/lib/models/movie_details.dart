class MovieDetail {
  final int id;
  final String title;
  final String description;
  final String genre;
  final String contentType;
  final String posterUrl;
  final String? previewUrl;
  final String videoUrl;
  final int durationInMinutes;
  final String? durationFormatted;

  MovieDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.contentType,
    required this.posterUrl,
    this.previewUrl,
    required this.videoUrl,
    required this.durationInMinutes,
    this.durationFormatted,
    // ✅ NEW
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      genre: json['genre'],
      contentType: json['contentType'],
      posterUrl: json['posterUrl'],
      previewUrl: json['previewUrl'],
      videoUrl: json['videoUrl'],
      durationInMinutes: json['durationInMinutes'],
      durationFormatted: json['durationFormatted'],
      // ✅ safely cast to double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'genre': genre,
      'contentType': contentType,
      'posterUrl': posterUrl,
      'previewUrl': previewUrl,
      'videoUrl': videoUrl,
      'durationInMinutes': durationInMinutes,
      'durationFormatted': durationFormatted,
    };
  }
}

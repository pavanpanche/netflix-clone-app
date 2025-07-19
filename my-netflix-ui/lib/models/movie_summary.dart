class MovieSummary {
  final int id;
  final String title;
  final String genre;
  final String contentType;
  final String posterUrl;
  final String backdropUrl;
  final double rating;
  final String durationFormatted;

  MovieSummary({
    required this.id,
    required this.title,
    required this.genre,
    required this.contentType,
    required this.posterUrl,
    required this.backdropUrl,
    required this.rating,
    required this.durationFormatted,
  });

  factory MovieSummary.fromJson(Map<String, dynamic> json) {
    return MovieSummary(
      id: json['id'],
      title: json['title'] ?? 'Unknown',
      genre: json['genre'] ?? 'Unknown',
      contentType: json['contentType'] ?? 'Movie',
      posterUrl: json['posterUrl'] ?? '',
      backdropUrl: json['backdropUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      durationFormatted: json['durationFormatted'] ?? 'Unknown',
    );

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'contentType': contentType,
      'posterUrl': posterUrl,
      'backdropUrl': backdropUrl,
      'rating': rating,
      'durationFormatted': durationFormatted,
    };
  }

  // ✅ Optional helper
  String get fullBackdropUrl => 'https://image.tmdb.org/t/p/w500$backdropUrl';
}

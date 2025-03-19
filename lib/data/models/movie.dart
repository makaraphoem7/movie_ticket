import 'dart:convert';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final DateTime releaseDate;
  final String movieType;
  final String timerofmovie;
  final String megabyteofmovie;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.movieType,
    required this.timerofmovie,
    required this.megabyteofmovie,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      overview: json['overview'] ?? '',
      posterPath: json['posterPath'] ?? 'assets/images/default.jpg',
      voteAverage: (json['voteAverage'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['releaseDate'] != null
          ? DateTime.tryParse(json['releaseDate']) ?? DateTime(2000, 1, 1)
          : DateTime(2000, 1, 1),
      movieType: json['movieType'] ?? '',
      timerofmovie: json['timerofmovie'] ?? '',
      megabyteofmovie: json['megabyteofmovie'] ?? '',
    );
  }
}

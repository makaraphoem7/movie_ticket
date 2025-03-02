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
}

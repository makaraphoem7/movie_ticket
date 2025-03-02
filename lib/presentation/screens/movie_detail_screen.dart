import 'package:flutter/material.dart';
import '../../data/models/movie.dart';
import '../widgets/movie_detail.dart';


class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovieDetail(movie: movie),
    );
  }
}


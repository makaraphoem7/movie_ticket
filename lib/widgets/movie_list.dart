import 'package:flutter/material.dart';
import '../data/models/movie.dart';
import 'movie_card.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160, // Set height to fit MovieCard
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scroll
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieCard(movie: movies[index]);
        },
      ),
    );
  }
}

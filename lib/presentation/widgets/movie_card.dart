import 'package:flutter/material.dart';
import '../../data/models/movie.dart';
import '../screens/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
          width: 50,
          fit: BoxFit.cover,
        ),
        title: Text(movie.title),
        subtitle: Text('Rating: ${movie.voteAverage}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movie: movie),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../data/models/movie.dart';
import '../screens/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 6.0), // Increased left padding
        child: Column(
          children: [
            // Movie Poster
            ClipRRect(
              child: Image.network(
                'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                width: 110,
                height: 150,
                fit: BoxFit.cover, // Ensures image fills the box
              ),
            ),
            const SizedBox(height: 8), // Spacing between image and text
            // Movie Title (Optional - Can be removed if not needed)
            SizedBox(
              width: 100,
              child: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Prevents overflow
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

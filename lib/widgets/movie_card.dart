import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../data/models/movie.dart';
import '../screens/detail/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    debugPrint('Movie Title: ${movie.title}');
    print(movie);
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
        padding: const EdgeInsets.only(left: 16.0, right: 6.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                movie.posterPath,
                width: 110,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 110, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 100,
              child: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppConstants.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

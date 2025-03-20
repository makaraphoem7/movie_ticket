import 'package:flutter/material.dart';

import '../../../../data/models/movie.dart';
class movie_download extends StatelessWidget {
  const movie_download({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}', // Replace with your image
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Episode. ${movie.id}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${movie.movieType} | ${movie.movieType}',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '${movie.timerofmovie} | ${movie.megabyteofmovie}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(Icons.download_outlined, color: Colors.white),
        ],
      ),
    );
  }
}
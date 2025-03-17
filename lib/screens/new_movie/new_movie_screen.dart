import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../data/mock_movies.dart';
import '../../widgets/movie_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/drawer_menu.dart';

class NewMovieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movies = MockMovies.getMovies(); // Load static movie list

    return Scaffold(
      backgroundColor: AppConstants.blackColor,
       drawer: CustomDrawer(
        onItemSelected: (index) {
          debugPrint('Selected index: $index');
        },
      ),
      appBar: const CustomAppBar(title: "New Movies"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            return MovieCard(movie: movies[index]);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import '../../constants/app_constants.dart';
import '../../widgets/movie_list.dart';
import '../../widgets/movie_slide.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/category_list.dart';
import '../../data/mock_movies.dart';
import '../../data/banner_slide.dart';
import '../../data/categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = MockMovies.getMovies();
    final banners = BannerSlide.getBanners();
    final categories = Categories.getCategories();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Movie App', style: TextStyle(color: Colors.white)),
      //   actions: const [
      //     Icon(Icons.search),
      //     SizedBox(width: 20),
      //     Icon(Icons.notifications_none),
      //     SizedBox(width: 10),
      //   ],
      // ),
      drawer: CustomDrawer(
        onItemSelected: (index) {
          debugPrint('Selected index: $index');
        },
      ),
      appBar: const CustomAppBar(title: "Movie App"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryList(categories: categories), // Display Category List
            BannerSlider(banners: banners),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align left and right
                children: [
                  Text(
                    'Most Popular',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppConstants.whiteColor),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to see all movies or any action
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(fontSize: 16, color: AppConstants.blueColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 400, // Fixed height for the movie list
              child: MovieList(movies: movies),
            ),
          ],
        ),
      ),
    );
  }
}

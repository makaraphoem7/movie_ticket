import 'package:flutter/material.dart';
import '../widgets/movie_list.dart';
import '../widgets/movie_slide.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/category_list.dart';
import '../../data/mock_movies.dart';
import '../../data/banner_slide.dart';
import '../../data/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Create an animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Animation duration
    );

    // Fade-in effect
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Scale-up effect
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the animations
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movies = MockMovies.getMovies();
    final banners = BannerSlide.getBanners();
    final categories = Categories.getCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App', style: TextStyle(color: Colors.white)),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 20),
          Icon(Icons.notifications_none),
          SizedBox(width: 10),
        ],
      ),
      drawer: CustomDrawer(
        onItemSelected: (index) {
          debugPrint('Selected index: $index');
        },
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryList(categories: categories), // Category List
                BannerSlider(banners: banners),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align left and right
                    children: [
                      const Text(
                        'Most Popular',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to see all movies or any action
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
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
        ),
      ),
    );
  }
}

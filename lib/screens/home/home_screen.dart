import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application_1/data/models/movie_slide.dart';
import '../../screens/home/popular_movies_screen.dart';
import 'filtered_movies_screen.dart';
import 'widgets/category_list.dart';
import '../../widgets/custom_nav_bar.dart';
import '../../widgets/movie_all.dart';
import '../../widgets/movie_card.dart';
import '../../constants/app_constants.dart';
import '../../widgets/movie_list.dart';
import 'widgets/movie_slide.dart';
import '../../widgets/drawer_menu.dart';
import '../../data/mock_movies.dart';
import '../../data/banner_slide.dart';
import '../../data/models/movie.dart';
import '../../data/models/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> allPopularMovies = [];
  List<Movie> displayedPopularMovies = [];
  List<Movie> allMovies = [];
  List<Movie> displayedAllMovies = [];
  List<Category> categories = [];
  List<CustomBanner> banners = []; // Stores banners

  int moviesPerPage = 10;
  bool isLoadingPopular = false;
  bool hasMorePopular = true;
  bool isLoadingAll = false;
  bool hasMoreAll = true;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadPopularMovies();
    loadAllMovies();
    loadCategories();
    loadBanners();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        loadMorePopularMovies();
        loadMoreAllMovies();
      }
    });
  }

  Future<void> loadCategories() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/categories.json');
      List<dynamic> jsonList = json.decode(jsonString);

      setState(() {
        categories = jsonList.map((json) => Category.fromJson(json)).toList();
      });
    } catch (e) {
      debugPrint("Error loading categories: $e");
    }
  }

  Future<void> loadPopularMovies() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/popularmovie.json');
      List<dynamic> jsonList = json.decode(jsonString);

      setState(() {
        allPopularMovies = jsonList.map((json) => Movie.fromJson(json)).toList();
        displayedPopularMovies = allPopularMovies.take(
          allPopularMovies.length < moviesPerPage ? allPopularMovies.length : moviesPerPage
        ).toList();
      });
    } catch (e) {
      debugPrint("Error loading popular movies: $e");
    }
  }

  void loadMorePopularMovies() async {
    if (isLoadingPopular || !hasMorePopular) return;

    setState(() {
      isLoadingPopular = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      int nextMoviesCount = displayedPopularMovies.length + moviesPerPage;
      if (nextMoviesCount >= allPopularMovies.length) {
        nextMoviesCount = allPopularMovies.length;
        hasMorePopular = false;
      }

      displayedPopularMovies = List.from(allPopularMovies.take(nextMoviesCount));
      isLoadingPopular = false;
    });
  }

  Future<void> loadAllMovies() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/allmovies.json');
      List<dynamic> jsonList = json.decode(jsonString);

      setState(() {
        allMovies = jsonList.map((json) => Movie.fromJson(json)).toList();
        displayedAllMovies = allMovies.take(
          allMovies.length < moviesPerPage ? allMovies.length : moviesPerPage
        ).toList();
      });
    } catch (e) {
      debugPrint("Error loading all movies: $e");
    }
  }

  void loadMoreAllMovies() async {
    if (isLoadingAll || !hasMoreAll) return;

    setState(() {
      isLoadingAll = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      int nextMoviesCount = displayedAllMovies.length + moviesPerPage;
      if (nextMoviesCount >= allMovies.length) {
        nextMoviesCount = allMovies.length;
        hasMoreAll = false;
      }

      displayedAllMovies = List.from(allMovies.take(nextMoviesCount));
      isLoadingAll = false;
    });
  }

  Future<void> loadBanners() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/slide.json');

      // Debugging: Print raw JSON string
      debugPrint("Raw JSON: $jsonString");

      List<dynamic> jsonList = json.decode(jsonString);

      if (jsonList.isEmpty) {
        debugPrint("Error: JSON list is empty.");
        return;
      }

      setState(() {
        banners = jsonList.map((json) {
          // Debugging: Check if 'bannerImage' is null
          if (json['bannerImage'] == null) {
            debugPrint("Warning: Found a null bannerImage in JSON.");
          }

          return CustomBanner.fromJson(json);
        }).toList();
      });

      debugPrint("Banners loaded successfully: ${banners.length}");
    } catch (e) {
      debugPrint("Error loading banners: $e");
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        onItemSelected: (index) {
          debugPrint('Selected index: $index');
        },
      ),
      appBar: const CustomNavBar(title: "PopcornTime"),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryList(
              categories: categories,
              onCategorySelected: (int selectedCategoryId) { 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilteredMoviesScreen(
                      allMovies: allMovies,
                      selectedCategoryIds: [selectedCategoryId], 
                      categories: categories,
                    ),
                  ),
                );
              },
            ),

            // **Banner Slider**
            banners.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : BannerSlider(banners: banners),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Popular',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppConstants.whiteColor),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  PopularMoviesScreen(movies: allPopularMovies),
                        ),
                      );
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
              height: 200,
              child: displayedPopularMovies.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : MovieList(movies: displayedPopularMovies),
            ),
            if (isLoadingPopular)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text(
                'All Movies',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppConstants.whiteColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: displayedAllMovies.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: displayedAllMovies.length,
                      itemBuilder: (context, index) {
                        return MovieAllCard(movie: displayedAllMovies[index]);
                      },
                    ),
            ),
            if (isLoadingAll)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

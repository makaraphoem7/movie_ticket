import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/movie.dart';
import '../../constants/app_constants.dart';
import '../../widgets/movie_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/drawer_menu.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class NewMovieScreen extends StatefulWidget {
  const NewMovieScreen({super.key});

  @override
  _NewMovieScreenState createState() => _NewMovieScreenState();
}

class _NewMovieScreenState extends State<NewMovieScreen> {
  List<Movie> allMovies = [];
  List<Movie> displayedMovies = [];
  int moviesPerPage = 12;
  bool isLoading = false;
  bool hasMore = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        loadMoreMovies();
      }
    });
  }

  Future<void> loadMovies() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/newmovies.json');
      List<dynamic> jsonList = json.decode(jsonString);
      
      setState(() {
        allMovies = jsonList.map((json) => Movie.fromJson(json)).toList();
        displayedMovies = allMovies.take(moviesPerPage).toList();
      });
    } catch (e) {
      debugPrint("Error loading movies: $e");
    }
  }

  void loadMoreMovies() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      int nextMoviesCount = displayedMovies.length + moviesPerPage;
      if (nextMoviesCount >= allMovies.length) {
        nextMoviesCount = allMovies.length;
        hasMore = false;
      }

      debugPrint("Before Update: ${displayedMovies.length} movies loaded.");
      displayedMovies = List.from(allMovies.take(nextMoviesCount));
      debugPrint("After Update: ${displayedMovies.length} movies loaded.");

      isLoading = false;
    });
  }


  int getCrossAxisCount(double screenWidth) {
    if (screenWidth > 1200) return 5; // Large screens
    if (screenWidth > 800) return 4;  // Tablets
    return 3; // Default to 3 items per row for mobile
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = getCrossAxisCount(screenWidth);

    return Scaffold(
      backgroundColor: AppConstants.blackColor,
      drawer: CustomDrawer(
        onItemSelected: (index) {
          debugPrint('Selected index: $index');
        },
      ),
      appBar: const CustomAppBar(title: "New Movies"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: displayedMovies.isEmpty
            ? const Center(child: CircularProgressIndicator()) // Initial loading
            : Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: displayedMovies.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount, 
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.65, 
                      ),
                      itemBuilder: (context, index) {
                        return MovieCard(
                          key: ValueKey(displayedMovies[index].id),
                          movie: displayedMovies[index],
                        );
                      },
                    ),
                  ),
                  if (isLoading)
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

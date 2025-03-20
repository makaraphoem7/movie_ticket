import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/movie_card.dart';
import '../../data/models/movie.dart';
import '../../data/models/category.dart';

class FilteredMoviesScreen extends StatefulWidget {
  final List<Movie> allMovies;
  final List<int> selectedCategoryIds;
  final List<Category> categories;

  const FilteredMoviesScreen({
    super.key,
    required this.allMovies,
    required this.selectedCategoryIds,
    required this.categories,
  });

  @override
  _FilteredMoviesScreenState createState() => _FilteredMoviesScreenState();
}

class _FilteredMoviesScreenState extends State<FilteredMoviesScreen> {
  List<Movie> filteredMovies = [];
  int _displayCount = 0; // Ensure it starts with a valid value
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filterMovies();
  }

void _filterMovies() {
  setState(() {
    if (widget.selectedCategoryIds.contains(0)) {
      // If "All" category (id = 0) is selected, show all movies
      filteredMovies = List.from(widget.allMovies);
    } else {
      // Collect all movie IDs from selected categories
      Set<int> selectedMovieIds = {};
      for (var category in widget.categories) {
        if (widget.selectedCategoryIds.contains(category.id)) {
          selectedMovieIds.addAll(category.movies);
        }
      }

      // Filter movies that match the collected movie IDs
      filteredMovies = widget.allMovies.where((movie) => selectedMovieIds.contains(movie.id)).toList();
    }

    // Ensure _displayCount is limited to 15 or the total number of movies
    _displayCount = filteredMovies.isNotEmpty 
        ? (filteredMovies.length < 15 ? filteredMovies.length : 15) 
        : 0;
  });
}

  void _loadMoreMovies() {
    if (_isLoading || _displayCount >= filteredMovies.length) return;

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _displayCount = (_displayCount + 15 > filteredMovies.length)
            ? filteredMovies.length
            : _displayCount + 15;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedCategoryNames = widget.categories
      .where((category) => widget.selectedCategoryIds.contains(category.id))
      .map((category) => category.name)
      .join(", ");
    return Scaffold(
      appBar: CustomAppBar(title: selectedCategoryNames.isNotEmpty ? selectedCategoryNames : "Filtered Movies"),
      body: Stack(
        children: [
          filteredMovies.isEmpty
              ? const Center(
                  child: Text(
                    "No movies found for the selected categories.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      _loadMoreMovies();
                    }
                    return true;
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _displayCount, // Safe item count
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return MovieCard(movie: filteredMovies[index]);
                    },
                  ),
                ),

          if (_isLoading)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

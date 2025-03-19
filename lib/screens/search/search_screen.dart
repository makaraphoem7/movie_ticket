import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../screens/detail/movie_detail_screen.dart';
import '../../widgets/movie_list.dart';
import '../../data/models/movie.dart';
import '../../constants/app_constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> allMovies = []; // Store all movies for searching
  List<Movie> searchResults = [];
  List<String> searchHistory = [];
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> recommendedMovies;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearch);
    popularMovies = _loadMovies('assets/data/popularmovie.json');
    recommendedMovies = _loadMovies('assets/data/newmovies.json');
    _loadAllMovies();
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearch);
    _searchController.dispose();
    super.dispose();
  }

  /// **Load Movies from JSON**
  Future<List<Movie>> _loadMovies(String path) async {
    try {
      String data = await rootBundle.loadString(path);
      List<dynamic> jsonList = json.decode(data);
      return jsonList.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      return []; // Return empty list on failure
    }
  }

  /// **Load all movies for search**
  void _loadAllMovies() async {
    List<Movie> popular = await _loadMovies('assets/data/popularmovie.json');
    List<Movie> recommended = await _loadMovies('assets/data/newmovies.json');
    setState(() {
      allMovies = [...popular, ...recommended]; // Merge both lists
    });
  }

  /// **Handle search input**
  void _handleSearch() {
    String query = _searchController.text.trim().toLowerCase();
    setState(() {
      searchResults = query.isEmpty
          ? []
          : allMovies.where((movie) => movie.title.toLowerCase().contains(query)).toList();
    });
  }

  /// **Store search query in history**
  void _storeSearchHistory(String query) {
    if (query.isNotEmpty && !searchHistory.contains(query)) {
      setState(() {
        searchHistory.insert(0, query);
      });
    }
  }

  /// **Clear search input**
  void _clearSearch() {
    setState(() {
      _searchController.clear();
      searchResults.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // **Search Bar**
              Row(
                children: [
                  if (Navigator.canPop(context))
                    CircleAvatar(
                      backgroundColor: Colors.white54,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: AppConstants.whiteColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[900],
                        hintText: "Search movies...",
                        hintStyle: TextStyle(color: Colors.white54),
                        prefixIcon: Icon(Icons.search, color: AppConstants.whiteColor),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.close, color: AppConstants.whiteColor),
                                onPressed: _clearSearch,
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: AppConstants.whiteColor),
                      onSubmitted: (query) {
                        _storeSearchHistory(query);
                        _handleSearch();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // **Search Results**
              Expanded(
                child: searchResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final movie = searchResults[index];
                          return ListTile(
                            leading: movie.posterPath.isNotEmpty
                                ? 
                                
                                Image.asset(
                                    movie.posterPath,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.image_not_supported, color: AppConstants.whiteColor),
                                  ),
                            title: Text(movie.title, style: TextStyle(color: AppConstants.whiteColor)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(movie: movie),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_searchController.text.isNotEmpty)
                            Center(
                              child: Text(
                                "No results found",
                                style: TextStyle(color: AppConstants.whiteColor, fontSize: 18),
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // **Search History**
                                if (searchHistory.isNotEmpty) ...[
                                  Text("Search History",
                                      style: TextStyle(
                                          color: AppConstants.whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    children: searchHistory.map((query) {
                                      return Chip(
                                        label: Text(query, style: TextStyle(color: AppConstants.whiteColor)),
                                        backgroundColor: Colors.grey[800],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        deleteIcon: Icon(Icons.close, color: AppConstants.whiteColor),
                                        onDeleted: () {
                                          setState(() {
                                            searchHistory.remove(query);
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 20),
                                ],

                                // **Popular Movies**
                                Text("Most Popular",
                                    style: TextStyle(
                                        color: AppConstants.whiteColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 200,
                                  child: FutureBuilder<List<Movie>>(
                                    future: popularMovies,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError || !snapshot.hasData) {
                                        return Center(child: Text("Failed to load movies", style: TextStyle(color: AppConstants.whiteColor)));
                                      }
                                      return MovieList(movies: snapshot.data!);
                                    },
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // **Recommended Movies**
                                Text("Recommended For You",
                                    style: TextStyle(
                                        color: AppConstants.whiteColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 200,
                                  child: FutureBuilder<List<Movie>>(
                                    future: recommendedMovies,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError || !snapshot.hasData) {
                                        return Center(child: Text("Failed to load movies", style: TextStyle(color: AppConstants.whiteColor)));
                                      }
                                      return MovieList(movies: snapshot.data!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

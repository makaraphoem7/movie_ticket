import 'package:flutter/material.dart';
import '../../data/mock_movies.dart';
import '../../widgets/movie_list.dart';
import '../../data/models/movie.dart';
import '../../constants/app_constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Movie> movies = MockMovies.getMovies();
  List<String> searchHistory = [];
  List<Movie> searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearch);
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearch);
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch() {
    String query = _searchController.text.trim();
    setState(() {
      if (query.isEmpty) {
        searchResults.clear();
      } else {
        searchResults = movies
            .where((movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      searchResults.clear();
    });
  }

  void _storeSearchHistory(String query) {
    if (query.isNotEmpty && !searchHistory.contains(query)) {
      setState(() {
        searchHistory.insert(0, query);
      });
    }
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
              // Back button and search bar in one row
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppConstants.primaryColor,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: AppConstants.whiteColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
              SizedBox(height: 15),

              // Display Search Results or History
              Expanded(
                child: searchResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final movie = searchResults[index];
                          return ListTile(
                            leading: movie.posterPath.isNotEmpty
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.image_not_supported, color: AppConstants.whiteColor),
                                  ),
                            title: Text(movie.title,
                                style: TextStyle(color: AppConstants.whiteColor)),
                            onTap: () {
                              _clearSearch();
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
                          else ...[
                            Text("Search History",
                                style: TextStyle(
                                    color: AppConstants.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
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
                            SizedBox(height: 20),
                            Text("Most Popular",
                                style: TextStyle(
                                    color: AppConstants.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 200,
                              child: MovieList(movies: movies),
                            ),
                            SizedBox(height: 20),
                            Text("Recommended For You",
                                style: TextStyle(
                                    color: AppConstants.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 200,
                              child: MovieList(movies: movies),
                            ),
                          ]
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

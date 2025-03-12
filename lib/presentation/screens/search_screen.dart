import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/mock_movies.dart';
import 'package:flutter_application_1/presentation/widgets/movie_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final movies = MockMovies.getMovies();
  List<String> searchHistory = [];
  final TextEditingController _searchController = TextEditingController();

  void _searchMovie(String query) {
    if (query.isNotEmpty) {
      setState(() {
        if (!searchHistory.contains(query)) {
          searchHistory.insert(0, query);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: "Search by title, category",
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
                onSubmitted: _searchMovie,
              ),
              SizedBox(height: 15),
              // Search History (Styled as Chips)
              Wrap(
                spacing: 8,
                children: searchHistory.map((query) {
                  return Chip(
                    label: Text(query, style: TextStyle(color: Colors.white)),
                    backgroundColor: const Color.fromARGB(255, 1, 1, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    deleteIcon: Icon(Icons.close, color: Colors.white),
                    onDeleted: () {
                      setState(() {
                        searchHistory.remove(query);
                      });
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 20),

              // Most Popular Movies
              Text("Most Popular",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: MovieList(movies: movies),
              ),

              SizedBox(height: 20),

              // Recommended Movies
              Text("Recommendation For You",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: MovieList(movies: movies),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

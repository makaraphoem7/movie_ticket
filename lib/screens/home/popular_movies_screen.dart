import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/movie_card.dart';
import '../../data/models/movie.dart';

class PopularMoviesScreen extends StatefulWidget {
  final List<Movie> movies;

  const PopularMoviesScreen({Key? key, required this.movies}) : super(key: key);

  @override
  _PopularMoviesScreenState createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  int _displayCount = 0; // Start with a valid count
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeDisplayCount();
  }

  void _initializeDisplayCount() {
    setState(() {
      _displayCount = widget.movies.isNotEmpty
          ? (widget.movies.length < 15 ? widget.movies.length : 15)
          : 0;
    });
  }

  void _loadMoreMovies() {
    if (_isLoading || _displayCount >= widget.movies.length) return;

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _displayCount = (_displayCount + 15 > widget.movies.length)
            ? widget.movies.length
            : _displayCount + 15;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Popular Movies"),
      body: Stack(
        children: [
          widget.movies.isEmpty
              ? const Center(child: Text('No Movies Found'))
              : NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      _loadMoreMovies();
                    }
                    return true;
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _displayCount,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return MovieCard(movie: widget.movies[index]);
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

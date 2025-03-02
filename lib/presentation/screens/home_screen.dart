import 'package:flutter/material.dart';
import '../widgets/movie_list.dart';
import '../../data/mock_movies.dart';
import '../widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = MockMovies.getMovies();

    final CustomAppBar = AppBar(
        title: Column(children: [
      Row(
        children: [
          // Image.network(
          //   '',
          //   width: 100,
          //   height: 100,
          // ),
          Text('Movie App', style: TextStyle(color: Colors.white)),
          Spacer(),
          Icon(Icons.search),
          SizedBox(width: 20),
          Icon(Icons.notifications_none),
        ],
      ),
    ]));
    return Scaffold(
      appBar: CustomAppBar,
      drawer: CustomDrawer(
        onItemSelected: (index) {
          print('Selected index: $index');
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(16.0), child: Text('Now Playing')),
          Expanded(
            child: MovieList(movies: movies),
          ),
        ],
      ),
    );
  }
}

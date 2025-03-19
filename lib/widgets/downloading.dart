import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Downloading extends StatefulWidget {
  @override
  _DownloadingScreenState createState() => _DownloadingScreenState();
}

class _DownloadingScreenState extends State<Downloading> {
  List<dynamic> downloadingMovies = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/moviesdownload.json');
    setState(() {
      downloadingMovies = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: downloadingMovies.isEmpty
          ? Center(child: CircularProgressIndicator(color: Colors.red))
          : ListView.builder(
              itemCount: downloadingMovies.length,
              itemBuilder: (context, index) {
                var movie = downloadingMovies[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            movie["image"],
                            width: 80,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie["title"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                movie["genre"],
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              Text(
                                "${movie["duration"]} | ${movie["size"]}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: LinearProgressIndicator(
                                  value: movie["progress"] / 100,
                                  backgroundColor: Colors.grey[800],
                                  color: Colors.red,
                                  minHeight: 5,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${movie["progress"]}%",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.pause, color: Colors.white),
                          onPressed: () {
                            // Pause/Resume Download
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

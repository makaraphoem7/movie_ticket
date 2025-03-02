import 'package:flutter/material.dart';

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming'),
      ),
      body: Center(
        child: Text('Upcoming Screen'),
      ),
    );
  }
}
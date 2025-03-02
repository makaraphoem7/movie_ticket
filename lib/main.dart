import 'package:flutter/material.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/open_app.dart';
// import 'screens/search_screen.dart';
import 'presentation/screens/favorites_screen.dart';
import 'presentation/screens/profile_screen.dart';
import 'presentation/widgets/bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          // backgroundColor: Color(0xFF0C142C),
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          // backgroundColor: Color(0xFF0C142C),
          backgroundColor: Colors.black,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey,
          
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        // scaffoldBackgroundColor:
        //     Color(0xFF0C142C), 
            scaffoldBackgroundColor: Colors.black
      ),
      home: SplashScreen(), // Start with Splash Screen
    );
  }
}

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0; // Track the selected index

  // List of screens to display based on the selected index
  final List<Widget> _screens = [
    HomeScreen(),
    // SearchScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}

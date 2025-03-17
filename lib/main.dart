import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../routes/app_router.dart';
import '../screens/new_movie/new_movie_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/boarding/open_app.dart';
import 'screens/search/search_screen.dart';
import 'screens/account/profile_screen.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      navigatorKey: AppRouter.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstants.blackColor,
          iconTheme: IconThemeData(color: AppConstants.whiteColor),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppConstants.primaryColor,
          selectedItemColor: AppConstants.secondaryColor,
          unselectedItemColor: AppConstants.greyColor,
        ),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppConstants.blackColor,
      ),
      home: SplashScreen(),
    );
  }
}

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    NewMovieScreen(),
    SearchScreen(),
    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

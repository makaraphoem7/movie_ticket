import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_constants.dart';
import 'package:flutter_application_1/routes/app_router.dart';
import 'screens/home/home_screen.dart';
import 'screens/boarding/open_app.dart';
import 'screens/search/search_screen.dart';
import 'screens/favorites_screen.dart';
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
      debugShowCheckedModeBanner: false, // Remove the debug banner
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
    FavoritesScreen(),
    SearchScreen(),
    ProfileScreen(),
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

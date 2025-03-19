import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/search/search_screen.dart';
import '../../constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: AppConstants.whiteColor, fontWeight: FontWeight.bold),
      ),
      backgroundColor: AppConstants.blackColor,
      elevation: 0,
      
      // Sidebar Menu Icon
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: AppConstants.whiteColor),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),

      actions: [
       IconButton(
          icon: Icon(Icons.search, color: AppConstants.whiteColor),
          onPressed: () {
            // Navigate to the SearchScreen
            // Navigator.pushReplacementNamed(context, Routes.searchscreen);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
        ),
        const SizedBox(width: 20),
        Icon(Icons.notifications_none, color: AppConstants.whiteColor),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

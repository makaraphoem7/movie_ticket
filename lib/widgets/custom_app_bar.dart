import 'package:flutter/material.dart';
import '../screens/search/search_screen.dart';
import '../routes/app_routes.dart';
import '../../constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: AppConstants.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 20, // Make title more readable
        ),
      ),
      backgroundColor: AppConstants.blackColor,
      elevation: 4, // Adds shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Rounded bottom
      ),

      // Sidebar Menu Icon
      leading: IconButton(
        icon: Icon(Icons.menu, color: AppConstants.whiteColor, size: 28),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),

      actions: [
        // Search Icon
        IconButton(
          icon: Icon(Icons.search, color: AppConstants.whiteColor, size: 28),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
        ),

        // Notification Icon with Badge
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_none, color: AppConstants.whiteColor, size: 28),
              onPressed: () {
                // Handle notification tap
              },
            ),
            Positioned(
              right: 10,
              top: 6,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '3', // Example unread count
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(width: 10), // Add space
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

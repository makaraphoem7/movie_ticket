import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/routes/app_routes.dart';
import '../screens/search/search_screen.dart';
import '../screens/notifications/notification_screen.dart';
import '../../constants/app_constants.dart';

class CustomNavBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomNavBar({super.key, required this.title});

  @override
  _CustomNavBarState createState() => _CustomNavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomNavBarState extends State<CustomNavBar> {
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      final String response = await rootBundle.loadString('assets/data/notification.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        notifications = data
            .map((item) => {"message": item['message'].toString(), "date": item['date'].toString()})
            .take(3)
            .toList();
      });
    } catch (e) {
      print("Error loading notifications: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(
          color: AppConstants.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.5), // Semi-transparent black
      elevation: 0, // Remove shadow
      shadowColor: Colors.transparent, // No shadow
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu, color: AppConstants.whiteColor, size: 28),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: AppConstants.whiteColor, size: 28),
          onPressed: () {
            Navigator.pushNamed(context, Routes.searchscreen);
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_none, color: AppConstants.whiteColor, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(notifications: notifications),
                  ),
                );
              },
            ),
            if (notifications.isNotEmpty)
              Positioned(
                right: 10,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppConstants.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${notifications.length}',
                    style: TextStyle(
                      color: AppConstants.whiteColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

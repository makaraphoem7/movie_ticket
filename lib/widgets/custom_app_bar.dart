import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      
      // Sidebar Menu Icon
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer(); // ✅ Open sidebar (drawer)
          },
        ),
      ),

      actions: const [
        Icon(Icons.search, color: Colors.white),
        SizedBox(width: 20),
        Icon(Icons.notifications_none, color: Colors.white),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

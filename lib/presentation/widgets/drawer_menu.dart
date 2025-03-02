import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {


  final Function(int) onItemSelected;
  const CustomDrawer({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF0C142C),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF0C142C),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                SizedBox(width: 10),
                Text(
                  'Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () => onItemSelected(0),
          ),
          ListTile(
            leading: const Icon(Icons.search, color: Colors.white),
            title: const Text('Search', style: TextStyle(color: Colors.white)),
            onTap: () => onItemSelected(1),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () => onItemSelected(2),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Function(int) onItemSelected;
  const CustomDrawer({super.key, required this.onItemSelected});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isNotificationEnabled = false; // State to track icon status

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0C142C),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF0C142C),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                const SizedBox(width: 10),
                const Text(
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
            onTap: () => widget.onItemSelected(0),
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.white),
            title: const Text('Notification', style: TextStyle(color: Colors.white)),
            trailing: Icon(
              isNotificationEnabled ? Icons.toggle_on : Icons.toggle_off,
              color: isNotificationEnabled ? Colors.green : Colors.grey,
              size: 30,
            ),
            onTap: () {
              setState(() {
                isNotificationEnabled = !isNotificationEnabled; // Toggle icon state
              });
              widget.onItemSelected(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () => widget.onItemSelected(2),
          ),
        ],
      ),
    );
  }
}

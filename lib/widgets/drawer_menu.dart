import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_constants.dart';

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
                Text(
                  'Movies',
                  style: TextStyle(
                    color: AppConstants.whiteColor,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: AppConstants.whiteColor),
            title: Text('Home', style: TextStyle(color: AppConstants.whiteColor)),
            onTap: () => widget.onItemSelected(0),
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: AppConstants.whiteColor),
            title: Text('Notification', style: TextStyle(color: AppConstants.whiteColor)),
            trailing: Icon(
              isNotificationEnabled ? Icons.toggle_on : Icons.toggle_off,
              color: isNotificationEnabled ? AppConstants.greenColor : AppConstants.greyColor,
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
            leading: Icon(Icons.person, color: AppConstants.whiteColor),
            title: Text('Profile', style: TextStyle(color: AppConstants.whiteColor)),
            onTap: () => widget.onItemSelected(2),
          ),
        ],
      ),
    );
  }
}

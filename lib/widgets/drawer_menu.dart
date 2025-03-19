import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../constants/app_constants.dart';
import 'custom_dialog.dart';

class CustomDrawer extends StatefulWidget {
  final Function(int) onItemSelected;
  const CustomDrawer({super.key, required this.onItemSelected});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isNotificationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF0C142C),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF0C142C),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/logo_app.png'),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                _buildListTile(Icons.person, "Profile", 2),
                _buildNotificationTile(),
                _buildListTile(Icons.person_add, "Add Account", 3),
                _buildListTile(Icons.info, "About Us", 4),
                _buildLogoutTile(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: AppConstants.whiteColor),
      title: Text(title, style: TextStyle(color: AppConstants.whiteColor)),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        if (index == 2) {
          Navigator.pushNamed(context, Routes.profilescreen);
        } else if (index == 4) {
          Navigator.pushNamed(context, Routes.aboutUs);
        } else {
          widget.onItemSelected(index);
        }

      },
    );
  }

  Widget _buildNotificationTile() {
    return ListTile(
      leading: Icon(Icons.notifications, color: AppConstants.whiteColor),
      title: Text('Notification', style: TextStyle(color: AppConstants.whiteColor)),
      trailing: Icon(
        isNotificationEnabled ? Icons.toggle_on : Icons.toggle_off,
        color: isNotificationEnabled ? AppConstants.greenColor : AppConstants.greyColor,
        size: 30,
      ),
      onTap: () {
        setState(() {
          isNotificationEnabled = !isNotificationEnabled;
        });
        widget.onItemSelected(1);
      },
    );
  }

  Widget _buildLogoutTile() {
    return ListTile(
      leading: Icon(Icons.logout, color: AppConstants.whiteColor),
      title: Text("Log Out", style: TextStyle(color: AppConstants.whiteColor)),
      onTap: () => _showLogoutDialog(),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: "Confirm Logout",
          message: "Are you sure you want to log out?",
          confirmText: "Yes",
          cancelText: "No",
          onConfirm: () {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, Routes.login);
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}

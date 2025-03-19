import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class CustomAppBar extends StatelessWidget {
  final String? title; // Optional Title

  const CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 5, right: 0, bottom: 14), // Add top padding
      child: Row(
        children: [
          if (Navigator.canPop(context)) // Show back button only if possible to pop
            CircleAvatar(
              backgroundColor: Colors.white54,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: AppConstants.whiteColor),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          if (Navigator.canPop(context)) const SizedBox(width: 15), // Add spacing if back button exists
          if (title != null) // Show title only if provided
            Expanded(
              child: Text(
                title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis, // Prevents long titles from breaking UI
              ),
            ),
        ],
      ),
    );
  }
}

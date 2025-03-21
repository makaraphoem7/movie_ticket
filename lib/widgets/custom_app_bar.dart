import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 10, right: 0, bottom: 0),
      child: Row(
        children: [
          if (Navigator.canPop(context))
            CircleAvatar(
              backgroundColor: Colors.white54,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: AppConstants.whiteColor),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          if (Navigator.canPop(context)) const SizedBox(width: 15),
          if (title != null)
            Expanded(
              child: Text(
                title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

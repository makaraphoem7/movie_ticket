import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = "Yes",
    this.cancelText = "No",
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: AppConstants.blackColor, // Light background
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstants.whiteColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Message
            Text(
              message,
              style: TextStyle(
                fontSize: 18,
                color: AppConstants.whiteColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Underline after title
            Container(
              width: double.infinity,
              height: 1.50,
              color: AppConstants.whiteColor.withOpacity(0.6),
              margin: const EdgeInsets.symmetric(vertical: 8),
            ),
            // No | Yes Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // No Button
                TextButton(
                  onPressed: onCancel,
                  child: Text(
                    cancelText,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppConstants.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                // Separator
                Text(
                  " | ",
                  style: TextStyle(fontSize: 18, color: AppConstants.whiteColor.withOpacity(0.6)),
                ),

                // Yes Button
                TextButton(
                  onPressed: onConfirm,
                  child: Text(
                    confirmText,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppConstants.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

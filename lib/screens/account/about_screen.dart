import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C142C), // Background color matching your theme
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40), // Adjust top spacing
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppConstants.greyColor, // Use AppConstants.primaryColor if defined
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: AppConstants.whiteColor), // Use AppConstants.whiteColor if defined
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Spacing between icon and text
                  Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.whiteColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Space after title
              Text(
                "Welcome to MovieTime!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.whiteColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "MovieTime is your ultimate destination for discovering and watching your favorite movies. "
                "With a vast collection of the latest blockbusters, classic films, and trending shows, "
                "we bring entertainment right to your fingertips.",
                style: TextStyle(fontSize: 16, color: AppConstants.whiteColor),
              ),
              SizedBox(height: 20),
              Text(
                "Our Features:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.whiteColor,
                ),
              ),
              SizedBox(height: 10),
              _buildFeatureItem("🎥 Watch Movies Anytime, Anywhere"),
              _buildFeatureItem("⭐ Get Personalized Recommendations"),
              _buildFeatureItem("📅 Stay Updated with Upcoming Releases"),
              _buildFeatureItem("💬 User Reviews & Ratings"),
              _buildFeatureItem("🎬 HD Streaming with No Ads"),
              _buildFeatureItem("🔎 Advanced Search & Filtering"),
              SizedBox(height: 20),
              Text(
                "Why Choose Us?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.whiteColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "At MovieTime, we are committed to providing the best streaming experience with high-quality content, "
                "user-friendly navigation, and exclusive movie collections.",
                style: TextStyle(fontSize: 16, color: AppConstants.whiteColor),
              ),
              SizedBox(height: 20),
              Text(
                "Contact Us:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.whiteColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "📧 Email: support@movietime.com\n"
                "📍 Address: 123 Movie Street, Hollywood, CA\n"
                "📱 Phone: +1 234 567 890",
                style: TextStyle(fontSize: 16, color: AppConstants.whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppConstants.greenColor),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: AppConstants.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}

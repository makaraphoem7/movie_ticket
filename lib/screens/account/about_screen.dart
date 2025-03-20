import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../widgets/custom_app_bar.dart'; // Import the reusable AppBar

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.blackColor,
      appBar: CustomAppBar(title: "About Us"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomAppBar(title: "About Us"), // Call the reusable AppBar
              const SizedBox(height: 20),
              _buildSectionTitle("Welcome to MovieTime!"),
              const SizedBox(height: 10),
              _buildDescription(
                "MovieTime is your ultimate destination for discovering and watching your favorite movies. "
                "With a vast collection of the latest blockbusters, classic films, and trending shows, "
                "we bring entertainment right to your fingertips.",
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("Our Features:"),
              const SizedBox(height: 10),
              _buildFeatureItem(Icons.movie, "Watch Movies Anytime, Anywhere"),
              _buildFeatureItem(Icons.star, "Get Personalized Recommendations"),
              _buildFeatureItem(Icons.calendar_today, "Stay Updated with Upcoming Releases"),
              _buildFeatureItem(Icons.rate_review, "User Reviews & Ratings"),
              _buildFeatureItem(Icons.hd, "HD Streaming with No Ads"),
              _buildFeatureItem(Icons.search, "Advanced Search & Filtering"),
              const SizedBox(height: 20),
              _buildSectionTitle("Why Choose Us?"),
              const SizedBox(height: 10),
              _buildDescription(
                "At MovieTime, we are committed to providing the best streaming experience with high-quality content, "
                "user-friendly navigation, and exclusive movie collections.",
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("Contact Us:"),
              const SizedBox(height: 10),
              _buildDescription(
                "📧 Email: support@movietime.com\n"
                "📍 Address: 123 Movie Street, Hollywood, CA\n"
                "📱 Phone: +1 234 567 890",
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppConstants.whiteColor,
      ),
    );
  }

  Widget _buildDescription(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, color: AppConstants.whiteColor),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, color: AppConstants.greenColor),
          const SizedBox(width: 10),
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

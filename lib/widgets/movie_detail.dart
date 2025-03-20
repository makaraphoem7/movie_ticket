import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../data/models/movie.dart';
import '../routes/app_router.dart';
import '../routes/app_routes.dart';
import '../screens/payments/subscription_screen.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: Image.asset(
                  movie.posterPath, // Ensure path is correct
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 14,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: AppConstants.primaryColor,
                  child: IconButton(
                    icon:
                        Icon(Icons.arrow_back, color: AppConstants.whiteColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: MediaQuery.of(context).size.width / 2 - 30,
                child: CircleAvatar(
                  backgroundColor: AppConstants.primaryColor,
                  child: IconButton(
                    icon: Icon(Icons.play_arrow_outlined,
                        color: AppConstants.whiteColor),
                    onPressed: () {
                      AppRouter.pushNamed(Routes.subscriptionScreen);
                    },
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.whiteColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overview,
                  style: TextStyle(color: AppConstants.greyColor),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.secondaryColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    AppRouter.pushNamed(Routes.subscriptionScreen);
                    // _navigateToSubscription(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow_outlined,
                          color: AppConstants.whiteColor),
                      const SizedBox(width: 8),
                      Text('Play Now',
                          style: TextStyle(color: AppConstants.whiteColor)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppConstants.whiteColor),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    AppRouter.pushNamed(Routes.subscriptionScreen);
                    // _navigateToSubscription(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.download_outlined,
                          color: AppConstants.whiteColor),
                      const SizedBox(width: 8),
                      Text('Download',
                          style: TextStyle(color: AppConstants.whiteColor)),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  movie.overview,
                  style: TextStyle(color: AppConstants.greyColor),
                ),
                SizedBox(height: 16),
                Text(
                  'Episode',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.whiteColor,
                  ),
                ),
                Divider(color: AppConstants.whiteColor),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          movie.posterPath, // Replace with your image
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Episode. ${movie.id}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.whiteColor,
                              ),
                            ),
                            Text(
                              '${movie.movieType} | ${movie.movieType}',
                              style: TextStyle(color: AppConstants.greyColor),
                            ),
                            Text(
                              '${movie.timerofmovie} | ${movie.megabyteofmovie}',
                              style: TextStyle(color: AppConstants.whiteColor),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.download_outlined,
                          color: AppConstants.whiteColor),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // void _navigateToSubscription(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
  //   );
  // }
}

import 'package:flutter/material.dart';
import '../../data/models/banner.dart';

class BannerSlider extends StatefulWidget {
  final List<CustomBanner> banners;

  const BannerSlider({super.key, required this.banners});

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92, initialPage: _currentPage);
    _startImageSlider();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startImageSlider() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _currentPage = (_currentPage + 1) % widget.banners.length;
      });

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      _startImageSlider();
    });
  }

  @override
  Widget build(BuildContext context) {
    const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

    return Column(
      children: [
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              final imageUrl = '$imageBaseUrl${banner.bannerImage}';

              double scale = 1.0;
              if (_pageController.position.haveDimensions) {
                double currentPage = _pageController.page ?? _currentPage.toDouble();
                double difference = (index - currentPage).abs();
                scale = (1 - (difference * 0.1)).clamp(0.9, 1.0);
              }

              return Transform.scale(
                scale: scale,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ClipRRect(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Dot Indicator
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.banners.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentPage == index ? Colors.red : Colors.grey.shade400,
              ),
            );
          }),
        ),
      ],
    );
  }
}

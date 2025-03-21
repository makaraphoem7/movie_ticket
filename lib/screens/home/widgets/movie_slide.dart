import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../data/models/movie_slide.dart';

class BannerSlider extends StatefulWidget {
  final List<CustomBanner> banners;

  const BannerSlider({super.key, required this.banners});

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> with WidgetsBindingObserver {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _restoreLastSlide();
    _startAutoSlide();
  }

  void _restoreLastSlide() {
    int savedPage = PageStorage.of(context).readState(context) as int? ?? 0;
    _currentPage = savedPage;
    _pageController = PageController(viewportFraction: 0.75, initialPage: _currentPage);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _isPaused = false;
      _startAutoSlide();
    } else if (state == AppLifecycleState.paused) {
      _isPaused = true;
      _timer?.cancel();
    }
  }

  void _startAutoSlide() {
    if (_isPaused || !mounted) return;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || _pageController.page == null) return;
      int nextPage = (_currentPage + 1) % widget.banners.length;

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }

      setState(() {
        _currentPage = nextPage;
        PageStorage.of(context).writeState(context, _currentPage);
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banner = widget.banners[_currentPage];

    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Image.asset(
              banner.bannerImage,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 480,
              child: PageView.builder(
                key: const PageStorageKey('banner_slider'),
                controller: _pageController,
                itemCount: widget.banners.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    PageStorage.of(context).writeState(context, _currentPage);
                  });
                },
                itemBuilder: (context, index) {
                  final banner = widget.banners[index];

                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double scale = 1.0;
                      double opacity = 1.0;

                      if (_pageController.position.haveDimensions) {
                        double currentPage = _pageController.page ?? _currentPage.toDouble();
                        double difference = (index - currentPage).abs();
                        scale = (1 - (difference * 0.2)).clamp(0.85, 1.0);
                        opacity = (1 - (difference * 0.4)).clamp(0.5, 1.0);
                      }

                      return Transform.scale(
                        scale: scale,
                        child: Opacity(
                          opacity: opacity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.asset(
                              banner.bannerImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 100),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.banners.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 14 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == index ? AppConstants.secondaryColor : AppConstants.greyColor,
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class BannerSlide {
  final String bannerImage;

  BannerSlide({required this.bannerImage});

  factory BannerSlide.fromJson(Map<String, dynamic> json) {
    return BannerSlide(
      bannerImage: json['bannerImage'],
    );
  }

  static Future<List<BannerSlide>> getBanners() async {
    String jsonString = await rootBundle.loadString('assets/data/slide.json');
    List<dynamic> jsonList = json.decode(jsonString);
    
    return jsonList.map((json) => BannerSlide.fromJson(json)).toList();
  }
}

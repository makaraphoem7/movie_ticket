class CustomBanner {
  final int id;
  final String bannerImage;

  CustomBanner({required this.id, required this.bannerImage});

  factory CustomBanner.fromJson(Map<String, dynamic> json) {
    return CustomBanner(
      id: json['id'] ?? 0,
      bannerImage: json['bannerImage'] ?? 'assets/images/default.png',
    );
  }
}

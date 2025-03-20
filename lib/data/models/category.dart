class Category {
  final int id;
  final String name;
  final List<int> movies; // Add this line

  Category({
    required this.id,
    required this.name,
    required this.movies, // Include this in the constructor
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      movies: (json['movies'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
    );
  }
}

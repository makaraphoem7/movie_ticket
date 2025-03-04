import 'models/category.dart';

class Categories {
  static List<Category> getCategories() {
    return [
      Category(
        id: 1,
        name: 'Action',
      ),
      Category(
        id: 2,
        name: 'Comedy',
      ),
      Category(
        id: 3,
        name: 'Drama',
      ),
      Category(
        id: 4,
        name: 'Science Fiction',
      ),
      Category(
        id: 5,
        name: 'Romance',
      ),
      Category(
        id: 6,
        name: 'Horror',
      ),
      Category(
        id: 7,
        name: 'Adventure',
      ),
      Category(
        id: 8,
        name: 'Thriller',
      ),
    ];
  }
}

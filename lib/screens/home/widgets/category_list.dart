import 'package:flutter/material.dart';
import '../../../data/models/category.dart';
import 'category_card.dart'; // Import CategoryCard
import '../../../constants/app_constants.dart';

class CategoryList extends StatefulWidget {
  final List<Category> categories;
  final Function(int) onCategorySelected;

  const CategoryList({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.categories.length,
          padding: const EdgeInsets.only(left: 10),
          itemBuilder: (context, index) {
            final category = widget.categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CategoryCard(
                category: category,
                isSelected: _selectedIndex == index,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onCategorySelected(category.id);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../data/models/category.dart';

class CategoryList extends StatefulWidget {
  final List<Category> categories;

  const CategoryList({super.key, required this.categories});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int _selectedIndex = 0; // Track the selected category

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20), // Add space from the top
      child: SizedBox(
        height: 40, // Slightly increased for better UI
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.categories.length,
          padding: const EdgeInsets.only(left: 10), // Shift content slightly to the right
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
                  print('Selected category: ${category.name}');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16), // Add padding for better appearance
        constraints: const BoxConstraints(minWidth: 60), // Minimum width to prevent too small cards
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : const Color.fromARGB(167, 20, 20, 20),
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            category.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

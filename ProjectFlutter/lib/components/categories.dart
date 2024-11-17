import 'package:flutter/material.dart';
import '../models/Category.dart';
import '../screens/food/food_screen.dart';

class Categories extends StatelessWidget {
  final List<Category> categories;

  const Categories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            categoryName: categories[index].name,
            categoryIcon: categories[index].icon,
            categoryId: categories[index].id,
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.categoryName,
    required this.categoryIcon,
    this.categoryId,
  }) : super(key: key);

  final String categoryName;
  final String categoryIcon;
  final int? categoryId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => foodsScreen(categoryId: categoryId),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              categoryIcon,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            categoryName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

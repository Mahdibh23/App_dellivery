import 'package:flutter/material.dart';
import '/models/Category.dart';
import '../../services/FoodService.dart';

class InsertCategoryPage extends StatefulWidget {
  static const routeName = '/insert_category';

  @override
  _InsertCategoryPageState createState() => _InsertCategoryPageState();
}

class _InsertCategoryPageState extends State<InsertCategoryPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _iconController = TextEditingController();

  void _saveCategory() {
    final String name = _nameController.text.trim();
    final String icon = _iconController.text.trim();

    if (name.isNotEmpty && icon.isNotEmpty) {
      final Category newCategory = Category(
        name: name,
        icon: icon,
      );

      FoodService.addCategory(newCategory);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );

      _nameController.clear();
      _iconController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _iconController,
              decoration: const InputDecoration(labelText: 'Category Icon'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveCategory,
              child: const Text('Save Category'),
            ),
          ],
        ),
      ),
    );
  }
}

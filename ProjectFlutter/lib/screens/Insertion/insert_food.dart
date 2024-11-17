import 'package:flutter/material.dart';
import '../../models/Food.dart';
import '../../models/Category.dart';
import '../../services/FoodService.dart';

class InsertFoodPage extends StatefulWidget {
  static const routeName = '/insert_food';

  @override
  _InsertFoodPageState createState() => _InsertFoodPageState();
}

class _InsertFoodPageState extends State<InsertFoodPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  int? _selectedCategoryId;
  List<Category> _categories = [];
  bool _isLoadingCategories = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await FoodService.fetchCategories();
      setState(() {
        _categories = categories;
        _isLoadingCategories = false;
      });
    } catch (e) {
      print('Failed to load categories: $e');
      setState(() {
        _isLoadingCategories = false;
      });
    }
  }

  void _saveFood() {
    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();
    final String image = _imageController.text.trim();
    final double rating = double.tryParse(_ratingController.text.trim()) ?? 0.0;
    final double price = double.tryParse(_priceController.text.trim()) ?? 0.0;
    final int? categoryId = _selectedCategoryId;

    if (title.isNotEmpty &&
        description.isNotEmpty &&
        image.isNotEmpty &&
        rating >= 0 &&
        price >= 0 &&
        categoryId != null) {
      final Food newFood = Food(
        title: title,
        description: description,
        image: image,
        rating: rating,
        price: price,
        isFavourite: false,
        isPopular: false,
        categorieId: categoryId,
      );

      FoodService.addFood(newFood as Food);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Food added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );

      _titleController.clear();
      _descriptionController.clear();
      _imageController.clear();
      _ratingController.clear();
      _priceController.clear();
      setState(() {
        _selectedCategoryId = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields correctly.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _ratingController,
                decoration: const InputDecoration(labelText: 'Rating'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              _isLoadingCategories
                  ? CircularProgressIndicator()
                  : DropdownButtonFormField<int>(
                      decoration: const InputDecoration(labelText: 'Category'),
                      value: _selectedCategoryId,
                      items: _categories.map((Category category) {
                        return DropdownMenuItem<int>(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedCategoryId = newValue;
                        });
                      },
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveFood,
                child: const Text('Save Food'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/Category.dart';
import '/components/categories.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriesController extends StatefulWidget {
  const CategoriesController({Key? key}) : super(key: key);

  @override
  _CategoriesControllerState createState() => _CategoriesControllerState();
}

class _CategoriesControllerState extends State<CategoriesController> {
  late Future<List<Category>> _categoriesFuture;

  Future<List<Category>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/categorie'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  void initState() {
    super.initState();
    _categoriesFuture = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Categories(categories: snapshot.data!);
        }
      },
    );
  }
}

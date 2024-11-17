import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/Category.dart';
import '../models/Food.dart';

class FoodService {
  static Future<List<Food>> fetchPopularFoods() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/food'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((data) => Food.fromJson(data))
          .where((food) => food.isPopular)
          .toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }

  static Future<List<Food>> fetchFavouriteFoods() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/food'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((data) => Food.fromJson(data))
          .where((food) => food.isFavourite)
          .toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }

  static Future<List<Food>> fetchFoods() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/food'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((data) => Food.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }

  static Future<List<Food>> fetchFoodsByCategory(int categoryId) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/food'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Food> foods = data
          .map((json) => Food.fromJson(json))
          .where((food) => food.categorieId == categoryId)
          .toList();
      return foods;
    } else {
      throw Exception('Failed to load foods by category');
    }
  }

  static Future<void> addFood(Food Food) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/insertFood');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, Object>{
          'title': Food.title,
          'description': Food.description,
          'image': Food.image,
          'rating': Food.rating,
          'price': Food.price,
          'isFavourite': Food.isFavourite ? 1 : 0,
          'isPopular': Food.isPopular ? 1 : 0,
          'categorieId': Food.categorieId,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('Food added successfully');
      } else {
        throw Exception('Failed to add food');
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<void> addCategory(Category categore) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/insertCategorie');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': categore.name,
          'icon': categore.icon,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('Category $response');
      } else {
        throw Exception('Failed to add category');
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<List<Category>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/categorie'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<void> deleteCategory(int categoryId) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/categorie/$categoryId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete category');
    }
  }

  static Future<void> deleteFood(int foodId) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/food/$foodId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete food');
    }
  }
}

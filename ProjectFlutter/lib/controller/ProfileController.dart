// profile_controller.dart
import 'package:flutter/material.dart';
import 'package:shop_app/services/FoodService.dart';
import '/models/User.dart';
import '/models/Category.dart';
import '/models/Food.dart';
import '../screens/init_screen.dart';

class ProfileController extends ChangeNotifier {
  User? currentUser;
  List<Category> categories = [];
  List<Food> foods = [];
  int? selectedCategoryId;
  int? selectedFoodId;
  bool isLoadingCategories = false;
  bool isLoadingFoods = false;

  ProfileController() {
    fetchCurrentUser();
    fetchCategories();
    fetchFoods();
  }

  void fetchCurrentUser() {
    final arguments = InitScreen.currentUser;
    if (arguments != null) {
      currentUser = arguments;
    } else {
      currentUser = null;
    }
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    isLoadingCategories = true;
    notifyListeners();
    try {
      categories = await FoodService.fetchCategories();
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoadingCategories = false;
      notifyListeners();
    }
  }

  Future<void> fetchFoods() async {
    isLoadingFoods = true;
    notifyListeners();
    try {
      foods = (await FoodService.fetchFoods()).cast<Food>();
    } catch (e) {
      print("Error fetching foods: $e");
    } finally {
      isLoadingFoods = false;
      notifyListeners();
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    try {
      await FoodService.deleteCategory(categoryId);
      fetchCategories();
    } catch (e) {
      print("Error deleting category: $e");
    }
  }

  Future<void> deleteFood(int foodId) async {
    try {
      await FoodService.deleteFood(foodId);
      fetchFoods();
    } catch (e) {
      print("Error deleting food: $e");
    }
  }
}

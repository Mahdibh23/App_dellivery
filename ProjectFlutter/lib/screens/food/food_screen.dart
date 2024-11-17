import 'package:flutter/material.dart';
import 'package:shop_app/components/food_card.dart';
import 'package:shop_app/models/Food.dart';
import '../../services/FoodService.dart';
import '../details/details_screen.dart';

class foodsScreen extends StatefulWidget {
  static String routeName = "/foods";
  final int? categoryId;

  const foodsScreen({Key? key, this.categoryId}) : super(key: key);

  @override
  _foodsScreenState createState() => _foodsScreenState();
}

class _foodsScreenState extends State<foodsScreen> {
  late Future<List<Food>> _foodsFuture;

  @override
  void initState() {
    super.initState();
    if (widget.categoryId != null) {
      _foodsFuture = FoodService.fetchFoodsByCategory(widget.categoryId!);
    } else {
      // Fetch all foods if no categoryId is provided
      _foodsFuture = FoodService.fetchFoods();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("foods"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List<Food>>(
            future: _foodsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => FoodCard(
                    food: snapshot.data![index],
                    onPress: () => Navigator.pushNamed(
                      context,
                      DetailsScreen.routeName,
                      arguments:
                          FoodDetailsArguments(food: snapshot.data![index]),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/models/Food.dart';
import '../components/popular_food.dart';
import '../services/FoodService.dart';

class PopularFoodsController extends StatefulWidget {
  const PopularFoodsController({Key? key}) : super(key: key);

  @override
  _PopularFoodsControllerState createState() => _PopularFoodsControllerState();
}

class _PopularFoodsControllerState extends State<PopularFoodsController> {
  late Future<List<Food>> _popularFoodsFuture;

  @override
  void initState() {
    super.initState();
    _popularFoodsFuture = FoodService.fetchPopularFoods();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(
      future: _popularFoodsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return PopularFoods(popularFoods: snapshot.data!);
        }
      },
    );
  }
}

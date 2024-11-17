import 'package:flutter/material.dart';
import 'package:shop_app/models/Food.dart';
import '../components/popular_food.dart'; // Assurez-vous que ce composant peut également afficher les aliments préférés
import '../services/FoodService.dart';

class FoodsController extends StatefulWidget {
  const FoodsController({Key? key}) : super(key: key);

  @override
  _FoodsControllerState createState() => _FoodsControllerState();
}

class _FoodsControllerState extends State<FoodsController> {
  late Future<List<Food>> _FoodsFuture;

  @override
  void initState() {
    super.initState();
    _FoodsFuture = FoodService.fetchFoods();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(
      future: _FoodsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot);
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return PopularFoods(popularFoods: snapshot.data!);
        }
      },
    );
  }
}

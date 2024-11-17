import 'package:flutter/material.dart';
import 'package:shop_app/models/Food.dart';
import '../components/popular_food.dart'; // Assurez-vous que ce composant peut également afficher les aliments préférés
import '../services/FoodService.dart';

class FavouriteFoodsController extends StatefulWidget {
  const FavouriteFoodsController({Key? key}) : super(key: key);

  @override
  _FavouriteFoodsControllerState createState() =>
      _FavouriteFoodsControllerState();
}

class _FavouriteFoodsControllerState extends State<FavouriteFoodsController> {
  late Future<List<Food>> _favouriteFoodsFuture;

  @override
  void initState() {
    super.initState();
    _favouriteFoodsFuture = FoodService.fetchFavouriteFoods();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(
      future: _favouriteFoodsFuture,
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

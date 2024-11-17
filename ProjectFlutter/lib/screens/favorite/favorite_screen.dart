import 'package:flutter/material.dart';
import 'package:shop_app/components/food_card.dart';
import 'package:shop_app/models/Food.dart';
import 'package:shop_app/services/FoodService.dart'; // Corrected the import statement
import 'package:shop_app/screens/details/details_screen.dart'; // Corrected the import statement

class FavoriteScreen extends StatefulWidget {
  static String routeName = "/favorite";

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<Food>> futureFoods;

  @override
  void initState() {
    super.initState();
    futureFoods = FoodService.fetchFavouriteFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop('/init');
          },
        ),
        title: const Text("Favorites"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Favorites",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<List<Food>>(
                  future: futureFoods,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No favorite foods found'));
                    }

                    List<Food> demoFoods = snapshot.data!;

                    return GridView.builder(
                      itemCount: demoFoods.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) => FoodCard(
                        food: demoFoods[index],
                        onPress: () => Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments:
                              FoodDetailsArguments(food: demoFoods[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

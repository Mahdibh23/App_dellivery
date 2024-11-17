import 'package:flutter/material.dart';
import 'package:shop_app/models/Food.dart';
import 'package:shop_app/components/food_card.dart';
import 'package:shop_app/components/section_title.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/food/food_screen.dart';

class PopularFoods extends StatelessWidget {
  final List<Food> popularFoods;

  const PopularFoods({Key? key, required this.popularFoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Foods",
            press: () {
              Navigator.pushNamed(context, foodsScreen.routeName);
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: popularFoods
                .map(
                  (food) => Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: FoodCard(
                      food: food,
                      onPress: () => Navigator.pushNamed(
                        context,
                        DetailsScreen.routeName,
                        arguments: FoodDetailsArguments(food: food),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

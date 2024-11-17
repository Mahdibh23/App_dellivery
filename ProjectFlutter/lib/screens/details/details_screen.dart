// views/details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';

import '../../models/Food.dart';
import '../../components/food_description.dart';
import '../../components/food_images.dart';
import '../../components/top_rounded_container.dart';
import '../../controller/CartController.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _selectedQuantity = 1;
  final CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    final FoodDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as FoodDetailsArguments;
    final food = args.food;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      food.rating
                          .toString(), // Convert rating to string correctly
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          FoodImages(food: food),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                FoodDescription(
                  food: food,
                  pressOnSeeMore: () {},
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Quantity:"),
                      const SizedBox(width: 10),
                      DropdownButton<int>(
                        value: _selectedQuantity,
                        items: List.generate(10, (index) => index + 1)
                            .map((quantity) => DropdownMenuItem(
                                  value: quantity,
                                  child: Text(quantity.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedQuantity = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              onPressed: () {
                for (int i = 0; i < _selectedQuantity; i++) {
                  cartController.addToCart(food);
                }
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}

class FoodDetailsArguments {
  final Food food;

  FoodDetailsArguments({required this.food});
}

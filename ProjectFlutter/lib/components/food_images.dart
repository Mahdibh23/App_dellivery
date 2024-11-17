import 'package:flutter/material.dart';
import '../models/Food.dart';

class FoodImages extends StatelessWidget {
  const FoodImages({
    Key? key,
    required this.food,
  }) : super(key: key);

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          height: 238,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset(
              food.image,
            ),
          ),
        ),
      ],
    );
  }
}

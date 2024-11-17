import 'Food.dart';

class Cart {
  final int id;
  final Food food;
  final double price;
  late int quantity;

  Cart({
    required this.id,
    required this.food,
    required this.price,
    required this.quantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      food: Food.fromJson(json['food']),
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food': food.toJson(),
      'price': price,
      'quantity': quantity,
    };
  }
}

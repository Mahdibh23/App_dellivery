import '../models/Cart.dart';

class ListCart {
  final int? id;
  final List<Cart> carts;
  final double totalPrice;

  ListCart({
    this.id,
    required this.carts,
    required this.totalPrice,
  });

  factory ListCart.fromJson(Map<String, dynamic> json) {
    return ListCart(
      id: json['id'],
      carts:
          (json['foods'] as List).map((item) => Cart.fromJson(item)).toList(),
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foods': carts.map((cart) => cart.toJson()).toList(),
      'total_price': totalPrice,
    };
  }
}

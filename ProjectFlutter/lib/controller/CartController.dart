import '../models/Cart.dart';
import '../models/Food.dart';

class CartController {
  static final CartController _instance = CartController._internal();
  factory CartController() => _instance;

  CartController._internal();

  static List<Cart> cartItems = [];

  void addToCart(Food food) {
    Cart? existingItem;
    try {
      existingItem = cartItems.firstWhere((item) => item.food.id == food.id);
    } catch (e) {
      existingItem = null;
    }

    if (existingItem != null) {
      existingItem.quantity += 1;
    } else {
      cartItems.add(Cart(
        id: cartItems.length + 1,
        food: food,
        price: food.price,
        quantity: 1,
      ));
    }
  }

  static clearCart() {
    cartItems.clear();
  }

  List<Cart> fetchCartItems() {
    return cartItems;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/cart_card.dart';
import 'package:shop_app/components/check_out_card.dart';
import '../../controller/CartController.dart';
import '../../models/Cart.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    List<Cart> cartItems = cartController.fetchCartItems().cast<Cart>();
    double totalPrice =
        cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('No items in the cart.'))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(cartItem.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          CartController.clearCart();
                        });
                      },
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            SvgPicture.asset("assets/icons/Trash.svg"),
                          ],
                        ),
                      ),
                      child: CartCard(cart: cartItem),
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: CheckoutCard(
        totalPrice: totalPrice,
        cartItems: cartItems,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/screens/init_screen.dart';
import '../controller/ListCartController.dart';
import '../controller/CartController.dart';
import '../models/ListCart.dart';
import '../models/Cart.dart';

class CheckoutCard extends StatelessWidget {
  final double totalPrice;
  final List<Cart> cartItems;

  const CheckoutCard({
    Key? key,
    required this.totalPrice,
    required this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Checkout",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Total: \$${totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool confirmed = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirm Checkout"),
                    content: const Text("Are you sure you want to checkout?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Confirm"),
                      ),
                    ],
                  ),
                );

                // ignore: unnecessary_null_comparison
                if (confirmed != null && confirmed) {
                  await ListCartController.saveListCart(ListCart(
                    carts: cartItems,
                    totalPrice: totalPrice,
                  ));

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Success"),
                      content: const Text(
                          "Your order has been placed successfully."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            CartController.clearCart();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    InitScreen.routeName,
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}

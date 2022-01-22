import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/widget/order_button.dart';
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              margin: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Chip(
                    label: Text('\$${cart.totalAmount}'),
                  ),
                   OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) {
              return CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].title,
                  cart.items.values.toList()[i].quantity);
            },
            itemCount: cart.items.length,
          ))
        ],
      ),
    );
  }
}

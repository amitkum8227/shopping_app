import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String? id;
  final String? title;
  final double? price;
  final int? quantity;

  CartItem(this.id, this.price, this.title, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$$price')),
          ),
          title: Text(title!),
          subtitle: Text('total: \$${price! * quantity!}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}

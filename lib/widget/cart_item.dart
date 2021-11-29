import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String? id;
  final String productId;
  final String? title;
  final double? price;
  final int? quantity;

  CartItem(this.id,this.productId, this.price, this.title, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white,size: 40,),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),

        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction){
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        },
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/product.dart';

import 'package:shopping_app/routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

/*  final String id;
  final String title;
  final String imageUrl;
  final double price;

  const ProductItem(this.id, this.imageUrl, this.title,this.price);*/

  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<Product>(context, listen: false);

    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(MyRoutes.productDetailRoute, arguments: prod.id);
          },
          child: GridTile(
            child: Image.network(
              prod.imageUrl,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Consumer<Product>(
                builder: (BuildContext context, prod, _) =>
                    IconButton(
                      icon: Icon(
                        prod.isFavourite ? Icons.favorite : Icons
                            .favorite_border,
                      ),
                      onPressed: () {
                        prod.toggleFavouriteStatus();
                      },
                    ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  cart.addItem(prod.id, prod.title, prod.price);
                  Scaffold.of(context).showSnackBar(
                       SnackBar(content: const Text('item added ',),
                      duration: const Duration(seconds: 2),
                        action: SnackBarAction(label: 'UNDO', onPressed: (){
                          cart.removeSingleItem(prod.id);
                        },),
                      ),
                  );
                },
              ),
              title: Text(
                prod.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            header: Text(prod.price.toString()),
          ),
        ));
  }
}

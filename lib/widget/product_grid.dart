import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/providers/products.dart';
import 'package:shopping_app/widget/product_item.dart';

class ProductGrid extends StatelessWidget {
  late final bool showfavs;

  ProductGrid(this.showfavs);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showfavs ? productData.favouriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
        /*  products[index].id,
            products[index].imageUrl,
            products[index].title,
            products[index].price),*/
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: products.length,
    );
  }
}

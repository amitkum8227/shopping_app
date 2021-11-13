import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/providers/products.dart';
import 'package:shopping_app/widget/product_item.dart';

class ProductGrid extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products=productData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) => ProductItem(
          products[index].id,
          products[index].imageUrl,
          products[index].title,
          products[index].price),
      itemCount: products.length,
    );
  }
}
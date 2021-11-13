import 'package:flutter/material.dart';
import 'package:shopping_app/providers/product.dart';
import 'package:shopping_app/widget/product_grid.dart';
import 'package:shopping_app/widget/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
      ),
      body:  ProductGrid(),
    );
  }
}



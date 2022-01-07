import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/routes.dart';
import 'package:shopping_app/widget/app_drawer.dart';
import '../providers/cart.dart';
import '../widget/badge.dart';


import '../widget/product_grid.dart';

enum filterOption {
  Favourite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavourite = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
        actions: [

                  PopupMenuButton(
                    onSelected: (filterOption selectedValue) {
                      setState(() {
                        if (selectedValue == filterOption.Favourite) {
                          _showOnlyFavourite = true;
                        } else {
                          _showOnlyFavourite = false;
                        }
                      });
                    },
                    itemBuilder: (_) {
                      return [
                        const PopupMenuItem(
                          child: Text(
                            "Favourites",
                          ),
                          value: filterOption.Favourite,
                        ),
                        const PopupMenuItem(
                          child: Text("All"),
                          value: filterOption.All,
                        ),
                      ];
                    },
                    icon: const Icon(Icons.more_vert),
                  ),




          Consumer<Cart>(
            builder: (_, cart, child) =>
              Badge(child: IconButton(
                icon: const Icon(Icons.shopping_cart), onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.cartSreenRoute);
              },),
                  value: cart.itemCount.toString(),
                  color: Colors.black),),
        ]
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showOnlyFavourite),
    );
  }
}

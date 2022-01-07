import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Screens/cart_screen.dart';
import '../Screens/edit_product_screen.dart';
import 'package:shopping_app/Screens/orders_screen.dart';
import 'package:shopping_app/Screens/product_detail_screen.dart';
import 'package:shopping_app/Screens/product_overview.dart';
import 'package:shopping_app/Screens/user_product_screen.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/orders.dart';
import 'package:shopping_app/providers/products.dart';
import 'package:shopping_app/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context)=> Products(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context)=>  Cart(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context)=>  Orders(),
        )

      ],
      child: MaterialApp(
        title: 'MyShop',
        theme:
            ThemeData(primarySwatch: Colors.blue, accentColor: Colors.orange),
        home: ProductOverviewScreen(),
        routes: {
          MyRoutes.productDetailRoute: (context) => const ProductDetailScreen(),
          MyRoutes.cartSreenRoute:(context)=> const CartScreen(),
          MyRoutes.OrderScreenRoute:(context)=>const OrdersScreen(),
          MyRoutes.userProductItemrouteName:(context)=>const UserProductsScreen(),
          MyRoutes.editScreenrouteName:(context)=> EditProductScreen(),

        },
      ),
    );
  }
}

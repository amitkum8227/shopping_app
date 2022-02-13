import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Screens/auth_screen.dart';
import 'package:shopping_app/Screens/cart_screen.dart';
import 'package:shopping_app/providers/auth.dart';

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
            create: (BuildContext context) =>
                Auth()
            ,
          ),

          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products('', [],''),
            update: (BuildContext context, auth, previousProduct,) =>
                Products(auth.token!,
                    previousProduct == null ? [] : previousProduct.items,auth.UserId!),


          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
           create: (_) => Orders('',[],''),
            update: (BuildContext context, auth, previousOrders,) =>
                Orders(auth.token!,
                    previousOrders == null ? [] : previousOrders.orders,auth.UserId!),


          ),

        ],

        child: Consumer<Auth>(builder: (BuildContext ctx, auth, _) =>
            MaterialApp(

              title: 'Window Shop',
              theme:
              ThemeData(primarySwatch: Colors.blue, accentColor: Colors.orange),

              home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
              routes: {
                MyRoutes.productDetailRoute: (
                    context) => const ProductDetailScreen(),
                MyRoutes.cartSreenRoute: (context) => const CartScreen(),
                MyRoutes.OrderScreenRoute: (context) => const OrdersScreen(),
                MyRoutes.userProductItemrouteName: (
                    context) => const UserProductsScreen(),
                MyRoutes.editScreenrouteName: (context) => EditProductScreen(),

              },
            )
          ,
        )
    );
  }
}

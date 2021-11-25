import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Screens/product_detail_screen.dart';
import 'package:shopping_app/Screens/product_overview.dart';
import 'package:shopping_app/providers/products.dart';
import 'package:shopping_app/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:
    [ChangeNotifierProvider.value(

        value:  Products(),),],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.orange
        ),
        home:   ProductOverviewScreen(),
        routes:{
          MyRoutes.productDetailRoute :(context)=>const ProductDetailScreen(),
        }
        ,
      ),
    );
  }
}



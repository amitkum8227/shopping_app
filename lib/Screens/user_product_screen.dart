import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/routes.dart';
import 'package:shopping_app/widget/app_drawer.dart';
import 'package:shopping_app/widget/user_product_item.dart';
import '../Screens/edit_product_screen.dart';

import '../providers/products.dart';
import '../widget/user_product_item.dart';
import '../widget/app_drawer.dart';



class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context)async{
    await Provider.of<Products>(context,listen: false).fetchAndSaveData(true );
  }



  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(onPressed:(){
            Navigator.of(context).pushNamed(MyRoutes.editScreenrouteName);
          }, icon:Icon( Icons.add))

        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx,snapshot)=> snapshot.connectionState==ConnectionState.waiting ? Center(child: CircularProgressIndicator(),) : RefreshIndicator(
          onRefresh: ()=> _refreshProducts(context),
          child: Consumer<Products>(builder: (ctx,productsData,_)=>
             Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(
                      productsData.items[i].id,
                      productsData.items[i].title,
                      productsData.items[i].imageUrl,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

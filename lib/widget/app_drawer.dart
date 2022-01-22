import 'package:flutter/material.dart';
import 'package:shopping_app/Screens/product_overview.dart';
import 'package:shopping_app/Screens/user_product_screen.dart';
import 'package:shopping_app/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: const Text("hello"),),
          Divider(),
          ListTile(leading: const Icon(Icons.shop),
          title: const Text('shop'),
            onTap: (){
            Navigator.of(context).pushReplacementNamed('/');

            },
          ),
          ListTile(leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(MyRoutes.OrderScreenRoute);

            },


          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(MyRoutes.userProductItemrouteName);
            },
          ),


        ],
      ),
    );
  }
}

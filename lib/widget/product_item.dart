import 'package:flutter/material.dart';
import 'package:shopping_app/routes.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  ProductItem(this.id, this.imageUrl, this.title,this.price);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(MyRoutes.productDetailRoute,arguments: id);
        },
        child: GridTile(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(icon: const Icon(Icons.favorite), onPressed: () {  },),
            trailing: IconButton(icon: const Icon(Icons.shopping_bag), onPressed: () {  },),

            title: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize:15   ),
            ),
          ),
          header: Text(price.toString()),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {required this.title,
      required this.description,
      required this.id,
      required this.imageUrl,
      this.isFavourite = false,
      required this.price, isFavorite});

 Future< void> toggleFavouriteStatus()async {
    final oldStatus=isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.parse(
        'https://shoppingapp-54bd1-default-rtdb.firebaseio.com/products/$id.json');
    try{
     final response= await http.patch(url,body: json.encode({
      'isFavourite': isFavourite
      }));
     if(response.statusCode>=400){
       isFavourite=oldStatus;
       notifyListeners();

     }
    }


    catch(error){
      isFavourite=oldStatus;
      notifyListeners();

    }


  }
}

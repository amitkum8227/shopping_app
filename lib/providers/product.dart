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
      required this.price, });

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

 Future< void> toggleFavouriteStatus( String? token,String?  userId)async {
    final oldStatus=isFavourite;
    isFavourite = !isFavourite;
    //print('hello');
    notifyListeners();
    final url = Uri.parse(
        'https://shoppingapp-54bd1-default-rtdb.firebaseio.com/userFav/$userId/$id.json?auth=$token');
    try{
     final response= await http.put(url,body: json.encode({
       '$id': isFavourite.toString(),

      })

     );
     notifyListeners();
     if(response.statusCode>=400){
       isFavourite=oldStatus;
       //_setFavValue(oldStatus);
       print('hello1');
       notifyListeners();


     }
    }


    catch(error){
      isFavourite=oldStatus;
      //_setFavValue(oldStatus);
      print(error);


    }
    //print('hello3');

  }
}

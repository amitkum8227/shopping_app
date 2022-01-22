import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/Model/httpException.dart';

import 'product.dart';

class Products extends ChangeNotifier {
   List<Product> _items = [
   /* Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),*/
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  Product FindById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  Future<void>fetchAndSaveData() async{
    final url = Uri.parse(
        'https://shoppingapp-54bd1-default-rtdb.firebaseio.com/products.json');
    final response= await http.get(url);
    final extractedData=json.decode(response.body) as Map<String,dynamic>;
    final List<Product>_loadedProduct=[];
    extractedData.forEach((prodId, prodData) {
      _loadedProduct.add(Product(
        id: prodId,
        title: prodData['title'],
        description: prodData['description'],
        price: prodData['price'],
        isFavourite: prodData['isFavourite'],
        imageUrl: prodData['imageUrl'],
        
      ));


    });
    _items=_loadedProduct;
    notifyListeners();

  }

  Future<void> addProduct(Product product) async{
    try {
      final url = Uri.parse(
          'https://shoppingapp-54bd1-default-rtdb.firebaseio.com/products.json');
      final response = await http
          .post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavourite': product.isFavourite,
        }),
      );

    final newProduct = Product(
    title: product.title,
    description: product.description,
    price: product.price,
    imageUrl: product.imageUrl,
    id: jsonDecode(response.body)['name'],
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list

    notifyListeners();
    } catch(error){
    print(error);
      throw error;

    }



    


  }

 Future< void> updateProduct(String id, Product newProduct) async{
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://shoppingapp-54bd1-default-rtdb.firebaseio.com/products/$id.json');
      http.patch(url,body: json.encode({
        'title':newProduct.title,
        'description':newProduct.description,
        'imageUrl':newProduct.imageUrl,
        'price':newProduct.price,
      })

      );
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async{
    final url = Uri.parse(
        'https://shoppingapp-54bd1-default-rtdb.firebaseio.com/products/$id.json');
    final existingProductIndex=_items.indexWhere((prod) => prod.id == id);
    Product?  existingProduct=_items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    //  _items.removeWhere((prod) => prod.id == id);//
    notifyListeners();


   final response= await http.delete(url);
      if(response.statusCode>=400){
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException('deleting failed');
      }
       existingProduct=null;




  }
}


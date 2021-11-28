import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quanity;

  CartItem(
      {required this.id,
      required this.price,
      required this.title,
      required this.quanity});
}

class Cart with ChangeNotifier {
  late final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }
  double get totalAmount{
    var total=0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quanity;


    });
    return total;
  }

  void addItem(String productId,
      String title,
      double price,) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
              (existingCartItem) =>
              CartItem(
                  id: existingCartItem.id,
                  price: price,
                  title: title,
                  quanity: existingCartItem.quanity + 1));
    } else {
      _items.putIfAbsent(
          productId,
              () =>
              CartItem(
                  id: DateTime.now().toString(),
                  price: price,
                  title: title,
                  quanity: 1));
    }
    notifyListeners();
  }


}

import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({required this.id,
    required this.price,
    required this.title,
    required this.quantity});
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
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
                  quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
              () =>
              CartItem(
                  id: DateTime.now().toString(),
                  price: price,
                  title: title,
                  quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (_items[productId]!.quantity > 1) {
      _items.update(productId, (existCartItem) =>
          CartItem(id: existCartItem.id,
              price: existCartItem.price,
              title: existCartItem.title,
              quantity: existCartItem.quantity-1));
    }
    else{
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }


}

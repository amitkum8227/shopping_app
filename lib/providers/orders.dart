import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.products,
      required this.amount,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }
  final String authToken;

  Orders (this.authToken,this._orders);

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://shoppingapp-54bd1-default-rtdb.firebaseio.com/Orders.json?auth=$authToken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    if(extractedData==null){
      return;
    }
    extractedData.forEach((orderId, orderDta) {
      loadedOrders.add(OrderItem(
          id: orderId,
          products: (orderDta['products'] as List<dynamic>).map((item) =>
              CartItem(id: item['id'], price: item['price'], title: item['title'], quantity: item['quantity'])).toList(),
          amount: orderDta['amount'],
          dateTime: DateTime.parse(orderDta['dateTime'])));
    });
    _orders=loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shoppingapp-54bd1-default-rtdb.firebaseio.com/Orders.json?auth=$authToken');
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
            id: jsonDecode(response.body)['name'],
            products: cartProducts,
            amount: total,
            dateTime: timeStamp));
    notifyListeners();
  }



}
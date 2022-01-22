import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/orders.dart';

class OrderButton extends StatefulWidget {
  final Cart cart;
  const OrderButton({Key? key, required this.cart}) : super(key: key);

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return  FlatButton(

        onPressed:( widget.cart.totalAmount<= 0 || _isLoading) ? null:() async{
          setState(() {
            _isLoading=true;
          });
          await Provider.of<Orders>(context,listen: false).addOrder(
              widget.cart.items.values.toList(), widget.cart.totalAmount);
          setState(() {
            _isLoading=false;
          });
          widget.cart.clear();
        },
        child: _isLoading ? const CircularProgressIndicator(): const Text('ORDER NOW '));
  }
}

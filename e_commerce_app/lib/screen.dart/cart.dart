import 'package:e_commerce_app/widget/cart_widget.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "My Cart",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: const CartWidget(),
    );
  }
}

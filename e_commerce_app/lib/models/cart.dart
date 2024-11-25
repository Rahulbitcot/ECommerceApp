import 'package:flutter/material.dart';

class CartItem {
  const CartItem({
    required this.title,
    required this.imgUrl,
    required this.price,
    required this.color,
  });

  final String title;
  final String imgUrl;
  final String price;
  final Color color;
}

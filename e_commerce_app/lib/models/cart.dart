import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String imgUrl;
  final String price;
  final Color color;

  CartItem(
      {required this.title,
      required this.imgUrl,
      required this.price,
      required this.color});

  // Convert CartItem to Map for JSON encoding
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imgUrl': imgUrl,
      'price': price,
      'color': color.value, // Storing the color as an integer
    };
  }

  // Convert JSON to CartItem
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      title: json['title'],
      imgUrl: json['imgUrl'],
      price: json['price'],
      color: Color(json['color']),
    );
  }
}

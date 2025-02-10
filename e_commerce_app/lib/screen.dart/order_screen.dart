import 'dart:convert';

import 'package:e_commerce_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<CartItem> cardItem = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItemList = prefs.getStringList("CartItemList");
    List<String>? cartItem = cartItemList;

    if (cartItem != null) {
      setState(() {
        cardItem = cartItem
            .map((jsonStr) => CartItem.fromJson(jsonDecode(jsonStr)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Order"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cardItem.length,
              itemBuilder: (context, index) => cardListView(
                index,
                cardItem[index].title,
                cardItem[index].imgUrl,
                cardItem[index].price.toString(),
                cardItem[index].color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget cardListView(
    int index, String title, String imgUrl, String price, Color bgColor) {
  return Card(
    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 5 , right: 5),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin: const EdgeInsets.all(10),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(imgUrl),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                const Text(
                  "Size: M",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "INR: $price",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Track Order"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

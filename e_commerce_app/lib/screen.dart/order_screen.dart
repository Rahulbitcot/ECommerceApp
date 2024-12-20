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
    child: Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 80,
            height: 80,
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
                  fontSize: 20,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              const Text(
                "Size: M",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "INR: $price",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Track Order"),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    ),
  );
}

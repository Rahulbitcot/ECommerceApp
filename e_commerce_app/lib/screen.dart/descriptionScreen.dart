import 'dart:convert';

import 'package:e_commerce_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Descriptionscreen extends StatefulWidget {
  const Descriptionscreen({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imgUrl,
  });

  final String title;
  final String description;
  final String price;
  final String imgUrl;

  @override
  State<Descriptionscreen> createState() => _DescriptionscreenState();
}

class _DescriptionscreenState extends State<Descriptionscreen> {
  String btnText = "Add to cart";
  @override
  Widget build(BuildContext context) {
    void _sharedPref() async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      List<String> cartItemList = pref.getStringList("CartItemList") ?? [];
      CartItem newItem = CartItem(
        title: widget.title,
        imgUrl: widget.imgUrl,
        price: widget.price,
        color: const Color.fromARGB(196, 122, 122, 122),
      );

      cartItemList.add(jsonEncode(newItem.toJson()));

      pref.setStringList("CartItemList", cartItemList);

      setState(() {
        if (btnText == "Add to cart") {
          btnText = "Remove from cart";
        } else {
          btnText = "Add to Cart";
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Description"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      widget.imgUrl,
                      height: 300,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "INR: ${widget.price}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "About",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                        Text(
                          "Available in Stock",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.description),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.amber),
                  fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                ),
                onPressed: _sharedPref,
                child: Text(
                  btnText,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/Data/cart_list.dart';
import 'package:e_commerce_app/models/cart.dart';
import 'package:flutter/material.dart';

class Descriptionscreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
                      imgUrl,
                      height: 300,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "INR: $price",
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
                    Text(description),
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
                onPressed: () {
                  cardItem.add(CartItem(
                    title: title,
                    imgUrl: imgUrl,
                    price: price,
                    color: const Color.fromARGB(196, 122, 122, 122),
                  ));
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.black, fontSize: 20),
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

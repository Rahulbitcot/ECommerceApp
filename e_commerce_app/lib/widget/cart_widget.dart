import 'package:e_commerce_app/Data/cart_list.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cardItem.length,
            itemBuilder: (context, index) => cardListView(
                cardItem[index].title,
                cardItem[index].imgUrl,
                cardItem[index].price,
                cardItem[index].color),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 130,
          child: Container(
            padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total :",
                      style: TextStyle(
                          color: Color.fromARGB(255, 72, 71, 71),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "INR: 452",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.orange),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                        color: Color.fromARGB(255, 34, 34, 34), fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget cardListView(String title, String imgUrl, String price, Color bgColor) {
  return Card(
    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
    color: const Color.fromARGB(83, 255, 255, 255),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          margin: const EdgeInsets.all(20),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              imgUrl,
            ),
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
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "INR: $price",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
        ),
        const Expanded(
            child: Column(
          children: [
            Text(
              "Size: M",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ))
      ],
    ),
  );
}

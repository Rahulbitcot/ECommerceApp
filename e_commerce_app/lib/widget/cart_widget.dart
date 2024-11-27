import 'package:e_commerce_app/Data/cart_list.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  void _removeItem(int index) {
    setState(() {
      cardItem.removeAt(index);
    });
  }

  double _calculateTotal() {
    double total = 0;
    for (var i in cardItem) {
      total = total + double.parse(i.price);
    }
    return total.roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cardItem.length,
            itemBuilder: (context, index) => cardListView(
                index,
                cardItem[index].title,
                cardItem[index].imgUrl,
                cardItem[index].price,
                cardItem[index].color),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 150,
          child: Container(
            padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total :",
                      style: TextStyle(
                          color: Color.fromARGB(255, 72, 71, 71),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "INR: ${_calculateTotal()}",
                      style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.amber),
                        fixedSize:
                            WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget cardListView(
      int index, String title, String imgUrl, String price, Color bgColor) {
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
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
          Expanded(
              child: Column(
            children: [
              IconButton(
                onPressed: () {
                  _removeItem(index);
                },
                icon: const Icon(Icons.delete),
              ),
              const Text(
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
}

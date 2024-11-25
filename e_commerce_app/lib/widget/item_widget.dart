import 'package:e_commerce_app/Data/item_list.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (ctx, item) => cardView(itemList[item].title,
          itemList[item].imgUrl, itemList[item].price, itemList[item].discount),
      itemCount: itemList.length,
    );
  }
}

Widget cardView(String title, String imgUrl, String price, String discount) {
  return Card(
    color: const Color.fromARGB(255, 226, 225, 223),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  discount,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            imgUrl,
            height: 100,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "INR $price",
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
  );
}

import 'package:e_commerce_app/Data/item_list.dart';
import 'package:e_commerce_app/models/cart.dart';
import 'package:e_commerce_app/screen.dart/descriptionScreen.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  List<CartItem> cardItem = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (ctx, item) => cardView(
            itemList[item].title,
            itemList[item].imgUrl,
            itemList[item].price,
            itemList[item].discount,
            itemList[item].description),
        itemCount: itemList.length,
      ),
    );
  }

  Widget cardView(String title, String imgUrl, String price, String discount,
      String description) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Descriptionscreen(
                  title: title,
                  description: description,
                  price: price,
                  imgUrl: imgUrl)),
        ),
      },
      child: Card(
        color: const Color.fromARGB(255, 226, 225, 223),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                discount,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: Image.network(imgUrl),
              ),
              const SizedBox(height: 3),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 3),
              Text("INR $price", style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}

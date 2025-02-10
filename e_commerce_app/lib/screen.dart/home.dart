import 'dart:convert';

import 'package:e_commerce_app/Data/item_list.dart';
import 'package:e_commerce_app/models/items.dart';
import 'package:e_commerce_app/screen.dart/account.dart';
import 'package:e_commerce_app/screen.dart/auth.dart';
import 'package:e_commerce_app/screen.dart/cart.dart';
import 'package:e_commerce_app/screen.dart/descriptionScreen.dart';
import 'package:e_commerce_app/widget/drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

final firebase = FirebaseAuth.instance;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      getProduct();
    });
  }

  Future<List<Items>> getProduct() async {
    const baseUrl = "https://fakestoreapi.com/products";
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> productJson = json.decode(response.body);
        List<Items> productList =
            productJson.map((item) => Items.fromJson(item)).toList();
        setState(() {
          itemList = productList;
          _isloading = false;
        });
        return productList;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed to load products, please try again later ")));
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<void> _onLogoutClearCart() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList("CartItemList", []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Shop here ")),
        actions: [
          logoutWidget(),
        ],
      ),
      drawer: const DrawerWidget(),
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Hello Fola",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.card_giftcard, color: Colors.orange, size: 36),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text("Let's Start Shopping", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  trendingProduct(),
                  const SizedBox(height: 10),
                  topProductListView(),
                ],
              ),
            ),
          ),
        ];
      },
      body: itemWidget(),
    );
  }

  Widget logoutWidget() {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure you want to logout?"),
            content: const Text(
              "If you logout, items added to the cart will disappear.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  firebase.signOut();
                  _onLogoutClearCart();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Auth()));
                },
                child: const Text("Yes"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget topProductListView() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Top Products",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "See All",
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  Widget trendingProduct() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          cardView("20% off During The \nWeekend", "assets/images/image.png",
              Colors.orange),
          const SizedBox(width: 10),
          cardView("80% off On Smart \nWatch", "assets/images/watch.png",
              Colors.blue),
        ],
      ),
    );
  }

  Widget cardView(String heading, String imgUrl, Color cardColor) {
    return Card(
      color: cardColor,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Get Now"),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      imgUrl,
                      height: 100,
                      alignment: Alignment.bottomLeft,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemWidget() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (ctx, item) => itemView(
          itemList[item].title,
          itemList[item].imgUrl,
          itemList[item].price,
          itemList[item].discount,
          itemList[item].description),
      itemCount: itemList.length,
    );
  }

  Widget itemView(String title, String imgUrl, String price, String discount,
      String description) {
    return Skeletonizer(
      enabled: _isloading,
      child: GestureDetector(
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
          color: Colors.white,
          elevation: 10,
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
      ),
    );
  }
}

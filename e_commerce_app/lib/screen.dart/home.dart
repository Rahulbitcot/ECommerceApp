import 'dart:convert';

import 'package:e_commerce_app/Data/item_list.dart';
import 'package:e_commerce_app/models/items.dart';
import 'package:e_commerce_app/screen.dart/account.dart';
import 'package:e_commerce_app/screen.dart/bank_information.dart';
import 'package:e_commerce_app/screen.dart/cart.dart';
import 'package:e_commerce_app/screen.dart/personal_informatio.dart';
import 'package:e_commerce_app/screen.dart/setting.dart';
import 'package:e_commerce_app/screen.dart/your_order.dart';
import 'package:e_commerce_app/widget/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedPage = 0;

  void onSelect(int currentIndex) {
    setState(() {
      _selectedPage = currentIndex;
    });

    if (_selectedPage == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else if (_selectedPage == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Cart(),
        ),
      );
    } else if (_selectedPage == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Account(),
        ),
      );
    }
  }

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
        });

        return productList;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: onSelect,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
      appBar: AppBar(
        title: const Center(child: Text("Watch app")),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 240, 240, 239),
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 10, left: 15, right: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(68, 253, 206, 0),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: Image.asset("assets/images/sleep.png")),
                    const SizedBox(height: 10),
                    const Text(
                      "John Deo",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "rahulmukati@bitcot.com",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PersonalInformation()));
              },
              iconColor: Colors.black,
              splashColor: const Color.fromARGB(68, 253, 206, 0),
              leading: const Icon(Icons.person),
              title: const Text("Personal Information"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BankInformation()));
              },
              iconColor: Colors.black,
              splashColor: const Color.fromARGB(68, 253, 206, 0),
              leading: const Icon(Icons.monetization_on),
              title: const Text("Bank Information"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const YourOrder()));
              },
              iconColor: Colors.black,
              splashColor: const Color.fromARGB(68, 253, 206, 0),
              leading: const Icon(Icons.shop),
              title: const Text("your Order"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Setting()));
              },
              iconColor: Colors.black,
              splashColor: const Color.fromARGB(68, 253, 206, 0),
              leading: const Icon(Icons.settings),
              title: const Text("Setting"),
            ),
            ListTile(
              onTap: () {},
              iconColor: Colors.black,
              splashColor: const Color.fromARGB(68, 253, 206, 0),
              leading: const Icon(Icons.info),
              title: const Text("About"),
            ),
            const Spacer(),
            const Text("Version 1.0"),
            const SizedBox(height: 10)
          ],
        ),
      ),
      body: Padding(
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
                      fontSize: 30),
                ),
                SizedBox(width: 10),
                Icon(Icons.card_giftcard, color: Colors.orange, size: 36),
              ],
            ),
            const SizedBox(height: 5),
            const Text("Let's Start Shopping", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  cardView("20% off During The \nWeekend",
                      "assets/images/image.png", Colors.orange),
                  const SizedBox(
                    width: 10,
                  ),
                  cardView("80% off On Smart \nWatch",
                      "assets/images/watch.png", Colors.blue),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Products",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25),
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
            ),
            const Expanded(
              child: ItemWidget(),
            ),
          ],
        ),
      ),
    );
  }
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
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Get Now"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    imgUrl,
                    height: 100,
                    alignment: Alignment.bottomLeft,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

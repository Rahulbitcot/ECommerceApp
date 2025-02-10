import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screen.dart/order_screen.dart';
import 'package:e_commerce_app/screen.dart/personal_information.dart';
import 'package:e_commerce_app/screen.dart/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../screen.dart/add_credit_card.dart';

final firebase = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  var name = "Set Your Name";
  var email = "Set Your Email";
  bool _isLoading = true;

  void setUserInfo() async {
    User? user = firebase.currentUser;

    if (user != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        setState(() {
          name = snapshot['name'] ?? "Set your name";
          email = snapshot['email'] ?? "Set your name";
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User data not found")));
        _isLoading = false;
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User not logged in")));
      _isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    setUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 240, 240, 239),
      child: Column(
        children: <Widget>[
          widgetHeader(),
          const SizedBox(height: 10),
          listTilePersonalInformation(),
          listTileCreditCard(),
          listTileYourOrder(),
          listTileSetting(),
          listTileAbout(),
          const Spacer(),
          const Padding(
              padding: EdgeInsets.all(10.0), // Adjust padding as needed
              child: Text("Version 1.0")),
        ],
      ),
    );
  }

  Widget listTilePersonalInformation() {
    return ListTile(
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
    );
  }

  Widget listTileCreditCard() {
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreditCardFormPage()));
      },
      iconColor: Colors.black,
      splashColor: const Color.fromARGB(68, 253, 206, 0),
      leading: const Icon(Icons.credit_card),
      title: const Text("Credit Card Info"),
    );
  }

  Widget listTileYourOrder() {
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OrderScreen()));
      },
      iconColor: Colors.black,
      splashColor: const Color.fromARGB(68, 253, 206, 0),
      leading: const Icon(Icons.shop),
      title: const Text("your Order"),
    );
  }

  Widget listTileSetting() {
    return ListTile(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Setting()));
      },
      iconColor: Colors.black,
      splashColor: const Color.fromARGB(68, 253, 206, 0),
      leading: const Icon(Icons.settings),
      title: const Text("Setting"),
    );
  }

  Widget listTileAbout() {
    return ListTile(
      onTap: () {},
      iconColor: Colors.black,
      splashColor: const Color.fromARGB(68, 253, 206, 0),
      leading: const Icon(Icons.info),
      title: const Text("About"),
    );
  }

  Widget widgetHeader() {
    return Skeletonizer(
      enabled: _isLoading,
      child: DrawerHeader(
        child: Container(
          padding:
              const EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 10),
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
              Text(
                name,
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                email,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

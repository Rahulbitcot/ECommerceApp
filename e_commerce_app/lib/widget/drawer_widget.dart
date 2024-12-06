import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screen.dart/bank_information.dart';
import 'package:e_commerce_app/screen.dart/personal_information.dart';
import 'package:e_commerce_app/screen.dart/setting.dart';
import 'package:e_commerce_app/screen.dart/your_order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firebase = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  var name = "unknown";
  var email = "Not Available";

  void setUserInfo() async {
    User? user = firebase.currentUser;

    if (user != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        setState(() {
          name = snapshot['name'] ?? "Set your name";
          email = snapshot['email'] ?? "Set your email";
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User data not found")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User not logged in")));
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
    );
  }
}

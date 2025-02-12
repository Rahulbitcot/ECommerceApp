import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'personal_information.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  File? _imageFile;
  bool isLoading = true;

  String name = "Not available";
  String email = "Not available";
  String number = "Not available";
  String address = "Not available";
  String cardNumber = "Not available";
  String expiryDate = "Not available";
  String cvvCode = "Not available";
  String cardHolderName = "Not available";

  final firebase = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void setUserInfo() async {
    User? user = firebase.currentUser;

    if (user != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        setState(() {
          name = snapshot['name'] ?? "Set your name";
          email = snapshot['email'] ?? "Set your email";
          number = snapshot['phone'] ?? "Set your number";
          address = snapshot['address'] ?? "Set your address";
          cardNumber = snapshot['cardNumber'];
          expiryDate = snapshot['expiryDate'];
          cvvCode = snapshot['cvvCode'];
          cardHolderName = snapshot['cardHolderName'];
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User data not found")));
        isLoading = false;
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User not logged in")));
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      setUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account Information")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Skeletonizer(
          enabled: isLoading,
          child: Card(
            color: const Color(0xFF82BFF5),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _imageFile == null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(_imageFile!),
                        ),
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.edit),
                  ),
                  const SizedBox(height: 20),
                  widgetUserInformationListTiles(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetEditInformationButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PersonalInformation(),
          ),
        );
      },
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.amber),
        fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 30)),
      ),
      child: const Text(
        "Edit Information",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Widget widgetUserInformationListTiles() {
    return Expanded(
      child: ListView(
        children: [
          Card(
            elevation: 10,
            child: ListTile(
              title: const Text("Name"),
              leading: const Icon(Icons.people),
              subtitle: Text(name),
            ),
          ),
          const Divider(),
          Card(
            elevation: 10,
            child: ListTile(
              title: const Text("Email"),
              leading: const Icon(Icons.email),
              subtitle: Text(email),
            ),
          ),
          const Divider(),
          Card(
            elevation: 10,
            child: ListTile(
              title: const Text("Number"),
              leading: const Icon(Icons.phone),
              subtitle: Text(number),
            ),
          ),
          const Divider(),
          Card(
            elevation: 10,
            child: ListTile(
              title: const Text("Address"),
              leading: const Icon(Icons.house),
              subtitle: Text(address),
            ),
          ),
          const Divider(),
          Card(
            elevation: 10,
            child: ListTile(
              title: const Text("Card Holder Name"),
              leading: const Icon(Icons.people_alt),
              subtitle: Text(cardHolderName),
            ),
          ),
          const Divider(),
          Card(
            elevation: 10,
            child: ListTile(
              title: const Text("Credit Card Info"),
              leading: const Icon(Icons.credit_card),
              subtitle: Text(cardNumber),
            ),
          ),
          const SizedBox(height: 20),
          widgetEditInformationButton(),
        ],
      ),
    );
  }
}

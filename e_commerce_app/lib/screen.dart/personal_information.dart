import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

final firebase = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String name = "NA";
  String email = "NA";
  String number = "NA";
  String address = "NA";
  bool isLoading = true;

  final _formKey = GlobalKey<FormState>();

  void saveUserInfo() {
    if (_formKey.currentState?.validate() ?? false) {
      saveUserInfoInFirebase();
      setUserInfo();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Profile Updated")));
      }
      FocusScope.of(context).unfocus();
    }
  }

  void saveUserInfoInFirebase() async {
    User? user = firebase.currentUser;

    if (user != null) {
      DocumentReference userRef = firestore.collection('users').doc(user.uid);

      userRef.set({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _numberController.text,
        'address': _addressController.text,
        'uid': user.uid,
      }, SetOptions(merge: true));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
    }
  }

  void setUserInfo() async {
    try {
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

            _nameController.text = name;
            _emailController.text = email;
            _numberController.text = number;
            _addressController.text = address;
            isLoading = false;
          });
        } else {
          throw Exception("User data not found");
        }
      } else {
        throw Exception("User not logged in");
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      setState(() {
        isLoading = false; // Set loading to false on error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Information"),
      ),
      body: SingleChildScrollView(
        child: Skeletonizer(
          enabled: isLoading,
          child: Column(
            children: [
              Card(
                elevation: 30,
                shadowColor: Colors.amber,
                margin: const EdgeInsets.only(top: 40, left: 20,right: 20,bottom: 50),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        widgetTextFormName(),
                        const SizedBox(height: 30),
                        widgetTextFormNumber(),
                        const SizedBox(height: 30),
                        widgetTextFormEmail(),
                        const SizedBox(height: 30),
                        widgetTextFormAddress(),
                      ],
                    ),
                  ),
                ),
              ),
              widgetSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetSaveButton() {
    return ElevatedButton(
      onPressed: saveUserInfo,
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.amber),
        fixedSize: WidgetStatePropertyAll(Size(250, 30)),
      ),
      child: const Text(
        "Save profile information",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Widget widgetTextFormName() {
    return TextFormField(
      controller: _nameController..text = name,
      decoration: const InputDecoration(label: Text("Name")),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Name cannot be empty";
        }

        if (value.length < 2) {
          return "Enter Valid Name";
        }

        return null;
      },
    );
  }

  Widget widgetTextFormNumber() => TextFormField(
        controller: _numberController..text = number,
        decoration: const InputDecoration(label: Text("Number")),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Phone number cannot be empty";
          }
          if (value.length != 10) {
            return "Phone number must be of 10 digits";
          }
          final regex = RegExp(r'[a-zA-Z]');
          if (regex.hasMatch(value)) {
            return "Enter a valid number (no letters allowed)";
          }
          return null;
        },
      );

  Widget widgetTextFormEmail() => TextFormField(
        controller: _emailController..text = email,
        decoration: const InputDecoration(label: Text("Email")),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Email cannot be empty";
          }
          if (!value.contains('@')) {
            return "Enter Valid Email";
          }
          if (value.length < 5) {
            return "Enter Valid Email";
          }

          return null;
        },
      );

  Widget widgetTextFormAddress() => TextFormField(
        controller: _addressController..text = address,
        decoration: const InputDecoration(label: Text("Address")),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Address cannot be empty";
          }

          if (value.length < 5) {
            return "Enter Valid Address";
          }
          return null;
        },
      );
}

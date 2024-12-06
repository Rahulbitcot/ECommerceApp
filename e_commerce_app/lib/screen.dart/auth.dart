import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/widget/profile_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firebase = FirebaseAuth.instance;

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = "";
  var _enteredPassword = "";
  var _enteredUsername = "";

  File? _selectedImage;

  void _submitForm() async {
    final valid = _form.currentState!.validate();

    if (!valid || !_isLogin && _selectedImage == null) {
      return;
    }

    _form.currentState!.save();
    try {
      if (_isLogin) {
        var userCred = await firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        print(userCred);
      } else {
        var userCred = await firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        // final storageRef = await FirebaseStorage.instance
        //     .ref()
        //     .child("user_image")
        //     .child("${userCred.user!.uid}.jpg");

        // await storageRef.putFile(_selectedImage!);
        // final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCred.user!.uid)
            .set({
          "user_name": _enteredUsername,
          "user_email": _enteredEmail,
          // "user_image": imageUrl
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(" Error : ${error.message}"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Image.asset(
                  "assets/images/image.png",
                  scale: 2,
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLogin)
                          ProfileImagePicker(
                            onPickedImage: (pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
                        if (!_isLogin)
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text("UserName"),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().length < 4) {
                                return "Please enter valid email";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredUsername = newValue!;
                            },
                          ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Enter Email"),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains("@")) {
                              return "Please enter valid email";
                            }
                            return null;
                          },
                          onSaved: (newValue) => {_enteredEmail = newValue!},
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Enter Password"),
                          ),
                          onSaved: (newValue) => {_enteredPassword = newValue!},
                          obscureText: true,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return "Password must be 6 character long";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          child: Text(_isLogin ? "login" : "SignUp"),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? "Create new account"
                              : "Already have account ..login"),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

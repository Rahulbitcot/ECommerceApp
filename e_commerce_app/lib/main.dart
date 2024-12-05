import 'package:e_commerce_app/screen.dart/auth.dart';
import 'package:e_commerce_app/screen.dart/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshots) {
          // if (snapshots.connectionState == ConnectionState.waiting) {
          //   return null
          // }
          if (snapshots.hasData) {
            return const Home();
          }
          return const Auth();
        },
      ),
    );
  }
}

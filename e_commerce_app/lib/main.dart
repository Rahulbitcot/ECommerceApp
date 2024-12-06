import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/screen.dart/auth.dart';
import 'package:e_commerce_app/screen.dart/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Check if Firebase is already initialized
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("Firebase initialized successfully");
    } else {
      print("Firebase already initialized");
    }
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

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

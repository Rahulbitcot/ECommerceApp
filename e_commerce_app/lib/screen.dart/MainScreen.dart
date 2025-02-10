import 'package:flutter/material.dart';

import 'account.dart';
import 'cart.dart';
import 'home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedPage = 0;

  Widget _currentPage = const Home();

  void onSelect(int currentIndex) {
    setState(() {
      _selectedPage = currentIndex;
    });
    if (_selectedPage == 0) {
      _currentPage = const Home();
    } else if (_selectedPage == 1) {
      _currentPage = const Cart();
    } else if (_selectedPage == 2) {
      _currentPage = const Account();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _currentPage, bottomNavigationBar: bottomView());
  }

  Widget bottomView() {
    return BottomNavigationBar(
      currentIndex: _selectedPage,
      onTap: onSelect,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
      ],
    );
  }
}

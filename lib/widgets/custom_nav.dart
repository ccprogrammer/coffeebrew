import 'package:coffee_shop/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../themes/themes.dart';

class CustomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _currentIndex = 0;
    final screens = [
      HomePage(),
    ];

    return SizedBox(
      child: BottomNavigationBar(
        backgroundColor: bgNavColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: primaryColor.withOpacity(0.4),
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'asd',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'asd',
          ),
        ],
      ),
    );
  }
}

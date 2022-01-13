import 'package:coffee_shop/controllers/cart_controller.dart';
import 'package:coffee_shop/pages/cart_page.dart';
import 'package:coffee_shop/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/themes.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartC = Get.put(CartController());

    final currentIndex = cartC.currentIndex;

    final screens = [
      HomePage(),
      CartPage(),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            currentIndex.value = index;
          },
          currentIndex: currentIndex.value,
          backgroundColor: bgNavColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: primaryColor,
          unselectedItemColor: primaryColor.withOpacity(0.4),
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 50,
                height: 40,
                child: Icon(
                  Icons.coffee,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: (cartC.jumlahCart == 0)
                  ? Icon(Icons.add_shopping_cart)
                  : Stack(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 40,
                          child: Icon(Icons.shopping_cart),
                        ),
                        Positioned(
                          top: -3,
                          right: 6,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent),
                            child: Center(
                              child: Text(
                                '${cartC.jumlahCart}',
                                style: openSans.copyWith(
                                  color: (cartC.currentIndex == 1)
                                      ? primaryColor
                                      : primaryColor.withOpacity(0.6),
                                  fontWeight: semibold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              label: 'Cart',
            ),
          ],
        ),
      ),
      body: Obx(
        () => screens[currentIndex.value],
      ),
    );
  }
}

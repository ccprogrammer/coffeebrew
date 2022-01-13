import 'dart:io';
import 'package:coffee_shop/controllers/cart_controller.dart';
import 'package:coffee_shop/controllers/coffee_controller.dart';
import 'package:coffee_shop/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coffeeC = Get.find<CoffeeController>();
    final cartC = Get.find<CartController>();

    var coffeeId = Get.arguments as String;
    final selectCoffee = coffeeC.selectedById(coffeeId);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey,
                image: (selectCoffee.imageUrl == '')
                    ? DecorationImage(
                        image: AssetImage('assets/image_photo.png'),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: FileImage(
                          File(selectCoffee.imageUrl),
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Positioned(
              top: 24,
              left: 10,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget detail() {
      return Container(
        margin: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Coffee Type
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectCoffee.coffee,
                    style: rosarivo.copyWith(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Color(0xffC94C4C),
                    size: 35,
                  ),
                ],
              ),
            ),
            //  Name
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Text(
                    selectCoffee.name,
                    style: rosarivo.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(0xffD3A601),
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        selectCoffee.score.toString(),
                        style: rosarivo.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Description
            Container(
              margin: EdgeInsets.only(
                top: 8,
              ),
              child: Text(
                selectCoffee.description,
                style: openSans.copyWith(
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
          ],
        ),
      );
    }

    Widget price() {
      return Container(
        margin: EdgeInsets.all(16),
        child: Row(
          children: [
            // Price
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: openSans.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 9),
                  Text(
                    '\$${selectCoffee.price}',
                    style: openSans.copyWith(
                      color: Colors.white,
                      fontWeight: semibold,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 30),
            // Button
            Expanded(
              child: Container(
                height: 45,
                child: TextButton(
                  onPressed: () {
                    cartC.addCart(selectCoffee.imageUrl, selectCoffee.coffee,
                        selectCoffee.name, selectCoffee.price, 1);
                    coffeeC.snackBar(
                      'SUCCESS',
                      'Item added to cart',
                      bgColor,
                      bgColor,
                      primaryColor,
                    );
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    'BUY NOW',
                    style: openSans.copyWith(
                      color: bgColor,
                      fontSize: 16,
                      fontWeight: semibold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            detail(),
            Spacer(),
            price(),
          ],
        ),
      ),
    );
  }
}

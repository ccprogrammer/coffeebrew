import 'package:coffee_shop/controllers/cart_controller.dart';
import 'package:coffee_shop/themes/themes.dart';
import 'package:coffee_shop/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartC = Get.put(CartController());

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Center(
          child: Text(
            'Cart',
            style: rosarivo.copyWith(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    Widget cart() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.42,
        child: Obx(
          () => ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: cartC.jumlahCart,
            itemBuilder: (context, index) {
              return CartTile(index);
            },
          ),
        ),
      );
    }

    Widget emptyCart(){
      return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 50,
            color: primaryColor,
          ),
          SizedBox(height: 30),
          Text(
            'Empty Cart',
            style: rosarivo.copyWith(
              color: primaryColor,
              fontSize: 24,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
    }

    Widget totalPrice() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
        ),
        child: Column(
          children: [
            Divider(
              thickness: 2,
              color: Colors.white24,
            ),

            // Price
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Price Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Charges',
                        style: rosarivo.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Coffee Price',
                        style: rosarivo.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                            '\$ ${cartC.deliveryCharges.value.toStringAsFixed(1)}',
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontWeight: semibold,
                            ),
                          )),
                      SizedBox(height: 8),
                      Obx(() => Text(
                            '\$ ${cartC.coffeePrice.value.toStringAsFixed(1)}',
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontWeight: semibold,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),

            Divider(
              thickness: 2,
              color: Colors.white24,
            ),

            // Grand Total
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grand Total',
                    style: rosarivo.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Obx(() => Text(
                        '\$ ${cartC.grandTotalPrice.value.toStringAsFixed(1)}',
                        style: openSans.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: semibold,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget dialog() {
      return AlertDialog(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    cartC.payNowDispose();
                  },
                  child: Icon(
                    Icons.close,
                    color: bgColor,
                  ),
                ),
              ),
              Image.asset(
                'assets/icon_success.png',
                width: 100,
                color: bgColor,
              ),
              SizedBox(height: 12),
              Text(
                'Hurray :)',
                style: openSans.copyWith(
                  fontWeight: semibold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Payment successfully',
                style: openSans,
              ),
              SizedBox(height: 20),
              Container(
                height: 44,
                width: 154,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    cartC.payNowDispose();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: bgColor,
                  ),
                  child: Text(
                    'Close',
                    style: openSans.copyWith(
                        color: primaryColor, fontWeight: medium, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget payNow() {
      return Container(
        width: double.infinity,
        height: 45,
        margin: EdgeInsets.only(
          bottom: 36,
          left: 16,
          right: 16,
        ),
        child: TextButton(
          onPressed: () {
            Get.dialog(
              (cartC.jumlahCart == 0) ? SizedBox() : dialog(),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'PAY NOW',
            style: openSans.copyWith(
              color: Color(0xff4A2B29),
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: (cartC.jumlahCart == 0)
            ? emptyCart()
            : Column(
                children: [
                  header(),
                  cart(),
                  totalPrice(),
                  Spacer(),
                  payNow(),
                ],
              ),
      ),
    );
  }
}

import 'package:coffee_shop/controllers/coffee_controller.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/themes/themes.dart';
import 'package:get/get.dart';

class GetPhotoButtons extends StatelessWidget {
  String name;
  var source;
  GetPhotoButtons({
    required this.name,
    this.source,
  });
  @override
  Widget build(BuildContext context) {
    final coffeeC = Get.find<CoffeeController>();

    return Container(
      width: 140,
      child: TextButton(
        onPressed: () {
          coffeeC.getImage(source);
          Navigator.pop(context);
        },
        child: Text(
          name,
          style: rosarivo.copyWith(
            color: bgColor,
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}

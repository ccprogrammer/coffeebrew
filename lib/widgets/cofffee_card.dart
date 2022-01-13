import 'dart:io';
import 'package:coffee_shop/controllers/cart_controller.dart';
import 'package:coffee_shop/controllers/coffee_controller.dart';
import 'package:coffee_shop/controllers/users_controller.dart';
import 'package:coffee_shop/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/themes.dart';

class CoffeeCard extends StatelessWidget {
  final int index;
  CoffeeCard(this.index);

  @override
  Widget build(BuildContext context) {
    final coffeeC = Get.find<CoffeeController>();
    final usersC = Get.find<UsersController>();
    final cartC = Get.put(CartController());

    var id = coffeeC.coffeeList[index].id;
    var user = usersC.user.value;

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          (user == 'user') ? RouteName.detail_page : RouteName.editCoffee_page,
          arguments: id,
        );
      },
      child: Container(
        width: 135,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Image
            Stack(
              children: [
                (coffeeC.coffeeList[index].imageUrl == '')
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/image_photo.png',
                          width: 211,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          File(coffeeC.coffeeList[index].imageUrl),
                          width: 211,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                // Score
                Container(
                  width: 50,
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    color: Color(0xff414141).withOpacity(0.5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Color(0xffD3A601),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${coffeeC.coffeeList[index].score}',
                        style: rosarivo.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Delete
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      coffeeC.deleteItem(id).then(
                            (value) => coffeeC.snackBar(
                              'SUCCESS',
                              'Item deleted',
                              bgColor,
                              bgColor,
                              Colors.redAccent,
                            ),
                          );
                    },
                    child: Container(
                      width: 50,
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        color: Color(0xff414141).withOpacity(0.5),
                      ),
                      child: Icon(
                        Icons.remove_circle,
                        color: Color(0xffC94C4C),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Name
            Container(
              child: Text(
                coffeeC.coffeeList[index].name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: rosarivo.copyWith(color: Colors.white, fontSize: 16),
              ),
            ),
            Spacer(),
            // Price
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.08),
              ),
              child: Row(
                children: [
                  SizedBox(width: 22),
                  Text(
                    '\$${coffeeC.coffeeList[index].price}',
                    style: rosarivo.copyWith(
                      color: Colors.white,
                      fontWeight: semibold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  // Button Add
                  GestureDetector(
                    onTap: () {
                      cartC.addCart(
                        coffeeC.coffeeList[index].imageUrl,
                        coffeeC.coffeeList[index].coffee,
                        coffeeC.coffeeList[index].name,
                        coffeeC.coffeeList[index].price,
                        1,
                      );
                      coffeeC.snackBar(
                        'SUCCESS',
                        'Item added to cart',
                        bgColor,
                        bgColor,
                        primaryColor,
                      );
                    },
                    child: Container(
                      width: 39,
                      height: 39,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor,
                      ),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

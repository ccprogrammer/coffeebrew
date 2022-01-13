import 'package:coffee_shop/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/themes.dart';
import 'dart:io';

class CartTile extends StatefulWidget {
  final int index;
  CartTile(this.index);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    final cartC = Get.find<CartController>();

    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white10,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: (cartC.cartList[widget.index].imageUrl == '')
                ? Image.asset(
                    'assets/image_photo.png',
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(
                      cartC.cartList[widget.index].imageUrl,
                    ),
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartC.cartList[widget.index].coffee,
                  style: rosarivo.copyWith(
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  cartC.cartList[widget.index].name,
                  style: rosarivo.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  '\$${cartC.cartList[widget.index].price}',
                  style: rosarivo.copyWith(
                    color: Colors.white,
                    fontWeight: semibold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.08),
            ),
            child: Row(
              children: [
                // Remove item
                GestureDetector(
                  onTap: () {
                    cartC.removeItem(
                      cartC.cartList[widget.index].id,
                      cartC.cartList[widget.index].price,
                    );
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColor,
                    ),
                    width: 30,
                    height: 30,
                    child: Icon(Icons.remove),
                  ),
                ),
                // Total Item
                Container(
                  width: 30,
                  child: Center(
                    child: Text(
                      '${cartC.cartList[widget.index].item}',
                      style: rosarivo.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                // Add item
                GestureDetector(
                  onTap: () {
                    cartC.addMoreItem(
                      cartC.cartList[widget.index].id,
                      cartC.cartList[widget.index].price,
                    );
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColor,
                    ),
                    width: 30,
                    height: 30,
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

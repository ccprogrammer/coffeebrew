import 'dart:convert';
import 'package:coffee_shop/models/coffee_model.dart';
import 'package:coffee_shop/routes/routes_name.dart';
import 'package:coffee_shop/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CoffeeController extends GetxController {
  var coffeeList = <CoffeeModel>[].obs;

  int get jumlahCoffee => coffeeList.length;

  CoffeeModel selectedById(String id) =>
      coffeeList.firstWhere((coffee) => coffee.id == id);

  @override
  void onInit() {
    // TODO: implement onInit
    initialData();
    super.onInit();
  }

  var selectedImagePath = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      snackBar(
        'NO IMAGE',
        'Please choose an image',
        bgColor,
        bgColor,
        Colors.redAccent,
      );
    }
  }

  Future addItem(String imageUrl, String coffee, String name,
      String description, String price, int score) async {
    var url = Uri.parse(
        'https://coffee-shop-35be3-default-rtdb.firebaseio.com/coffee.json');
    if (imageUrl == '' ||
        coffee == '' ||
        name == '' ||
        price == '' ||
        description == '') {
      snackBar(
        'WARNING',
        'Please fill the input field',
        bgColor,
        bgColor,
        Colors.redAccent,
      );
    } else {
      final response = await http
          .post(
            url,
            body: json.encode(
              {
                'imageUrl': imageUrl,
                'coffee': coffee,
                'name': name,
                'description': description,
                'price': price,
                'score': score,
              },
            ),
          )
          .then(
            (response) => coffeeList.add(
              CoffeeModel(
                id: json.decode(response.body)['name'].toString(),
                score: score,
                imageUrl: selectedImagePath.value,
                coffee: coffee,
                name: name,
                description: description,
                price: price,
              ),
            ),
          )
          .then(
            (value) => snackBar(
              'SUCCESS',
              'New item added',
              bgColor,
              bgColor,
              primaryColor,
            ),
          );
      selectedImagePath.value = '';
      imageUrl = '';
      coffee = '';
      name = '';
      description = '';
      price = '';

      Get.offNamed(RouteName.seller_page);
    }
  }

  Future editItem(String id, String imageUrl, String coffee, String name,
      String description, String price) async {
    var url = Uri.parse(
        'https://coffee-shop-35be3-default-rtdb.firebaseio.com/coffee/$id.json');

    if (imageUrl == '' ||
        coffee == '' ||
        name == '' ||
        price == '' ||
        description == '') {
      snackBar(
        'WARNING',
        'Please fill the input field',
        bgColor,
        bgColor,
        Colors.redAccent,
      );
    } else {
      final response = await http
          .patch(
        url,
        body: json.encode(
          {
            'imageUrl': imageUrl,
            'coffee': coffee,
            'name': name,
            'description': description,
            'price': price,
          },
        ),
      )
          .then(
        (response) {
          CoffeeModel selectCoffee = selectedById(id);
          selectCoffee.imageUrl = imageUrl;
          selectCoffee.coffee = coffee;
          selectCoffee.name = name;
          selectCoffee.price = price;
          Get.offNamed(RouteName.seller_page);
        },
      ).then(
        (value) => snackBar(
          'SUCCESS',
          'Item edited',
          bgColor,
          bgColor,
          Colors.lightBlueAccent,
        ),
      );
    }
  }

  Future deleteItem(id) async {
    var url = Uri.parse(
        'https://coffee-shop-35be3-default-rtdb.firebaseio.com/coffee/$id.json');
    final response = await http.delete(url).then(
          (response) => coffeeList.removeWhere((coffee) => coffee.id == id),
        );
  }

  Future initialData() async {
    var url = Uri.parse(
        'https://coffee-shop-35be3-default-rtdb.firebaseio.com/coffee.json');
    final response = await http.get(url);
    final dataResponse = json.decode(response.body) as Map<String, dynamic>;

    dataResponse.forEach(
      (key, value) {
        coffeeList.add(CoffeeModel(
          id: key,
          imageUrl: value['imageUrl'],
          coffee: value['coffee'],
          name: value['name'],
          description: value['description'],
          price: value['price'],
          score: value['score'],
        ));
      },
    );
  }

  void snackBar(
    title,
    message,
    titleColor,
    messageColor,
    snackColor,
  ) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: openSans.copyWith(
            color: titleColor, fontWeight: bold, fontSize: 16),
      ),
      messageText: Text(
        message,
        style: openSans.copyWith(
          color: messageColor,
          fontWeight: medium,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: snackColor,
      animationDuration: Duration(milliseconds: 700),
      duration: Duration(milliseconds: 1500),
      margin: EdgeInsets.all(0),
      borderRadius: 0,
      isDismissible: true,
    );
  }
}

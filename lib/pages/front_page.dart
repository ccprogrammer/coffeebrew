import 'package:coffee_shop/controllers/users_controller.dart';
import 'package:coffee_shop/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrontPage extends StatelessWidget {
  TextEditingController textUsername = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usersC = Get.put(UsersController());

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Username
          Spacer(),
          Container(
            margin: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 28,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: rosarivo.copyWith(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Container(
                  height: 25,
                  child: TextField(
                    controller: textUsername,
                    textInputAction: TextInputAction.next,
                    style: openSans.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Password
          Container(
            margin: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 28,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: rosarivo.copyWith(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Container(
                  height: 25,
                  child: TextField(
                    controller: textPassword,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () =>
                        usersC.signIn(textUsername.text, textPassword.text),
                    style: openSans.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Login
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: TextButton(
              onPressed: () =>
                  usersC.signIn(textUsername.text, textPassword.text),
              child: Text(
                'Login',
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
          ),
          // Sign Up
          Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: rosarivo.copyWith(
                    color: Colors.white,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'Sign Up',
                  style: rosarivo.copyWith(
                    color: Colors.lightBlue,
                    fontWeight: medium,
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

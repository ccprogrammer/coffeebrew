import 'package:coffee_shop/pages/front_page.dart';
import 'package:coffee_shop/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FrontPage(),
      getPages: AppRoutes.pages,
    );
  }
}

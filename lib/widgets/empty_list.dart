import 'package:coffee_shop/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EmptyList extends StatelessWidget {
  double size;
  EmptyList({required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Center(
        child: SpinKitRing(
          color: primaryColor,
          size: size,
        ),
      ),
    );
  }
}

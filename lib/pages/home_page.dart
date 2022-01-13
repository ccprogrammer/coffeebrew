import 'package:coffee_shop/controllers/coffee_controller.dart';
import 'package:coffee_shop/routes/routes_name.dart';
import 'package:coffee_shop/themes/themes.dart';
import 'package:coffee_shop/widgets/cofffee_card.dart';
import 'package:coffee_shop/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coffeeC = Get.put(CoffeeController());

    final List<String> imgList = [
      'https://media.istockphoto.com/photos/barista-making-latte-art-shot-focus-in-cup-of-milk-and-coffee-vintage-picture-id1282882269?b=1&k=20&m=1282882269&s=170667a&w=0&h=F9y-c5Z7hmiB-dPF7cpb6c_0JJvzQtj7ki9I3recuHs=',
      'https://media.istockphoto.com/photos/barista-preparing-to-test-and-inspecting-the-quality-of-coffee-picture-id1284116251?b=1&k=20&m=1284116251&s=170667a&w=0&h=W3bkq3BplVPXWoCaSQnZ41iAaNLA1004Jj0R02B0kFo=',
      'https://images.unsplash.com/photo-1511920170033-f8396924c348?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y29mZmVlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1541167760496-1628856ab772?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Y29mZmVlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGNvZmZlZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fGNvZmZlZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
    ];

    Widget imageCarousel() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 3.0,
            enlargeCenterPage: true,
          ),
          items: imgList
              .map(
                (image) => ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              )
              .toList(),
        ),
      );
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 32,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                coffeeC.initialData();
              },
              child: Image.asset(
                'assets/image_logo.png',
                width: 100,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.dialog(
                  Center(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: TextButton(
                        onPressed: () {
                          Get.offAllNamed(RouteName.front_page);
                        },
                        child: Text(
                          'Logout',
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
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primaryColor,
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80',
                  ),
                  radius: 30,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget coffeeTitle() {
      return Container(
        margin: EdgeInsets.only(
          left: 16,
          top: 24,
        ),
        child: Text(
          'Take Your Coffee',
          style: rosarivo.copyWith(
            color: primaryColor,
            fontSize: 22,
            fontWeight: medium,
          ),
        ),
      );
    }

    Widget coffee() {
      return Obx(
        () => (coffeeC.jumlahCoffee == 0)
            ? EmptyList(size: 100)
            : Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 6.3 / 10,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: coffeeC.jumlahCoffee,
                  itemBuilder: (context, index) {
                    return CoffeeCard(index);
                  },
                ),
              ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            imageCarousel(),
            coffeeTitle(),
            coffee(),
          ],
        ),
      ),
    );
  }
}

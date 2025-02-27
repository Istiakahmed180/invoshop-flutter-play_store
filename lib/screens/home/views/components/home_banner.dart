import 'package:invoshop/common/controller/bottom_navigation_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBannerSlider extends StatelessWidget {
  const HomeBannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController bottomNavigationController =
        Get.put(BottomNavigationController());

    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        autoPlay: true,
        enlargeCenterPage: false,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
        autoPlayInterval: const Duration(seconds: 10),
        autoPlayAnimationDuration: const Duration(milliseconds: 1400),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
      items: [
        "assets/images/banners/banner-1.png",
        "assets/images/banners/banner-2.png",
        "assets/images/banners/banner-3.png",
        "assets/images/banners/banner-1.png",
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                bottomNavigationController.onItemTapped(2);
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    i,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

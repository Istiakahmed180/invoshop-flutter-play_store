import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/home/controller/home_controller.dart';
import 'package:ai_store/screens/home/views/components/special_offers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialOfferSlider extends StatelessWidget {
  const SpecialOfferSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final specialOffersList = homeController.specialOffersProductList;
    if (specialOffersList.isEmpty) {
      return const Center(
        child: Text(
          'No special offers available',
          style: TextStyle(fontSize: 16, color: AppColors.groceryRatingGray),
        ),
      );
    }

    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 170,
        viewportFraction: 1.0,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: specialOffersList.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final product = specialOffersList[index];
        return Center(
          child: SpecialOffersCard(product: product),
        );
      },
    );
  }
}

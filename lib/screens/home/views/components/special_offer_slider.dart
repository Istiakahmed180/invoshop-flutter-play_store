import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/home/controller/home_controller.dart';
import 'package:invoshop/screens/home/views/components/special_offers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpecialOfferSlider extends StatelessWidget {
  const SpecialOfferSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final specialOffersList = homeController.specialOffersProductList;
    if (specialOffersList.isEmpty) {
      return Center(
        child: Text(
          'No products available',
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.groceryPrimary.withValues(alpha: 0.5),
          ),
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

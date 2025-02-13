import 'package:ai_store/screens/home/controller/home_controller.dart';
import 'package:ai_store/screens/products/views/components/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductSlider extends StatelessWidget {
  final String whichProductEndpoint;

  const ProductSlider({super.key, required this.whichProductEndpoint});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Obx(() {
      final int productCount = whichProductEndpoint == "Fresh Products"
          ? homeController.freshProductList.length
          : whichProductEndpoint == "New Arrivals Products"
              ? homeController.newArrivalsProductList.length
              : whichProductEndpoint == "Best Sellers Products"
                  ? homeController.bestSellersProductList.length
                  : whichProductEndpoint == "Trending Products"
                      ? homeController.trendingProductList.length
                      : whichProductEndpoint == "Featured Products"
                          ? homeController.featuredProductList.length
                          : homeController.exclusiveAppOnlyProductList.length;
      final int totalSlides = (productCount ~/ 2) + (productCount % 2);

      return CarouselSlider.builder(
        options: CarouselOptions(
          height: 250.0,
          viewportFraction: 1.0,
          scrollDirection: Axis.horizontal,
        ),
        itemCount: totalSlides,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          final int firstIndex = index * 2;
          final int secondIndex = firstIndex + 1;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (firstIndex < productCount)
                Expanded(
                  child: ProductCard(
                    product: homeController.freshProductList[firstIndex],
                  ),
                ),
              SizedBox(width: 10.w),
              if (secondIndex < productCount)
                Expanded(
                  child: ProductCard(
                    product: homeController.freshProductList[secondIndex],
                  ),
                ),
            ],
          );
        },
      );
    });
  }
}

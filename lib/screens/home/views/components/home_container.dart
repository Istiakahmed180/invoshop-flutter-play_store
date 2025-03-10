import 'package:invoshop/common/controller/bottom_navigation_controller.dart';
import 'package:invoshop/common/controller/categories_controller.dart';
import 'package:invoshop/common/widgets/common_header.dart';
import 'package:invoshop/common/widgets/custom_button_no_border.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/common/widgets/section_title.dart';
import 'package:invoshop/screens/home/controller/home_controller.dart';
import 'package:invoshop/screens/home/views/components/category_slider.dart';
import 'package:invoshop/screens/home/views/components/home_banner.dart';
import 'package:invoshop/screens/home/views/components/product_slider.dart';
import 'package:invoshop/screens/home/views/components/special_offer_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  final BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => homeController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : Column(
                children: [
                  const CommonHeader(),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      children: [
                        const SizedBox(height: 16),
                        const HomeBannerSlider(),
                        const SizedBox(height: 16),
                        buildSection(
                          title: "Shop By Categories",
                          onTap: () =>
                              bottomNavigationController.onItemTapped(1),
                          child: CategorySlider(
                            categoriesController: categoriesController,
                          ),
                        ),
                        Visibility(
                          visible: homeController.freshProductList.isNotEmpty,
                          child: buildSection(
                            title: "All Fresh Products Daily",
                            onTap: () =>
                                bottomNavigationController.onItemTapped(2),
                            child: const ProductSlider(
                              whichProductEndpoint: "Fresh Products",
                            ),
                          ),
                        ),
                        Visibility(
                          visible: homeController
                              .specialOffersProductList.isNotEmpty,
                          child: buildSection(
                            title: "Special Offers of the Week!",
                            onTap: () =>
                                bottomNavigationController.onItemTapped(1),
                            child: const SpecialOfferSlider(),
                          ),
                        ),
                        Visibility(
                          visible:
                              homeController.newArrivalsProductList.isNotEmpty,
                          child: buildSection(
                            title: "New Arrivals",
                            onTap: () =>
                                bottomNavigationController.onItemTapped(2),
                            child: const ProductSlider(
                              whichProductEndpoint: "New Arrivals Products",
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              homeController.bestSellersProductList.isNotEmpty,
                          child: buildSection(
                            title: "Best Sellers",
                            onTap: () =>
                                bottomNavigationController.onItemTapped(2),
                            child: const ProductSlider(
                              whichProductEndpoint: "Best Sellers Products",
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              homeController.trendingProductList.isNotEmpty,
                          child: buildSection(
                            title: "Trending Products",
                            onTap: () =>
                                bottomNavigationController.onItemTapped(2),
                            child: const ProductSlider(
                              whichProductEndpoint: "Trending Products",
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              homeController.featuredProductList.isNotEmpty,
                          child: buildSection(
                            title: "Featured Products",
                            onTap: () =>
                                bottomNavigationController.onItemTapped(2),
                            child: const ProductSlider(
                                whichProductEndpoint: "Featured Products"),
                          ),
                        ),
                        Visibility(
                          visible: homeController
                              .exclusiveAppOnlyProductList.isNotEmpty,
                          child: buildSection(
                            title: "Exclusive App-Only Offers",
                            onTap: () =>
                                bottomNavigationController.onItemTapped(2),
                            child: const ProductSlider(
                              whichProductEndpoint:
                                  "Exclusive App Only Products",
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget buildSection({
    required String title,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 4),
            Expanded(child: SectionTitle(title: title)),
            CustomButtonNoBorder(title: "See All", onPressed: onTap),
          ],
        ),
        const SizedBox(height: 8),
        child,
        const SizedBox(height: 16),
      ],
    );
  }
}

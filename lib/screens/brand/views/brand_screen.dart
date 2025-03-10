import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_common_title.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/brand/controller/brand_controller.dart';
import 'package:invoshop/screens/products/views/filtered_products_screen.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BrandController brandController = Get.put(BrandController());

    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Brand"),
      body: Obx(
        () => brandController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : Padding(
                padding: REdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.5,
                        ),
                        itemCount: brandController.brandList.length,
                        itemBuilder: (context, index) {
                          final brand = brandController.brandList[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => FilteredProductsScreen(
                                    brandID: brand.id.toString(),
                                    categoryTitle: brand.title!,
                                    requestType: "Brand",
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.groceryBodyTwo,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.grocerySubTitle
                                        .withOpacity(0.2),
                                  ),
                                ],
                                border: Border.all(
                                  color: AppColors.groceryBorder,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: REdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FutureBuilder(
                                      future: ApiPath.getImageUrl(
                                          brand.image!.path!),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox();
                                        }
                                        if (snapshot.hasError) {
                                          return const Icon(
                                            Icons.broken_image,
                                            size: 50,
                                            color: AppColors.groceryBorder,
                                          );
                                        }
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          child: FadeInImage.assetNetwork(
                                              height: 40,
                                              width: 40,
                                              fit: BoxFit.cover,
                                              placeholder:
                                                  "assets/gif/loading.gif",
                                              image: snapshot.data!,
                                              imageErrorBuilder: (context,
                                                      error, stackTrace) =>
                                                  const Icon(
                                                    Icons.broken_image,
                                                    color: AppColors
                                                        .groceryRatingGray,
                                                  )),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    CustomTitleText(
                                      title: brand.title!,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

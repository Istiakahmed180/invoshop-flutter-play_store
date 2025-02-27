import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/combo_offers/controller/combo_offer_controller.dart';
import 'package:invoshop/screens/combo_offers/views/screen/combo_cart_screen/combo_cart_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ComboOfferScreen extends StatelessWidget {
  const ComboOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ComboOfferController comboOfferController =
        Get.put(ComboOfferController());

    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Combo Offer"),
      body: Obx(
        () => comboOfferController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                itemCount: comboOfferController.comboOfferList.length,
                padding: REdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final product = comboOfferController.comboOfferList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(ComboCartScreen(product: product));
                    },
                    child: Container(
                      padding: REdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.groceryBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FutureBuilder(
                            future: ApiPath.getImageUrl(product.image!),
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
                              return CachedNetworkImage(
                                imageUrl: snapshot.data ?? "",
                                placeholder: (context, url) =>
                                    Image.asset("assets/gif/loading.gif"),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: AppColors.groceryBorder
                                          .withOpacity(0.5)),
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: AppColors.groceryRatingGray,
                                  ),
                                ),
                                height: 200,
                              );
                            },
                          ),
                          SizedBox(height: 5.h),
                          CustomElevatedButton(
                            buttonName: "Buy Now",
                            onPressed: () {
                              Get.to(ComboCartScreen(product: product));
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

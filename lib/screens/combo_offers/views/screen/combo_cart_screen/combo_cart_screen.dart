import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/combo_offers/model/combo_offer_model.dart';

class ComboCartScreen extends StatefulWidget {
  final ComboOfferData product;

  const ComboCartScreen({super.key, required this.product});

  @override
  State<ComboCartScreen> createState() => _ComboCartScreenState();
}

class _ComboCartScreenState extends State<ComboCartScreen> {
  final CurrencyController currencyController = Get.put(CurrencyController());

  double calculateTotalPrice() {
    double total = 0.0;
    for (var product in widget.product.comboOfferProducts!) {
      double price = double.parse(product.product!.price!);
      int quantity = int.parse(product.quantity.toString());
      total += price * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "My Cart"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.product.comboOfferProducts!.length,
                  itemBuilder: (context, index) {
                    final product = widget.product.comboOfferProducts![index];
                    final bool isLastItem =
                        index == widget.product.comboOfferProducts!.length - 1;
                    return Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.groceryBodyTwo,
                                  borderRadius: BorderRadius.circular(8.r)),
                              width: 80.w,
                              height: 60.h,
                              child: FutureBuilder(
                                future: ApiPath.getImageUrl(
                                    product.product!.image!.path ?? ""),
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
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: AppColors.groceryBorder
                                              .withOpacity(0.5)),
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: AppColors.groceryRatingGray,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          product.product?.title ?? "N/A",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.groceryTitle),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "500Gm",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.groceryTextTwo,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${currencyController.currencySymbol}${(double.parse(product.product!.price!))}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.groceryPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w),
                                            child: Text(
                                              'Qty : ${product.quantity}',
                                              style: const TextStyle(
                                                color: AppColors.groceryText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        if (!isLastItem)
                          const Divider(
                            color: AppColors.groceryBorder,
                            thickness: 1,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: REdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.groceryPrimary.withOpacity(0.08),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r))),
            child: _summaryRow('Subtotal:'),
          )
        ],
      ),
    );
  }

  Widget _summaryRow(String title) {
    final double totalPrice = calculateTotalPrice();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        Text(
          '${currencyController.currencySymbol}${totalPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.groceryPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

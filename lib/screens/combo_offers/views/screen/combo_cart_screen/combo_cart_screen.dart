import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/screens/combo_offers/model/combo_offer_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComboCartScreen extends StatefulWidget {
  final ComboOfferData product;

  const ComboCartScreen({super.key, required this.product});

  @override
  State<ComboCartScreen> createState() => _ComboCartScreenState();
}

class _ComboCartScreenState extends State<ComboCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "My Cart"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                                      '\$${(double.parse(product.product!.price!) * double.parse(product.quantity.toString())).toStringAsFixed(2)}',
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
          ],
        ),
      ),
    );
  }
}

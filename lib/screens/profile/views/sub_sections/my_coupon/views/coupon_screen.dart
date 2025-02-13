import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/custom_common_title.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/profile/controller/coupon_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  final CouponController couponController = Get.put(CouponController());

  @override
  void initState() {
    super.initState();
    couponController.getCoupons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Coupons"),
      body: Obx(
        () => couponController.isLoading.value
            ? const CustomLoading(withOpacity: 0.0)
            : couponController.couponList.isEmpty
                ? Center(
                    child: Text(
                      'No expenses available',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.groceryPrimary.withOpacity(0.6),
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      ...couponController.couponList.map(
                        (coupon) => _buildCouponContainer(
                          title: coupon.title!,
                          subtitle: coupon.details ?? 'No details available',
                          expiry: DateFormat("dd-MM-yyyy")
                              .format(DateTime.parse(coupon.expireDate!)),
                          couponCode: coupon.code!,
                          backgroundColor: AppColors.groceryBody,
                          context: context,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _buildCouponContainer({
    required String title,
    required String subtitle,
    required String expiry,
    required String couponCode,
    required Color backgroundColor,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: couponCode)).then((_) {
          Fluttertoast.showToast(
              msg: "Coupon code $couponCode copied to clipboard!",
              textColor: AppColors.groceryWhite,
              backgroundColor: AppColors.groceryPrimary);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: AppColors.groceryBorder),
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTitleText(title: title),
                  Text(subtitle,
                      style: TextStyle(
                        color: AppColors.grocerySubTitle,
                        fontSize: 12.sp,
                      )),
                  Text('Code: $couponCode',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.groceryPrimary)),
                ],
              ),
            ),
            Text(
              "Expired : $expiry",
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/section_title.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/profile/views/sub_sections/orders_history/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  void _handleButtonAction(String status, int index) {
    if (status == "Delivered") {
    } else {
      setState(() {
        historyDemoData[index]["status"] = "Pending";
      });

      Fluttertoast.showToast(
        msg: "Order has been cancelled and status updated to 'Pending'.",
        backgroundColor: AppColors.groceryPrimary,
        textColor: AppColors.groceryWhite,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Order History"),
      body: Padding(
        padding: REdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              decoration: BoxDecoration(
                  color: AppColors.groceryBodyTwo,
                  borderRadius: BorderRadius.circular(4.r)),
              child: SectionTitle(
                  title: "Total Orders: ${historyDemoData.length}"),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: historyDemoData.length,
                itemBuilder: (context, index) {
                  final history = historyDemoData[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: REdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.groceryWhite,
                      borderRadius: BorderRadius.circular(6.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.groceryBorder.withOpacity(0.2),
                          blurRadius: 4.r,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(color: AppColors.groceryBorder),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order ID : ${history["orderId"]}",
                                style: const TextStyle(
                                  color: AppColors.groceryTitle,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                history["date"].toString(),
                                style: TextStyle(
                                  color: AppColors.grocerySubTitle,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "${history["productItem"]} ${history["productItem"] == "1" ? "item" : "items"}, Total: ${history["totalPrice"]}",
                                style: TextStyle(
                                  color: AppColors.grocerySubTitle,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Address: ${history["deliveryAddress"]}",
                                style: const TextStyle(
                                  color: AppColors.grocerySubTitle,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          children: [
                            Container(
                              width: 75.w,
                              height: 25.h,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 3.h),
                              decoration: BoxDecoration(
                                color:
                                    AppColors.groceryPrimary.withOpacity(0.07),
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(
                                    color: AppColors.groceryPrimary
                                        .withOpacity(0.1)),
                              ),
                              child: Text(
                                history["status"].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.groceryPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            GestureDetector(
                              onTap: () => _handleButtonAction(
                                  history["status"].toString(), index),
                              child: Container(
                                width: 75.w,
                                height: 25.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: history["status"] == "Delivered"
                                      ? AppColors.groceryPrimary
                                          .withOpacity(0.1)
                                      : AppColors.grocerySecondary
                                          .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(
                                    color: history["status"] == "Delivered"
                                        ? AppColors.groceryPrimary
                                            .withOpacity(0.1)
                                        : AppColors.grocerySecondary
                                            .withOpacity(0.1),
                                  ),
                                ),
                                child: Text(
                                  history["status"] == "Delivered"
                                      ? "Re-Order"
                                      : "Cancel",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: history["status"] == "Delivered"
                                        ? AppColors.groceryPrimary
                                        : AppColors.grocerySecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

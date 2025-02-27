import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/report/controller/reports_controller.dart';
import 'package:invoshop/screens/report/view/customer_report/customer_report.dart';
import 'package:invoshop/screens/report/view/discount_report/discount_report.dart';
import 'package:invoshop/screens/report/view/expense_report/expense_report.dart';
import 'package:invoshop/screens/report/view/payment_report/payment_report.dart';
import 'package:invoshop/screens/report/view/product_report/product_report.dart';
import 'package:invoshop/screens/report/view/purchase_report/purchase_report.dart';
import 'package:invoshop/screens/report/view/sales_report/sales_report.dart';
import 'package:invoshop/screens/report/view/stock_report/stock_report.dart';
import 'package:invoshop/screens/report/view/supplier_report/supplier_report.dart';
import 'package:invoshop/screens/report/view/tax_report/tax_report.dart';
import 'package:invoshop/screens/report/view/user_report/user_report.dart';
import 'package:invoshop/screens/report/view/warehouse_report/warehouse_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportsController reportsController = Get.put(ReportsController());

    return Scaffold(
      appBar: CustomAppBar(appBarName: "Reports"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12.w),
              itemCount: reportsController.reports.length,
              itemBuilder: (context, index) {
                final report = reportsController.reports[index];
                return Obx(() => ReportItem(
                      icon: report['icon'],
                      title: report['title'],
                      isSelected:
                          reportsController.selectedIndex.value == index,
                      onTap: () {
                        reportsController.selectedIndex.value = index;
                        if (reportsController.selectedIndex.value == 0) {
                          Get.to(SalesReport());
                        } else if (reportsController.selectedIndex.value == 1) {
                          Get.to(PurchaseReport());
                        } else if (reportsController.selectedIndex.value == 2) {
                          Get.to(PaymentReport());
                        } else if (reportsController.selectedIndex.value == 3) {
                          Get.to(ProductReport());
                        } else if (reportsController.selectedIndex.value == 4) {
                          Get.to(StockReport());
                        } else if (reportsController.selectedIndex.value == 5) {
                          Get.to(ExpenseReport());
                        } else if (reportsController.selectedIndex.value == 6) {
                          Get.to(UserReport());
                        } else if (reportsController.selectedIndex.value == 7) {
                          Get.to(CustomerReport());
                        } else if (reportsController.selectedIndex.value == 8) {
                          Get.to(WarehouseReport());
                        } else if (reportsController.selectedIndex.value == 9) {
                          Get.to(SupplierReport());
                        } else if (reportsController.selectedIndex.value ==
                            10) {
                          Get.to(DiscountReport());
                        } else if (reportsController.selectedIndex.value ==
                            11) {
                          Get.to(TaxReport());
                        }
                      },
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReportItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ReportItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.groceryPrimary.withOpacity(0.2)
              : AppColors.groceryRatingGray.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: isSelected
                  ? AppColors.groceryPrimary
                  : AppColors.groceryRatingGray),
        ),
        child: Icon(icon,
            color: isSelected
                ? AppColors.groceryPrimary
                : AppColors.groceryRatingGray,
            size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.groceryPrimary : Colors.black87,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      onTap: onTap,
    );
  }
}

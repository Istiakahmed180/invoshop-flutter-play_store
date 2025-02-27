import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/profile/controller/transaction_controller.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TransactionController transactionController =
      Get.put(TransactionController());
  final CurrencyController currencyController = Get.put(CurrencyController());

  String getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return '#4CAF50';
      case 'pending':
        return '#FFC107';
      case 'cancelled':
        return '#F44336';
      default:
        return '#9E9E9E';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarName: "Transaction History",
      ),
      body: Obx(
        () => transactionController.isLoading.value
            ? const CustomLoading(withOpacity: 0.0)
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: REdgeInsets.all(12),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.groceryPrimary,
                                  AppColors.groceryPrimary.withOpacity(0.8)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.groceryPrimary.withOpacity(0.2),
                                  blurRadius: 8.r,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Total Transactions",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "${transactionController.transactionList.length}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  transactionController.transactionList.isEmpty
                      ? SliverFillRemaining(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long_outlined,
                                  size: 64.sp,
                                  color: AppColors.groceryRatingGray,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'No transactions available',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.groceryRatingGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final transaction =
                                  transactionController.transactionList[index];
                              final String customerFullName = [
                                transaction.customer!.firstName ?? "",
                                transaction.customer!.lastName ?? ""
                              ].join(" ").trim();

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 5.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.groceryPrimary.withAlpha(10),
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.groceryBorder
                                            .withOpacity(0.1),
                                        blurRadius: 8.r,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ExpansionTile(
                                    iconColor: AppColors.groceryPrimary,
                                    collapsedIconColor:
                                        AppColors.groceryPrimary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    tilePadding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 5.h),
                                    title: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColors
                                              .groceryPrimary
                                              .withOpacity(0.1),
                                          child: Text(
                                            customerFullName.isNotEmpty
                                                ? customerFullName[0]
                                                : "?",
                                            style: const TextStyle(
                                              color: AppColors.groceryPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                customerFullName.isEmpty
                                                    ? "Unknown Customer"
                                                    : customerFullName,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.groceryTitle,
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                "Total: ${currencyController.currencySymbol}${transaction.totalAmount ?? "0.00"}",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color:
                                                      AppColors.groceryPrimary,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 4.h),
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(
                                                    getStatusColor(
                                                            transaction.status)
                                                        .replaceAll(
                                                            '#', '0xFF')))
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                          child: Text(
                                            transaction.status ?? "N/A",
                                            style: TextStyle(
                                              color: Color(int.parse(
                                                  getStatusColor(
                                                          transaction.status)
                                                      .replaceAll(
                                                          '#', '0xFF'))),
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(12.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildInfoRow(
                                                "Phone",
                                                transaction.customer!.phone ??
                                                    "N/A"),
                                            _buildInfoRow(
                                                "Email",
                                                transaction.customer!.email ??
                                                    "N/A"),
                                            _buildInfoRow(
                                                "Address",
                                                transaction.customer!.address ??
                                                    "N/A"),
                                            _buildInfoRow("Paid At",
                                                transaction.paidAt ?? "N/A"),
                                            _buildInfoRow("Total Orders",
                                                "${transaction.orderProducts!.length}"),
                                            SizedBox(height: 16.h),
                                            Text(
                                              "Order Items",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.groceryTitle,
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                  height: 5.h,
                                                );
                                              },
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: transaction
                                                  .orderProducts!.length,
                                              itemBuilder: (context, index) {
                                                final order = transaction
                                                    .orderProducts![index];
                                                return Row(
                                                  children: [
                                                    Container(
                                                      width: 35.w,
                                                      height: 35.w,
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .groceryPrimary
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "${index + 1}",
                                                          style:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .groceryPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 12.w),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            order.product !=
                                                                    null
                                                                ? order.product!
                                                                        .title ??
                                                                    "Unknown Product"
                                                                : "Unknown Product",
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .groceryTitle,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Quantity: ${order.quantity ?? 0}",
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                              color: AppColors
                                                                  .grocerySubTitle,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      "${currencyController.currencySymbol}${order.amount ?? "0.00"}",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .groceryPrimary,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount:
                                transactionController.transactionList.length,
                          ),
                        ),
                ],
              ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              "$label :",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.grocerySubTitle,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.groceryTitle,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

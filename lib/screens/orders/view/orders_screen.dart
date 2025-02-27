import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/controller/orders_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/constants/user_role.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersController ordersController = Get.put(OrdersController());
  final CurrencyController currencyController = Get.put(CurrencyController());
  late Map<int, Future<String>> imageFutures;
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    loadUser();
    imageFutures = {};
  }

  Future<String> _getImageFuture(int index, String imagePath) {
    return imageFutures.putIfAbsent(
        index, () => ApiPath.getImageUrl(imagePath));
  }

  Future<void> loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString("user");
    if (userData != null && userData.isNotEmpty) {
      setState(() {
        user = jsonDecode(userData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return CustomLoading(
        withOpacity: 0.0,
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Orders"),
      body: Obx(() {
        if (ordersController.isLoading.value) {
          return const CustomLoading(withOpacity: 0.0);
        }

        if (ordersController.ordersList.isEmpty) {
          return _buildNoOrdersMessage();
        }

        return RefreshIndicator(
          backgroundColor: AppColors.groceryBody,
          color: AppColors.groceryPrimary,
          onRefresh: ordersController.getOrders,
          child: Stack(
            children: [
              Column(
                children: [
                  if (user!["user_role"] == UserRole.vendor)
                    SizedBox(height: 10.h),
                  if (user!["user_role"] == UserRole.vendor)
                    _buildAcceptAllButton(),
                  SizedBox(height: 10.h),
                  _buildDataTable(),
                  SizedBox(height: 16.h),
                ],
              ),
              Obx(
                () => Visibility(
                  visible: ordersController.isStatusUpdateLoading.value,
                  child: const CustomLoading(),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildNoOrdersMessage() {
    return Center(
      child: Text(
        'No orders available',
        style: TextStyle(
          fontSize: 13.sp,
          color: AppColors.groceryPrimary.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _buildAcceptAllButton() {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: CustomElevatedButton(
          buttonName: "Accept All",
          onPressed: () async {
            if (ordersController.selectedRows.contains(true)) {
              showDialog(
                context: context,
                builder: (context) => _buildAcceptAlertDialog(
                  acceptType: "Update All",
                  onTap: () async {
                    Get.back();
                    await ordersController.postOrderStatusUpdate();
                  },
                ),
              );
            } else {
              Fluttertoast.showToast(
                msg: "No products selected",
                backgroundColor: AppColors.grocerySecondary,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return Expanded(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          scrollDirection: Axis.horizontal,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: DataTable(
              showCheckboxColumn: false,
              border: TableBorder(
                borderRadius: BorderRadius.circular(4.r),
                horizontalInside: BorderSide(
                  color: AppColors.groceryPrimary.withOpacity(0.2),
                  width: 0.5,
                ),
                verticalInside: BorderSide(
                  color: AppColors.groceryPrimary.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
              headingRowColor: WidgetStateProperty.all(
                AppColors.groceryPrimary.withOpacity(0.1),
              ),
              dataRowColor: WidgetStateProperty.resolveWith(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.groceryPrimary.withOpacity(0.2);
                  }
                  return AppColors.groceryPrimary.withOpacity(0.05);
                },
              ),
              horizontalMargin: 15,
              columnSpacing: 40,
              headingRowHeight: 60,
              dataRowMaxHeight: 60,
              dividerThickness: 0.5,
              columns: _buildTableColumns(),
              rows: _buildTableRows(),
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    return [
      if (user!["user_role"] == UserRole.vendor)
        DataColumn(
          label: Checkbox(
            value: ordersController.isHeaderChecked.value,
            onChanged: (bool? value) {
              ordersController.toggleAllCheckboxes();
            },
            activeColor: AppColors.groceryPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: BorderSide(
              color: AppColors.groceryPrimary.withOpacity(0.4),
              width: 1.0,
            ),
          ),
        ),
      _buildTableHeader("Order ID"),
      _buildTableHeader("Image"),
      _buildTableHeader("Name"),
      _buildTableHeader("Code"),
      _buildTableHeader("Category"),
      _buildTableHeader("Unit"),
      _buildTableHeader("Color Variant"),
      _buildTableHeader("Size Variant"),
      _buildTableHeader("Price"),
      _buildTableHeader("Status"),
      if (user!["user_role"] == UserRole.vendor) _buildTableHeader("Action"),
    ];
  }

  DataColumn _buildTableHeader(String label) {
    return DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.groceryPrimary,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  List<DataRow> _buildTableRows() {
    return ordersController.ordersList.asMap().entries.map((entry) {
      final index = entry.key;
      final order = entry.value;

      return DataRow(
        selected: ordersController.selectedRows[index],
        onSelectChanged: (bool? value) {
          if (value != null) {
            ordersController.selectedRows[index] = value;
            ordersController.isHeaderChecked.value =
                ordersController.selectedRows.every((isSelected) => isSelected);
          }
        },
        cells: [
          if (user!["user_role"] == UserRole.vendor)
            DataCell(
              Checkbox(
                value: ordersController.selectedRows[index],
                onChanged: (bool? value) {
                  ordersController.selectedRows[index] = value ?? false;
                  ordersController.isHeaderChecked.value =
                      ordersController.selectedRows.every((element) => element);
                },
                activeColor: AppColors.groceryPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(
                  color: AppColors.groceryPrimary.withOpacity(0.4),
                  width: 1.0,
                ),
              ),
            ),
          DataCell(Center(
              child: Text(order.orderProductId != null
                  ? order.orderProductId.toString()
                  : "N/A"))),
          DataCell(Center(
            child: FutureBuilder<String>(
              future: _getImageFuture(
                  index, order.orderProduct!.product!.image!.path!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                if (snapshot.hasError) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: AppColors.groceryBorder,
                  );
                }
                return CircleAvatar(
                  backgroundColor: AppColors.groceryPrimary.withOpacity(0.05),
                  radius: 25,
                  child: Padding(
                    padding: REdgeInsets.all(4),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/gif/loading.gif",
                      image: snapshot.data!,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          const Icon(
                        Icons.broken_image,
                        color: AppColors.groceryRatingGray,
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
          _buildDataCell(order.orderProduct!.product?.title ?? 'N/A'),
          _buildDataCell(order.orderProduct!.product?.productCode ?? 'N/A'),
          _buildDataCell(
            (order.orderProduct!.product?.categories != null &&
                    order.orderProduct!.product!.categories!.isNotEmpty)
                ? order.orderProduct!.product!.categories![0].title ?? "N/A"
                : "N/A",
          ),
          _buildDataCell(order.orderProduct!.product!.unit!.name!),
          _buildDataCell(
            (order.orderProduct!.product?.colorVariant != null &&
                    order.orderProduct!.product!.colorVariant!.isNotEmpty)
                ? order.orderProduct!.product!.colorVariant![0].name ?? "N/A"
                : "N/A",
          ),
          _buildDataCell(
            (order.orderProduct!.product?.sizeVariant != null &&
                    order.orderProduct!.product!.sizeVariant!.isNotEmpty)
                ? order.orderProduct!.product!.sizeVariant![0].name ?? "N/A"
                : "N/A",
          ),
          DataCell(Center(
            child: Text(
              '${currencyController.currencySymbol}${order.orderProduct!.product?.price ?? '0.00'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: AppColors.groceryPrimary,
              ),
            ),
          )),
          _buildDataCell(order.status ?? 'N/A'),
          if (user!["user_role"] == UserRole.vendor)
            DataCell(
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                  side: BorderSide(
                    color: AppColors.groceryPrimary.withOpacity(0.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                onPressed: () {
                  if (ordersController.selectedRows.contains(true)) {
                    showDialog(
                      context: context,
                      builder: (context) => _buildAcceptAlertDialog(
                        acceptType: "Update",
                        onTap: () async {
                          Get.back();
                          await ordersController.postOrderStatusUpdate();
                        },
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "No products selected",
                      backgroundColor: AppColors.grocerySecondary,
                    );
                  }
                },
                child: const Text(
                  "Update Status",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.groceryPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      );
    }).toList();
  }

  DataCell _buildDataCell(String value) {
    return DataCell(
      Center(
        child: Text(
          value,
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }

  Widget _buildAcceptAlertDialog(
      {required String acceptType, required VoidCallback onTap}) {
    return AlertDialog(
      elevation: 0.5,
      backgroundColor: AppColors.groceryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      content: SizedBox(
        height: 120.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.groceryWarning,
              size: 80,
            ),
            SizedBox(height: 5.h),
            Text(
              textAlign: TextAlign.center,
              acceptType == "Update"
                  ? "Did you deliver this product?"
                  : "Did you deliver selected product?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomElevatedButton(
          buttonName: "Confirm",
          onPressed: onTap,
        ),
        CustomElevatedButton(
          buttonColor: AppColors.groceryRatingGray,
          buttonName: "Cancel",
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}

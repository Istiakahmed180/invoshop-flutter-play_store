import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/new_order/controller/new_order_controller.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final NewOrderController newOrderController = Get.put(NewOrderController());
  final CurrencyController currencyController = Get.put(CurrencyController());
  late Map<int, Future<String>> imageFutures;

  @override
  void initState() {
    super.initState();
    imageFutures = {};
  }

  Future<String> _getImageFuture(int index, String? imagePath) {
    return imageFutures.putIfAbsent(
        index, () => ApiPath.getImageUrl(imagePath ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "New Order"),
      body: Obx(() {
        if (newOrderController.isLoading.value) {
          return const CustomLoading(withOpacity: 0.0);
        }

        if (newOrderController.newOrderList.isEmpty) {
          return _buildNoOrdersMessage();
        }

        return RefreshIndicator(
          backgroundColor: AppColors.groceryBody,
          color: AppColors.groceryPrimary,
          onRefresh: newOrderController.getNewOrders,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 10.h),
                  _buildAcceptAllButton(),
                  SizedBox(height: 10.h),
                  _buildDataTable(),
                  SizedBox(height: 16.h),
                ],
              ),
              Obx(
                () => Visibility(
                  visible: newOrderController.isAcceptOrdersLoading.value,
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
        'No new orders available',
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
            if (newOrderController.selectedRows.contains(true)) {
              showDialog(
                context: context,
                builder: (context) => _buildAcceptAlertDialog(
                  acceptType: "Accept All",
                  onTap: () async {
                    Get.back();
                    await newOrderController.postOrderAccept();
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
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
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
              headingRowColor: MaterialStateProperty.all(
                AppColors.groceryPrimary.withOpacity(0.1),
              ),
              dataRowColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.groceryPrimary.withOpacity(0.2);
                }
                return AppColors.groceryPrimary.withOpacity(0.05);
              }),
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
      DataColumn(
        label: Checkbox(
          value: newOrderController.isHeaderChecked.value,
          onChanged: (bool? value) {
            newOrderController.toggleAllCheckboxes();
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
      _buildTableHeader("Sale Status"),
      _buildTableHeader("Action"),
    ];
  }

  DataColumn _buildTableHeader(String label) {
    return DataColumn(
      label: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.groceryPrimary,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildTableRows() {
    return newOrderController.newOrderList.asMap().entries.map((entry) {
      final int index = entry.key;
      final order = entry.value;

      // Safely access product details
      final String productName = order.product?.title ?? 'N/A';
      final String productCode = order.product?.productCode ?? 'N/A';
      final String category = (order.product?.categories?.isNotEmpty ?? false)
          ? order.product!.categories!.first.title ?? 'N/A'
          : 'N/A';
      final String unit = order.product?.unit?.name ?? 'N/A';
      final String colorVariant =
          (order.product?.colorVariant?.isNotEmpty ?? false)
              ? order.product!.colorVariant!.first.name ?? 'N/A'
              : 'N/A';
      final String sizeVariant =
          (order.product?.sizeVariant?.isNotEmpty ?? false)
              ? order.product!.sizeVariant!.first.name ?? 'N/A'
              : 'N/A';
      final String price = order.product?.price ?? '0.00';
      final String saleStatus = order.saleStatus ?? 'N/A';

      return DataRow(
        selected: newOrderController.selectedRows[index],
        onSelectChanged: (bool? value) {
          if (value != null) {
            newOrderController.selectedRows[index] = value;
            newOrderController.isHeaderChecked.value = newOrderController
                .selectedRows
                .every((isSelected) => isSelected);
          }
        },
        cells: [
          DataCell(
            Checkbox(
              value: newOrderController.selectedRows[index],
              onChanged: (bool? value) {
                newOrderController.selectedRows[index] = value ?? false;
                newOrderController.isHeaderChecked.value =
                    newOrderController.selectedRows.every((element) => element);
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
              child: Text(
                  order.orderId != null ? order.orderId.toString() : "N/A"))),
          DataCell(
            Center(
              child: FutureBuilder(
                future: _getImageFuture(index, order.product?.image?.path),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return Icon(
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
            ),
          ),
          _buildDataCell(productName),
          _buildDataCell(productCode),
          _buildDataCell(category),
          _buildDataCell(unit),
          _buildDataCell(colorVariant),
          _buildDataCell(sizeVariant),
          DataCell(
            Center(
              child: Text(
                '${currencyController.currencySymbol}$price',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: AppColors.groceryPrimary,
                ),
              ),
            ),
          ),
          _buildDataCell(saleStatus),
          DataCell(
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                side: BorderSide(
                  color: AppColors.groceryPrimary.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              onPressed: () async {
                if (newOrderController.selectedRows.contains(true)) {
                  showDialog(
                    context: context,
                    builder: (context) => _buildAcceptAlertDialog(
                      acceptType: "Accept",
                      onTap: () async {
                        Get.back();
                        await newOrderController.postOrderAccept();
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
                "Accept",
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

  Widget _buildAcceptAlertDialog({
    required String acceptType,
    required VoidCallback onTap,
  }) {
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
            Icon(
              Icons.error_outline,
              color: AppColors.groceryWarning,
              size: 80,
            ),
            SizedBox(height: 5.h),
            Text(
              textAlign: TextAlign.center,
              acceptType == "Accept"
                  ? "Can you process this order?"
                  : "Can you process selected orders?",
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

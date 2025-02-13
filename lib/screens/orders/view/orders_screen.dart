import 'package:ai_store/common/controller/orders_controller.dart';
import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersController ordersController = Get.put(OrdersController());
  late Map<int, Future<String>> imageFutures;

  @override
  void initState() {
    super.initState();
    imageFutures = {};
  }

  Future<String> _getImageFuture(int index, String imagePath) {
    return imageFutures.putIfAbsent(
        index, () => ApiPath.getImageUrl(imagePath));
  }

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: 10.h),
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
          buttonName: "Update All",
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
      _buildTableHeader("SL"),
      _buildTableHeader("Image"),
      _buildTableHeader("Name"),
      _buildTableHeader("Code"),
      _buildTableHeader("Category"),
      _buildTableHeader("Unit"),
      _buildTableHeader("Color Variant"),
      _buildTableHeader("Size Variant"),
      _buildTableHeader("Price"),
      _buildTableHeader("Status"),
      _buildTableHeader("Action"),
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
          DataCell(Center(child: Text('${index + 1}'))),
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
              '\$${order.orderProduct!.product?.price ?? '0.00'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: AppColors.groceryPrimary,
              ),
            ),
          )),
          _buildDataCell(order.status ?? 'N/A'),
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
          buttonName: "Confirm, update it!",
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

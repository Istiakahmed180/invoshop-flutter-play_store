import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/order_return/controller/order_return_controller.dart';

class OrderReturnScreen extends StatefulWidget {
  const OrderReturnScreen({super.key});

  @override
  State<OrderReturnScreen> createState() => _OrderReturnScreenState();
}

class _OrderReturnScreenState extends State<OrderReturnScreen> {
  final OrderReturnController orderReturnController =
      Get.put(OrderReturnController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Order Return"),
        body: Obx(
          () => orderReturnController.isLoading.value
              ? const CustomLoading(
                  withOpacity: 0.0,
                )
              : orderReturnController.orderReturnList.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(height: 10.h),
                        _buildDataTable(),
                        SizedBox(height: 16.h),
                      ],
                    )
                  : Center(
                      child: Text(
                        'No orders available',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.groceryPrimary.withOpacity(0.6),
                        ),
                      ),
                    ),
        ));
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
      _buildTableHeader("SL"),
      _buildTableHeader("Image"),
      _buildTableHeader("Product Name"),
      _buildTableHeader("Date"),
      _buildTableHeader("Tax Amount"),
      _buildTableHeader("Discount"),
      _buildTableHeader("Refund Amount"),
      _buildTableHeader("Amount"),
      _buildTableHeader("Status"),
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
    return orderReturnController.orderReturnList.asMap().entries.map((entry) {
      final index = entry.key;
      final review = entry.value;

      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          DataCell(CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.groceryBorder,
            child: FutureBuilder(
              future: ApiPath.getImageUrl(review.product!.image!.path!),
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

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data!,
                      placeholder: (context, url) =>
                          Image.asset("assets/gif/loading.gif"),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                );
              },
            ),
          )),
          _buildDataCell(review.product?.title ?? "N/A"),
          _buildDataCell(DateFormat("dd-MM-yyyy")
              .format(DateTime.parse(review.createdAt.toString()))),
          _buildDataCell(review.taxAmount ?? "0.00"),
          _buildDataCell(review.discount ?? "0.00"),
          _buildDataCell(review.refundAmount ?? "0.00"),
          _buildDataCell(review.amount ?? "0.00"),
          _buildDataCell(review.refund!.refundStatus ?? "N/A"),
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
}

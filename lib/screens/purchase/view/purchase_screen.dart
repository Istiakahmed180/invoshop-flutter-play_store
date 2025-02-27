import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/purchase/controller/purchase_controller.dart';
import 'package:invoshop/screens/purchase/view/create_purchase/create_purchse.dart';
import 'package:invoshop/screens/purchase/view/purchase_return/purchase_return.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  final PurchaseController purchaseController = Get.put(PurchaseController());
  final GlobalKey _fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      purchaseController.getPurchases();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Purchase"),
        body: Obx(
          () => purchaseController.isLoading.value
              ? const CustomLoading(
                  withOpacity: 0.0,
                )
              : purchaseController.purchaseList.isEmpty
                  ? Center(
                      child: Text(
                        'No reports available',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.groceryPrimary.withOpacity(0.6),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        _buildDataTable(),
                        SizedBox(
                          height: 12.h,
                        ),
                      ],
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          key: _fabKey,
          backgroundColor: AppColors.groceryPrimary,
          onPressed: () {
            final RenderBox renderBox =
                _fabKey.currentContext!.findRenderObject() as RenderBox;
            final buttonPosition = renderBox.localToGlobal(Offset.zero);
            final buttonSize = renderBox.size;
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                buttonPosition.dx,
                buttonPosition.dy - 120,
                buttonPosition.dx + buttonSize.width,
                buttonPosition.dy,
              ),
              items: [
                PopupMenuItem<String>(
                  onTap: () {
                    Get.to(CreatePurchase());
                  },
                  value: 'Create Purchase',
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        color: AppColors.groceryPrimary,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text('Create Purchase'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () {
                    Get.to(PurchaseReturn());
                  },
                  value: 'Purchase Return',
                  child: Row(
                    children: [
                      Icon(
                        Icons.assignment_return,
                        color: AppColors.groceryPrimary,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text('Purchase Return'),
                    ],
                  ),
                ),
              ],
            );
          },
          child: Icon(
            Icons.add,
            size: 30.w,
            color: AppColors.groceryWhite,
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
                  color: AppColors.groceryPrimary.withValues(alpha: 0.2),
                  width: 0.5,
                ),
                verticalInside: BorderSide(
                  color: AppColors.groceryPrimary.withValues(alpha: 0.2),
                  width: 0.5,
                ),
              ),
              headingRowColor: WidgetStateProperty.all(
                AppColors.groceryPrimary.withValues(alpha: 0.1),
              ),
              dataRowColor: WidgetStateProperty.resolveWith(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.groceryPrimary.withValues(alpha: 0.2);
                  }
                  return AppColors.groceryPrimary.withValues(alpha: 0.05);
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
      _buildTableHeader("Supplier"),
      _buildTableHeader("Warehouse"),
      _buildTableHeader("Status"),
      _buildTableHeader("Date"),
      _buildTableHeader("Grant Total"),
    ];
  }

  List<DataRow> _buildTableRows() {
    return purchaseController.purchaseList.asMap().entries.map((entry) {
      final index = entry.key;
      final purchase = entry.value;
      final supplierFullName = [
        purchase.supplier!.firstName ?? "",
        purchase.supplier!.lastName ?? ""
      ].join(" ").trim();
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(supplierFullName),
          _buildDataCell(purchase.warehouse != null
              ? purchase.warehouse!.name ?? "N/A"
              : "N/A"),
          _buildDataCell(purchase.status != null && purchase.status!.isNotEmpty
              ? purchase.status ?? "N/A"
              : "N/A"),
          _buildDataCell(
              purchase.createdAt != null && purchase.createdAt!.isNotEmpty
                  ? DateFormat("dd-MM-yyyy")
                      .format(DateTime.parse(purchase.createdAt.toString()))
                  : "N/A"),
          _buildDataCell(
            (purchase.totalAmount != null && purchase.totalAmount!.isNotEmpty
                ? purchase.totalAmount ?? "N/A"
                : "N/A"),
          ),
        ],
      );
    }).toList();
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

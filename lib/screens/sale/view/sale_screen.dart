import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/purchase/view/purchase_screen.dart';
import 'package:invoshop/screens/sale/controller/sale_controller.dart';
import 'package:invoshop/screens/sale/view/create_sale/create_sale.dart';
import 'package:invoshop/screens/sale/view/sales_return/sales_return.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final SaleController saleController = Get.put(SaleController());
  final GlobalKey _fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      saleController.getSalesReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Sales"),
        body: Obx(
          () => saleController.isLoading.value
              ? const CustomLoading(
                  withOpacity: 0.0,
                )
              : saleController.salesReportList.isEmpty
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
                    Get.to(CreateSale());
                  },
                  value: 'Create Sale',
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        color: AppColors.groceryPrimary,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text('Create Sale'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () {
                    Get.to(SalesReturn());
                  },
                  value: 'Sales Return',
                  child: Row(
                    children: [
                      Icon(
                        Icons.assignment_return,
                        color: AppColors.groceryPrimary,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text('Sales Return'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () {
                    Get.to(PurchaseScreen());
                  },
                  value: 'Purchase',
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        color: AppColors.groceryPrimary,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text('Purchase'),
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
      _buildTableHeader("Name"),
      _buildTableHeader("Code"),
      _buildTableHeader("Unit"),
      _buildTableHeader("Warehouse"),
      _buildTableHeader("StockQty"),
      _buildTableHeader("Sold Qty"),
      _buildTableHeader("Date"),
      _buildTableHeader("Sale Amount"),
    ];
  }

  List<DataRow> _buildTableRows() {
    return saleController.salesReportList.asMap().entries.map((entry) {
      final index = entry.key;
      final report = entry.value;
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(
              report.productName != null && report.productName!.isNotEmpty
                  ? report.productName ?? "N/A"
                  : "N/A"),
          _buildDataCell(
              report.productCode != null && report.productCode!.isNotEmpty
                  ? report.productCode ?? "N/A"
                  : "N/A"),
          _buildDataCell(report.unit != null && report.unit!.isNotEmpty
              ? report.unit ?? "N/A"
              : "N/A"),
          _buildDataCell(
            (report.warehouseName != null && report.warehouseName!.isNotEmpty
                ? report.warehouseName ?? "N/A"
                : "N/A"),
          ),
          _buildDataCell(report.productStock != null
              ? report.productStock.toString()
              : "N/A"),
          _buildDataCell(
              report.quantity != null ? report.quantity.toString() : "N/A"),
          _buildDataCell(report.saleDate != null && report.saleDate!.isNotEmpty
              ? report.saleDate ?? "N/A"
              : "N/A"),
          _buildDataCell(
              report.saleAmount != null && report.saleAmount!.isNotEmpty
                  ? report.saleAmount.toString()
                  : "N/A"),
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

import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/report/controller/reports_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({super.key});

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  final ReportsController reportsController = Get.put(ReportsController());

  @override
  void initState() {
    super.initState();
    reportsController.getSalesReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Sales Reports"),
      body: Obx(
        () => reportsController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : reportsController.salesReportList.isEmpty
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
    return reportsController.salesReportList.asMap().entries.map((entry) {
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

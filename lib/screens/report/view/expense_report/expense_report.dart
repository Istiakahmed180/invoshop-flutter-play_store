import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/report/controller/reports_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpenseReport extends StatefulWidget {
  const ExpenseReport({super.key});

  @override
  State<ExpenseReport> createState() => _ExpenseReportState();
}

class _ExpenseReportState extends State<ExpenseReport> {
  final ReportsController reportsController = Get.put(ReportsController());

  @override
  void initState() {
    super.initState();
    reportsController.getExpenseReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Expense Reports"),
      body: Obx(
        () => reportsController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : reportsController.expenseReportList.isEmpty
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
      _buildTableHeader("Warehouse"),
      _buildTableHeader("Category Name"),
      _buildTableHeader("Expense Type"),
      _buildTableHeader("Date"),
      _buildTableHeader("Amount"),
    ];
  }

  List<DataRow> _buildTableRows() {
    return reportsController.expenseReportList.asMap().entries.map((entry) {
      final index = entry.key;
      final report = entry.value;
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(
              report.warhouseName != null && report.warhouseName!.isNotEmpty
                  ? report.warhouseName ?? "N/A"
                  : "N/A"),
          _buildDataCell(
              report.categoryName != null && report.categoryName!.isNotEmpty
                  ? report.categoryName ?? "N/A"
                  : "N/A"),
          _buildDataCell(
            (report.expenseType != null && report.expenseType!.isNotEmpty
                ? report.expenseType.toString()
                : "N/A"),
          ),
          _buildDataCell(
              report.expenseDate != null && report.expenseDate!.isNotEmpty
                  ? report.expenseDate.toString()
                  : "N/A"),
          _buildDataCell(report.amount != null && report.amount!.isNotEmpty
              ? report.amount.toString()
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

import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/expense/controller/expense_controller.dart';
import 'package:ai_store/screens/expense/view/add_expense/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final ExpenseController controller = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Expense"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoading(withOpacity: 0.0);
        }

        if (controller.expenseList.isEmpty) {
          return _buildNoOrdersMessage();
        }

        return Column(
          children: [
            SizedBox(height: 10.h),
            _buildDataTable(),
            SizedBox(height: 16.h),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.groceryPrimary,
        onPressed: () => Get.to(const AddExpenseScreen()),
        child: Icon(
          size: 30.w,
          Icons.add,
          color: AppColors.groceryWhite,
        ),
      ),
    );
  }

  Widget _buildNoOrdersMessage() {
    return Center(
      child: Text(
        'No expenses available',
        style: TextStyle(
          fontSize: 13.sp,
          color: AppColors.groceryPrimary.withOpacity(0.6),
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
      _buildTableHeader("SL"),
      _buildTableHeader("Date"),
      _buildTableHeader("Voucher No"),
      _buildTableHeader("Warehouse"),
      _buildTableHeader("Category"),
      _buildTableHeader("Expense Type"),
      _buildTableHeader("Amount"),
      _buildTableHeader("Comment"),
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
    return controller.expenseList.asMap().entries.map((entry) {
      final index = entry.key;
      final expense = entry.value;

      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(DateFormat("dd MMM yyyy")
              .format(DateTime.parse(expense.expenseDateAt!))),
          _buildDataCell(expense.voucherNo ?? 'N/A'),
          _buildDataCell(expense.warehouse!.name ?? 'N/A'),
          _buildDataCell(
            (expense.category!.title ?? "N/A"),
          ),
          _buildDataCell(expense.expenseType ?? "N/A"),
          _buildDataCell(
            ("tk.${expense.amount ?? "0.00"}"),
          ),
          _buildDataCell(
            (expense.comment ?? "N/A"),
          ),
          DataCell(
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                side: BorderSide(
                  color: AppColors.grocerySecondary.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              onPressed: () async {
                controller.deleteExpenses(expenseId: expense.id.toString());
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.grocerySecondary,
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
}

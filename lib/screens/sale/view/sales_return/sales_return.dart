import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/sale/controller/sales_return_controller.dart';
import 'package:invoshop/screens/sale/view/create_sale_return/create_sale_return.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesReturn extends StatefulWidget {
  const SalesReturn({super.key});

  @override
  State<SalesReturn> createState() => _SalesReturnState();
}

class _SalesReturnState extends State<SalesReturn> {
  final SalesReturnController salesReturnController =
      Get.put(SalesReturnController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      salesReturnController.getSalesReturn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Sales Return"),
      body: Obx(
        () => salesReturnController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : salesReturnController.salesReturnList.isEmpty
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
        backgroundColor: AppColors.groceryPrimary,
        onPressed: () {
          Get.to(CreateSaleReturn());
        },
        child: Icon(
          Icons.add,
          color: AppColors.groceryWhite,
          size: 40,
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
      _buildTableHeader("Customer"),
      _buildTableHeader("Warehouse"),
      _buildTableHeader("Biller"),
      _buildTableHeader("Status"),
      _buildTableHeader("Amount"),
      _buildTableHeader("Remark"),
      _buildTableHeader("Date"),
      _buildTableHeader("Action"),
    ];
  }

  List<DataRow> _buildTableRows() {
    return salesReturnController.salesReturnList.asMap().entries.map((entry) {
      final index = entry.key;
      final sale = entry.value;
      final customerFullName = [
        sale.customer!.firstName ?? "",
        sale.customer!.lastName ?? ""
      ].join(" ").trim();
      final actionButtonKey = GlobalKey(debugLabel: 'action_button_$index');
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(customerFullName),
          _buildDataCell(
              sale.warehouse != null ? sale.warehouse!.name ?? "N/A" : "N/A"),
          _buildDataCell(sale.biller != null
              ? [sale.biller!.firstName ?? "", sale.biller!.lastName ?? ""]
                  .join(" ")
                  .trim()
              : "N/A"),
          _buildDataCell(
            (sale.status != null && sale.status!.isNotEmpty
                ? sale.status ?? "N/A"
                : "N/A"),
          ),
          _buildDataCell(
              sale.totalAmount != null && sale.totalAmount!.isNotEmpty
                  ? sale.totalAmount.toString()
                  : "N/A"),
          _buildDataCell(sale.remark != null && sale.remark!.isNotEmpty
              ? sale.remark.toString()
              : "N/A"),
          _buildDataCell(sale.createdAt != null && sale.createdAt!.isNotEmpty
              ? DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(sale.createdAt.toString()))
              : "N/A"),
          DataCell(
            OutlinedButton(
              key: actionButtonKey,
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
                final RenderBox renderBox = actionButtonKey.currentContext!
                    .findRenderObject() as RenderBox;
                final buttonPosition = renderBox.localToGlobal(Offset.zero);
                final buttonSize = renderBox.size;
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    buttonPosition.dx,
                    buttonPosition.dy + buttonSize.height,
                    buttonPosition.dx + buttonSize.width,
                    buttonPosition.dy + buttonSize.height + 100,
                  ),
                  items: [
                    PopupMenuItem<String>(
                      onTap: () {
                        salesReturnController.deleteSalesReturn(
                            saleId: sale.id.toString());
                      },
                      value: 'Delete',
                      child: const Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: AppColors.grocerySecondary,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                );
              },
              child: const Text(
                "Action",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.groceryPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
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

import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/supplier/controller/supplier_controller.dart';
import 'package:invoshop/screens/supplier/view/add_supplier/add_supplier.dart';
import 'package:invoshop/screens/supplier/view/edit_supplier/edit_supplier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  final SupplierController supplierController = Get.put(SupplierController());

  @override
  void initState() {
    super.initState();
    supplierController.getSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Suppliers"),
        body: Obx(
          () => supplierController.isLoading.value
              ? const CustomLoading(
                  withOpacity: 0.0,
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
            Get.to(AddSupplier());
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
      _buildTableHeader("Supplier Code"),
      _buildTableHeader("Supplier Key"),
      _buildTableHeader("Phone"),
      _buildTableHeader("Company"),
      _buildTableHeader("Email"),
      _buildTableHeader("Address"),
      _buildTableHeader("Action"),
    ];
  }

  List<DataRow> _buildTableRows() {
    return supplierController.supplierList.asMap().entries.map((entry) {
      final index = entry.key;
      final supplier = entry.value;
      final userFullName =
          [supplier.firstName ?? "", supplier.lastName ?? ""].join(" ").trim();
      final actionButtonKey = GlobalKey(debugLabel: 'action_button_$index');
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(userFullName),
          _buildDataCell(
              supplier.supplierCode != null && supplier.supplierCode!.isNotEmpty
                  ? supplier.supplierCode ?? "N/A"
                  : "N/A"),
          _buildDataCell(
              supplier.supplierKey != null && supplier.supplierKey!.isNotEmpty
                  ? supplier.supplierKey ?? "N/A"
                  : "N/A"),
          _buildDataCell(
            (supplier.phone != null && supplier.phone!.isNotEmpty
                ? supplier.phone ?? "N/A"
                : "N/A"),
          ),
          _buildDataCell(supplier.company != null
              ? supplier.company!.companyName ?? "N/A"
              : "N/A"),
          _buildDataCell(supplier.email != null && supplier.email!.isNotEmpty
              ? supplier.email ?? "N/A"
              : "N/A"),
          _buildDataCell(
              supplier.address != null && supplier.address!.isNotEmpty
                  ? supplier.address ?? "N/A"
                  : "N/A"),
          DataCell(
            OutlinedButton(
              key: actionButtonKey,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                side: BorderSide(
                  color: AppColors.groceryPrimary.withValues(alpha: 0.5),
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
                        Get.to(EditSupplier(
                          supplier: supplier,
                        ));
                      },
                      value: 'Edit',
                      child: const Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: AppColors.groceryPrimary,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      onTap: () {
                        supplierController.deleteSupplier(
                            supplierId: supplier.id.toString());
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

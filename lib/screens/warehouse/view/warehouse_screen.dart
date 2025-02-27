import 'package:invoshop/common/controller/warehouse_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/warehouse/view/add_warehouse/add_warehouse.dart';
import 'package:invoshop/screens/warehouse/view/edit_warehouse/edit_warehouse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({super.key});

  @override
  State<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  final WarehouseController warehouseController =
      Get.put(WarehouseController());

  @override
  void initState() {
    super.initState();
    warehouseController.loadWarehouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Warehouses"),
        body: Obx(
          () => warehouseController.isLoading.value
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
            Get.to(AddWarehouse());
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
      _buildTableHeader("Warehouse"),
      _buildTableHeader("Phone"),
      _buildTableHeader("Email"),
      _buildTableHeader("Address"),
      _buildTableHeader("Action"),
    ];
  }

  List<DataRow> _buildTableRows() {
    return warehouseController.warehouseList.asMap().entries.map((entry) {
      final index = entry.key;
      final warehouse = entry.value;
      final actionButtonKey = GlobalKey(debugLabel: 'action_button_$index');
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(warehouse.name != null && warehouse.name!.isNotEmpty
              ? warehouse.name ?? "N/A"
              : "N/A"),
          _buildDataCell(
            (warehouse.phone != null && warehouse.phone!.isNotEmpty
                ? warehouse.phone ?? "N/A"
                : "N/A"),
          ),
          _buildDataCell(warehouse.email != null && warehouse.email!.isNotEmpty
              ? warehouse.email ?? "N/A"
              : "N/A"),
          _buildDataCell(
              warehouse.address != null && warehouse.address!.isNotEmpty
                  ? warehouse.address ?? "N/A"
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
                        Get.to(EditWarehouse(warehouse: warehouse));
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
                        warehouseController.deleteWarehouse(
                            warehouseId: warehouse.id.toString());
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

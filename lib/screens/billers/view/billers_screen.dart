import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/billers/controller/billers_controller.dart';
import 'package:invoshop/screens/billers/view/add_biller/add_biller.dart';
import 'package:invoshop/screens/billers/view/edit_biller/edit_biller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BillersScreen extends StatefulWidget {
  const BillersScreen({super.key});

  @override
  State<BillersScreen> createState() => _BillersScreenState();
}

class _BillersScreenState extends State<BillersScreen> {
  final BillersController billersController = Get.put(BillersController());

  @override
  void initState() {
    super.initState();
    billersController.getBillers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Billers"),
        body: Obx(
          () => billersController.isLoading.value
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
            Get.to(AddBiller());
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
      _buildTableHeader("Phone"),
      _buildTableHeader("Email"),
      _buildTableHeader("Biller Code"),
      _buildTableHeader("Address"),
      _buildTableHeader("Action"),
    ];
  }

  List<DataRow> _buildTableRows() {
    return billersController.billersList.asMap().entries.map((entry) {
      final index = entry.key;
      final biller = entry.value;
      final userFullName =
          [biller.firstName ?? "", biller.lastName ?? ""].join(" ").trim();
      final actionButtonKey = GlobalKey(debugLabel: 'action_button_$index');
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(userFullName),
          _buildDataCell(biller.phone != null && biller.phone!.isNotEmpty
              ? biller.phone ?? "N/A"
              : "N/A"),
          _buildDataCell(biller.email != null && biller.email!.isNotEmpty
              ? biller.email ?? "N/A"
              : "N/A"),
          _buildDataCell(
            (biller.billerCode != null && biller.billerCode!.isNotEmpty
                ? biller.billerCode ?? "N/A"
                : "N/A"),
          ),
          _buildDataCell(biller.address != null && biller.address!.isNotEmpty
              ? biller.address ?? "N/A"
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
                        Get.to(EditBiller(biller: biller));
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
                        billersController.deleteBiller(
                            billerId: biller.id.toString());
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

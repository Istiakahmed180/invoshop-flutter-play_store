import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_outline_button.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/controller/unit_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UnitManagement extends StatefulWidget {
  const UnitManagement({super.key});

  @override
  State<UnitManagement> createState() => _UnitManagement();
}

class _UnitManagement extends State<UnitManagement> {
  final UnitManagementController unitManagementController =
      Get.put(UnitManagementController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    unitManagementController.getUnits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Units"),
        body: Obx(
          () => unitManagementController.isLoading.value
              ? const CustomLoading(
                  withOpacity: 0.0,
                )
              : Stack(
                  children: [
                    Padding(
                      padding: REdgeInsets.all(12),
                      child: Column(
                        children: [
                          _buildDataTable(),
                        ],
                      ),
                    ),
                    Obx(
                      () => Visibility(
                          visible:
                              unitManagementController.isUnitsLoading.value,
                          child: const CustomLoading()),
                    )
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.groceryPrimary,
          onPressed: () {
            _buildBottomSheetWidget();
          },
          child: Icon(
            Icons.add,
            size: 30.w,
            color: AppColors.groceryWhite,
          ),
        ));
  }

  Widget _buildDataTable() {
    return Center(
      child: SizedBox(
        width: double.infinity,
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
    );
  }

  List<DataColumn> _buildTableColumns() {
    return [
      _buildTableHeader("SL"),
      _buildTableHeader("Name"),
      _buildTableHeader("Short Name"),
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
    return unitManagementController.unitList.asMap().entries.map((entry) {
      final index = entry.key;
      final unit = entry.value;
      final actionButtonKey = GlobalKey(debugLabel: 'action_button_$index');
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(
            (unit.name != null ? unit.name ?? "N/A" : "N/A"),
          ),
          _buildDataCell(
            (unit.unitType != null ? unit.unitType ?? "N/A" : "N/A"),
          ),
          DataCell(
            Center(
              child: OutlinedButton(
                key: actionButtonKey,
                style: OutlinedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
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
                          unitManagementController.editUnitNameController.text =
                              unit.name ?? "";
                          unitManagementController.editUnitShortNameController
                              .text = unit.unitType ?? "";
                          _buildEditBottomSheetWidget(
                              unitId: unit.id.toString());
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
                          unitManagementController.deleteUnit(
                              unitId: unit.id.toString());
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

  void _buildBottomSheetWidget() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: AppColors.groceryBodyTwo,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: REdgeInsets.all(12),
                child: Text(
                  "Create Unit",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomLabelText(
                          text: "Name",
                          isRequired: true,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Unit name is required";
                            }
                            return null;
                          },
                          controller:
                              unitManagementController.addUnitNameController,
                          decoration:
                              const InputDecoration(hintText: "Kilogram"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomLabelText(
                          text: "Short Name",
                          isRequired: true,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Unit short name is required";
                            }
                            return null;
                          },
                          controller: unitManagementController
                              .addUnitShortNameController,
                          decoration: const InputDecoration(hintText: "Kg"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomOutlinedButton(
                            buttonText: "Reset",
                            onPressed: () {
                              unitManagementController.createResetFields();
                            }),
                        CustomElevatedButton(
                          buttonName: "Create",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              unitManagementController.postCreateUnit();
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _buildEditBottomSheetWidget({required String unitId}) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: AppColors.groceryBodyTwo,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: REdgeInsets.all(12),
                child: Text(
                  "Update Unit",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLabelText(
                        text: "Name",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller:
                            unitManagementController.editUnitNameController,
                        decoration: InputDecoration(hintText: "Kilogram"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLabelText(
                        text: "Short Name",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: unitManagementController
                            .editUnitShortNameController,
                        decoration: InputDecoration(hintText: "Kg"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomOutlinedButton(
                          buttonText: "Reset",
                          onPressed: () {
                            unitManagementController.editResetFields();
                          }),
                      CustomElevatedButton(
                        buttonName: "Update",
                        onPressed: () {
                          unitManagementController.postUnitUpdate(
                              unitId: unitId);
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

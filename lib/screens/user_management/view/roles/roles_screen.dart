import 'package:invoshop/common/controller/user_role_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_outline_button.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/user_management/controller/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({super.key});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  final UserRoleController userRoleController = Get.put(UserRoleController());
  final RolesController rolesController = Get.put(RolesController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userRoleController.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Roles"),
        body: Obx(
          () => userRoleController.isLoading.value
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
                          visible: rolesController.isRoleLoading.value,
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
      _buildTableHeader("Role"),
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
    return userRoleController.rolesList.asMap().entries.map((entry) {
      final index = entry.key;
      final role = entry.value;
      final actionButtonKey = GlobalKey(debugLabel: 'action_button_$index');
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(
            (role.title ?? "N/A"),
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
                          rolesController.editRoleNameController.text =
                              role.title ?? "";
                          rolesController.roleId.value = role.id ?? 0;
                          _buildEditBottomSheetWidget();
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
                          rolesController.deleteRole(
                              roleId: role.id.toString());
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
                  "Add Role",
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
                              return "Role name is required";
                            }
                            return null;
                          },
                          controller: rolesController.roleNameController,
                          decoration: const InputDecoration(hintText: "Admin"),
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
                              rolesController.resetFields();
                            }),
                        CustomElevatedButton(
                          buttonName: "Create",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              rolesController.postRoleCreate();
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

  void _buildEditBottomSheetWidget() {
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
                  "Edit Role",
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
                        controller: rolesController.editRoleNameController,
                        decoration: const InputDecoration(hintText: "Admin"),
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
                            rolesController.resetEditFields();
                          }),
                      CustomElevatedButton(
                        buttonName: "Update",
                        onPressed: () {
                          rolesController.postRoleUpdate(
                              roleId: rolesController.roleId.toString());
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

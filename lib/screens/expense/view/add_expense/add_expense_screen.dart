import 'package:invoshop/common/controller/categories_controller.dart';
import 'package:invoshop/common/controller/warehouse_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_outline_button.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/date_picker/custom_date_picker.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/screens/expense/controller/add_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final AddExpenseController controller = Get.put(AddExpenseController());
  final WarehouseController warehouseController =
      Get.put(WarehouseController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await warehouseController.getWarehouse();
    await categoriesController.getCategories();
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Add Expense"),
      body: Stack(
        children: [
          Obx(
            () => controller.isLoading.value
                ? const CustomLoading(
                    withOpacity: 0.0,
                  )
                : Padding(
                    padding: REdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "Date",
                                  isRequired: true,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                CustomDatePicker(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Date is required";
                                    }
                                    return null;
                                  },
                                  hintText: "Select Date",
                                  initialDate: controller.selectedDate.value,
                                  onDateSelected: (DateTime date) {
                                    controller.selectedDate.value = date;
                                  },
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
                                  text: "Warehouse",
                                  isRequired: true,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Obx(
                                  () => CustomDropdownField(
                                    validatorText: "Warehouse",
                                    hintText: "Select Warehouse",
                                    dropdownItems: warehouseController
                                            .warehouseList.isEmpty
                                        ? ["Not Found"]
                                        : warehouseController.warehouseList
                                            .map((item) => item.name as String)
                                            .toList(),
                                    onChanged: (value) {
                                      controller.warehouseId.value =
                                          warehouseController.warehouseList
                                                  .firstWhere((item) =>
                                                      item.name == value)
                                                  .id ??
                                              0;
                                    },
                                  ),
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
                                  text: "Expense Type",
                                  isRequired: true,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                CustomDropdownField(
                                  validatorText: "Expense type",
                                  hintText: "Select Expense",
                                  dropdownItems: const ["Direct", "Indirect"],
                                  onChanged: (value) {
                                    controller.expenseType.value = value ?? "";
                                  },
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
                                  text: "Category",
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Obx(
                                  () => CustomDropdownField(
                                    hintText: "Select Category",
                                    dropdownItems: categoriesController
                                            .categoriesList.isEmpty
                                        ? ["Not Found"]
                                        : categoriesController.categoriesList
                                            .map((item) => item.title as String)
                                            .toList(),
                                    onChanged: (value) {
                                      controller.categoryId.value =
                                          categoriesController.categoriesList
                                                  .firstWhere((item) =>
                                                      item.title == value)
                                                  .id ??
                                              0;
                                    },
                                  ),
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
                                  text: "Voucher No",
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.voucherController,
                                  decoration:
                                      const InputDecoration(hintText: "748"),
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
                                  text: "Amount",
                                  isRequired: true,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Amount required field";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: controller.amountController,
                                  decoration:
                                      const InputDecoration(hintText: "0"),
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
                                  text: "Expense Note",
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  maxLines: 3,
                                  keyboardType: TextInputType.text,
                                  controller: controller.expenseNoteController,
                                  decoration: const InputDecoration(
                                      hintText: "Type text..."),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomOutlinedButton(
                                    buttonText: "Reset",
                                    onPressed: () => controller.resetFields()),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomElevatedButton(
                                  buttonName: "Create Now",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.postExpense();
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          Obx(
            () => Visibility(
                visible: controller.isExpenseLoading.value,
                child: const CustomLoading()),
          )
        ],
      ),
    );
  }
}

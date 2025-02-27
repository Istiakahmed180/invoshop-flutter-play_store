import 'package:invoshop/common/controller/countries_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_outline_button.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/screens/warehouse/controller/add_warehouse_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddWarehouse extends StatefulWidget {
  const AddWarehouse({super.key});

  @override
  State<AddWarehouse> createState() => _AddWarehouseState();
}

class _AddWarehouseState extends State<AddWarehouse> {
  final AddWarehouseController addWarehouseController =
      Get.put(AddWarehouseController());
  final CountriesController countriesController =
      Get.put(CountriesController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    addWarehouseController.isLoading.value = true;
    await countriesController.getCountries();
    addWarehouseController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarName: "Create Warehouse"),
      body: Obx(
        () => addWarehouseController.isLoading.value
            ? CustomLoading(withOpacity: 0.0)
            : Padding(
                padding: REdgeInsets.all(12),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTextField(
                          label: "Name",
                          isRequired: true,
                          controller:
                              addWarehouseController.warehouseNameController,
                          hintText: "Warehouse 1",
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                        ),
                        _buildTextField(
                          label: "Phone",
                          isRequired: true,
                          controller: addWarehouseController.phoneController,
                          hintText: "00 000 000 000",
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone is required";
                            }
                            return null;
                          },
                        ),
                        _buildTextField(
                          label: "Email",
                          isRequired: true,
                          controller: addWarehouseController.emailController,
                          hintText: "info@gmail.com",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                        ),
                        _buildDropdown(
                            label: "Country",
                            isRequired: true,
                            hintText: "Select Country",
                            items: countriesController.countriesList.isEmpty
                                ? ["Not Found"]
                                : countriesController.countriesList
                                    .map((item) => item.title as String)
                                    .toList(),
                            onChanged: (value) {
                              addWarehouseController.countryId
                                  .value = countriesController.countriesList
                                      .firstWhere((item) => item.title == value)
                                      .id ??
                                  0;
                            },
                            validateText: "Country"),
                        _buildTextField(
                            label: "City",
                            isRequired: true,
                            controller: addWarehouseController.cityController,
                            hintText: "New York",
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "City is required";
                              }
                              return null;
                            }),
                        _buildTextField(
                          label: "Zip Code",
                          controller: addWarehouseController.zipCodeController,
                          hintText: "Code",
                          keyboardType: TextInputType.text,
                        ),
                        _buildTextField(
                          label: "Description",
                          maxLines: 3,
                          controller:
                              addWarehouseController.descriptionController,
                          hintText: "Type text...",
                          keyboardType: TextInputType.text,
                        ),
                        _buildTextField(
                          label: "Address",
                          maxLines: 3,
                          controller: addWarehouseController.addressController,
                          hintText: "Malmate Station, New York, USA",
                          keyboardType: TextInputType.streetAddress,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomOutlinedButton(
                              buttonText: "Reset",
                              onPressed: () {
                                addWarehouseController.resetFields();
                              },
                            ),
                            CustomElevatedButton(
                              buttonName: "Create Now",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  addWarehouseController.postAddWarehouse();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    bool isRequired = false,
    TextEditingController? controller,
    String? hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabelText(text: label, isRequired: isRequired),
        SizedBox(height: 5.h),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hintText),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    String? validateText,
    bool isRequired = false,
    required String hintText,
    List<String> items = const [],
    Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabelText(text: label, isRequired: isRequired),
        SizedBox(height: 5.h),
        CustomDropdownField(
          validatorText: validateText,
          hintText: hintText,
          dropdownItems: items,
          onChanged: onChanged,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}

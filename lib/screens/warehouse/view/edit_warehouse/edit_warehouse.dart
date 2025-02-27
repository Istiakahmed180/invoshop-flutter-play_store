import 'package:invoshop/common/controller/countries_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/model/warehouse_model.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/screens/warehouse/controller/edit_warehouse_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditWarehouse extends StatefulWidget {
  final WarehouseData warehouse;

  const EditWarehouse({super.key, required this.warehouse});

  @override
  State<EditWarehouse> createState() => _EditWarehouseState();
}

class _EditWarehouseState extends State<EditWarehouse> {
  final EditWarehouseController editWarehouseController =
      Get.put(EditWarehouseController());
  final CountriesController countriesController =
      Get.put(CountriesController());

  @override
  void initState() {
    super.initState();
    editWarehouseController.warehouseNameController.text =
        widget.warehouse.name ?? "";
    editWarehouseController.phoneController.text = widget.warehouse.phone ?? "";
    editWarehouseController.emailController.text = widget.warehouse.email ?? "";
    editWarehouseController.countryId.value = widget.warehouse.countryId ?? 0;
    editWarehouseController.cityController.text = widget.warehouse.city ?? "";
    editWarehouseController.zipCodeController.text =
        widget.warehouse.zipCode ?? "";
    editWarehouseController.descriptionController.text =
        widget.warehouse.description ?? "";
    editWarehouseController.addressController.text =
        widget.warehouse.address ?? "";
    loadData();
  }

  Future<void> loadData() async {
    editWarehouseController.isLoading.value = true;
    await countriesController.getCountries();
    editWarehouseController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarName: "Update Warehouse"),
      body: Obx(
        () => editWarehouseController.isLoading.value
            ? CustomLoading(withOpacity: 0.0)
            : Padding(
                padding: REdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextField(
                        label: "Name",
                        controller:
                            editWarehouseController.warehouseNameController,
                        hintText: "Warehouse 1",
                        keyboardType: TextInputType.text,
                      ),
                      _buildTextField(
                        label: "Phone",
                        controller: editWarehouseController.phoneController,
                        hintText: "00 000 000 000",
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        label: "Email",
                        controller: editWarehouseController.emailController,
                        hintText: "info@gmail.com",
                      ),
                      _buildDropdown(
                        label: "Country",
                        hintText: "Select Country",
                        items: countriesController.countriesList.isEmpty
                            ? ["Not Found"]
                            : countriesController.countriesList
                                .map((item) => item.title as String)
                                .toList(),
                        onChanged: (value) {
                          editWarehouseController.countryId.value =
                              countriesController.countriesList
                                      .firstWhere((item) => item.title == value)
                                      .id ??
                                  0;
                        },
                      ),
                      _buildTextField(
                        label: "City",
                        controller: editWarehouseController.cityController,
                        hintText: "New York",
                        keyboardType: TextInputType.text,
                      ),
                      _buildTextField(
                        label: "Zip Code",
                        controller: editWarehouseController.zipCodeController,
                        hintText: "Code",
                        keyboardType: TextInputType.text,
                      ),
                      _buildTextField(
                        label: "Description",
                        maxLines: 3,
                        controller:
                            editWarehouseController.descriptionController,
                        hintText: "Type text...",
                        keyboardType: TextInputType.text,
                      ),
                      _buildTextField(
                        label: "Address",
                        maxLines: 3,
                        controller: editWarehouseController.addressController,
                        hintText: "Malmate Station, New York, USA",
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomElevatedButton(
                          buttonName: "Update Now",
                          onPressed: () {
                            editWarehouseController.postUpdateWarehouse(
                                warehouseId: widget.warehouse.id.toString());
                          },
                        ),
                      ),
                    ],
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

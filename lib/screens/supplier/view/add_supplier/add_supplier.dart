import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_outline_button.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/screens/supplier/controller/create_supplier_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddSupplier extends StatefulWidget {
  const AddSupplier({super.key});

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  final CreateSupplierController createSupplierController =
      Get.put(CreateSupplierController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    createSupplierController.getCountries();
    createSupplierController.getCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarName: "Create Supplier"),
      body: Obx(
        () => createSupplierController.isLoading.value
            ? CustomLoading(withOpacity: 0.0)
            : Padding(
                padding: REdgeInsets.all(12),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTextField(
                          label: "First Name",
                          isRequired: true,
                          controller:
                              createSupplierController.firstNameController,
                          hintText: "Joseph",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "First name is required";
                            }
                            return null;
                          },
                        ),
                        _buildTextField(
                          label: "Last Name",
                          controller:
                              createSupplierController.lastNameController,
                          hintText: "Tylor",
                          keyboardType: TextInputType.name,
                        ),
                        _buildTextField(
                          label: "Email",
                          isRequired: true,
                          controller: createSupplierController.emailController,
                          hintText: "joseph@gmail.com",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                        ),
                        _buildTextField(
                          label: "Phone",
                          isRequired: true,
                          controller: createSupplierController.phoneController,
                          hintText: "00 000 000 000",
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone is required";
                            }
                            return null;
                          },
                        ),
                        _buildDropdown(
                          label: "Country",
                          hintText: "Select Country",
                          items: createSupplierController.countriesList.isEmpty
                              ? ["Not Found"]
                              : createSupplierController.countriesList
                                  .map((item) => item.title as String)
                                  .toList(),
                          onChanged: (value) {
                            createSupplierController.countryId
                                .value = createSupplierController.countriesList
                                    .firstWhere((item) => item.title == value)
                                    .id ??
                                0;
                          },
                        ),
                        _buildTextField(
                          label: "City",
                          controller: createSupplierController.cityController,
                          hintText: "Enter City",
                          keyboardType: TextInputType.text,
                        ),
                        _buildTextField(
                          label: "Supplier Code",
                          controller:
                              createSupplierController.supplierCodeController,
                          hintText: "Code",
                          keyboardType: TextInputType.text,
                        ),
                        _buildTextField(
                          label: "Zip Code",
                          controller:
                              createSupplierController.zipCodeController,
                          hintText: "Code",
                          keyboardType: TextInputType.text,
                        ),
                        _buildDropdown(
                            label: "Company",
                            hintText: "Select Company",
                            items: createSupplierController.companyList.isEmpty
                                ? ["Not Found"]
                                : createSupplierController.companyList
                                    .map((item) => item.title as String)
                                    .toList(),
                            onChanged: (value) {
                              createSupplierController.companyId
                                  .value = createSupplierController.companyList
                                      .firstWhere((item) => item.title == value)
                                      .id ??
                                  0;
                            }),
                        _buildTextField(
                          label: "Address",
                          maxLines: 3,
                          controller:
                              createSupplierController.addressController,
                          hintText: "Malmate Station",
                          keyboardType: TextInputType.streetAddress,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomOutlinedButton(
                              buttonText: "Reset",
                              onPressed: () {
                                createSupplierController.resetFields();
                              },
                            ),
                            CustomElevatedButton(
                              buttonName: "Create Now",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  createSupplierController.postSupplierCreate();
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
    required String hintText,
    List<String> items = const [],
    Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabelText(text: label),
        SizedBox(height: 5.h),
        CustomDropdownField(
          hintText: hintText,
          dropdownItems: items,
          onChanged: onChanged,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}

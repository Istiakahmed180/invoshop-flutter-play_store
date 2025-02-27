import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/screens/supplier/controller/edit_supplier_controller.dart';
import 'package:invoshop/screens/supplier/model/suppliers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditSupplier extends StatefulWidget {
  final SuppliersData supplier;

  const EditSupplier({super.key, required this.supplier});

  @override
  State<EditSupplier> createState() => EditSupplierState();
}

class EditSupplierState extends State<EditSupplier> {
  final EditSupplierController editSupplierController =
      Get.put(EditSupplierController());

  @override
  void initState() {
    super.initState();
    editSupplierController.firstNameController.text =
        widget.supplier.firstName ?? "";
    editSupplierController.lastNameController.text =
        widget.supplier.lastName ?? "";
    editSupplierController.emailController.text = widget.supplier.email ?? "";
    editSupplierController.phoneController.text = widget.supplier.phone ?? "";
    editSupplierController.countryId.value = widget.supplier.countryId ?? 0;
    editSupplierController.cityController.text = widget.supplier.city ?? "";
    editSupplierController.supplierCodeController.text =
        widget.supplier.supplierCode ?? "";
    editSupplierController.zipCodeController.text =
        widget.supplier.zipCode ?? "";
    editSupplierController.zipCodeController.text =
        widget.supplier.zipCode ?? "";
    editSupplierController.companyId.value = widget.supplier.companyId ?? 0;
    editSupplierController.addressController.text =
        widget.supplier.address ?? "";
    editSupplierController.getCountries();
    editSupplierController.getCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarName: "Update Supplier"),
      body: Obx(
        () => editSupplierController.isLoading.value
            ? CustomLoading(withOpacity: 0.0)
            : Padding(
                padding: REdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextField(
                        label: "First Name",
                        controller: editSupplierController.firstNameController,
                        hintText: "Joseph",
                        keyboardType: TextInputType.name,
                      ),
                      _buildTextField(
                        label: "Last Name",
                        controller: editSupplierController.lastNameController,
                        hintText: "Tylor",
                        keyboardType: TextInputType.name,
                      ),
                      _buildTextField(
                        label: "Email",
                        controller: editSupplierController.emailController,
                        hintText: "joseph@gmail.com",
                      ),
                      _buildTextField(
                        label: "Phone",
                        controller: editSupplierController.phoneController,
                        hintText: "00 000 000 000",
                        keyboardType: TextInputType.phone,
                      ),
                      _buildDropdown(
                        label: "Country",
                        hintText: "Select Country",
                        items: editSupplierController.countriesList.isEmpty
                            ? ["Not Found"]
                            : editSupplierController.countriesList
                                .map((item) => item.title as String)
                                .toList(),
                        onChanged: (value) {
                          editSupplierController.countryId.value =
                              editSupplierController.countriesList
                                      .firstWhere((item) => item.title == value)
                                      .id ??
                                  0;
                        },
                      ),
                      _buildTextField(
                        label: "City",
                        controller: editSupplierController.cityController,
                        hintText: "Enter City",
                        keyboardType: TextInputType.text,
                      ),
                      _buildTextField(
                        label: "Supplier Code",
                        controller:
                            editSupplierController.supplierCodeController,
                        hintText: "Code",
                        keyboardType: TextInputType.text,
                      ),
                      _buildTextField(
                        label: "Zip Code",
                        controller: editSupplierController.zipCodeController,
                        hintText: "Code",
                        keyboardType: TextInputType.text,
                      ),
                      _buildDropdown(
                          label: "Company",
                          hintText: "Select Company",
                          items: editSupplierController.companyList.isEmpty
                              ? ["Not Found"]
                              : editSupplierController.companyList
                                  .map((item) => item.title as String)
                                  .toList(),
                          onChanged: (value) {
                            editSupplierController.companyId
                                .value = editSupplierController.companyList
                                    .firstWhere((item) => item.title == value)
                                    .id ??
                                0;
                          }),
                      _buildTextField(
                        label: "Address",
                        maxLines: 3,
                        controller: editSupplierController.addressController,
                        hintText: "Malmate Station",
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomElevatedButton(
                          buttonName: "Update Now",
                          onPressed: () {
                            editSupplierController.postSupplierUpdate(
                                supplierId: widget.supplier.id.toString());
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

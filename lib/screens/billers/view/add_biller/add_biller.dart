import 'package:invoshop/common/controller/countries_controller.dart';
import 'package:invoshop/common/controller/warehouse_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_outline_button.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/date_picker/custom_date_picker.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/screens/billers/controller/create_billers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddBiller extends StatefulWidget {
  const AddBiller({super.key});

  @override
  State<AddBiller> createState() => _AddBiller();
}

class _AddBiller extends State<AddBiller> {
  final CreateBillersController createBillersController =
      Get.put(CreateBillersController());
  final WarehouseController warehouseController =
      Get.put(WarehouseController());
  final CountriesController countriesController =
      Get.put(CountriesController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    createBillersController.isLoading.value = true;
    await warehouseController.getWarehouse();
    await countriesController.getCountries();
    createBillersController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarName: "Create Biller"),
      body: Obx(
        () => createBillersController.isLoading.value
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
                              createBillersController.firstNameController,
                          hintText: "William",
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
                              createBillersController.lastNameController,
                          hintText: "Tylor",
                          keyboardType: TextInputType.name,
                        ),
                        _buildTextField(
                          label: "Phone",
                          isRequired: true,
                          controller: createBillersController.phoneController,
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
                          controller: createBillersController.emailController,
                          hintText: "joseph@gmail.com",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabelText(text: "Date of Join"),
                            SizedBox(
                              height: 5.h,
                            ),
                            CustomDatePicker(
                              hintText: "Select Date",
                              initialDate:
                                  createBillersController.selectedDate.value,
                              onDateSelected: (DateTime date) {
                                createBillersController.selectedDate.value =
                                    date;
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildDropdown(
                          label: "Warehouse",
                          hintText: "Select Warehouse",
                          items: warehouseController.warehouseList.isEmpty
                              ? ["Not Found"]
                              : warehouseController.warehouseList
                                  .map((item) => item.name as String)
                                  .toList(),
                          onChanged: (value) {
                            createBillersController.warehouseId
                                .value = warehouseController.warehouseList
                                    .firstWhere((item) => item.name == value)
                                    .id ??
                                0;
                          },
                        ),
                        _buildTextField(
                          label: "NID or Passport Number",
                          controller: createBillersController
                              .nidPassportNumberController,
                          hintText: "00000000000000",
                          keyboardType: TextInputType.number,
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
                            createBillersController.countryId
                                .value = countriesController.countriesList
                                    .firstWhere((item) => item.title == value)
                                    .id ??
                                0;
                          },
                        ),
                        _buildTextField(
                          label: "City",
                          controller: createBillersController.cityController,
                          hintText: "Enter City",
                          keyboardType: TextInputType.text,
                        ),
                        _buildTextField(
                          label: "Zip Code",
                          controller: createBillersController.zipCodeController,
                          hintText: "Code",
                          keyboardType: TextInputType.text,
                        ),
                        _buildTextField(
                          label: "Biller Code",
                          controller:
                              createBillersController.billerCodeController,
                          hintText: "BW-00570",
                          keyboardType: TextInputType.text,
                        ),
                        _buildTextField(
                          label: "Address",
                          maxLines: 3,
                          controller: createBillersController.addressController,
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
                                createBillersController.resetFields();
                              },
                            ),
                            CustomElevatedButton(
                              buttonName: "Create Now",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  createBillersController.postBillerCreate();
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

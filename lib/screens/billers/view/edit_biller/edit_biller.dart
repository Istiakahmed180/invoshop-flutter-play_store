import 'package:invoshop/common/controller/countries_controller.dart';
import 'package:invoshop/common/controller/warehouse_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/date_picker/custom_date_picker.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/screens/billers/controller/edit_biller_controller.dart';
import 'package:invoshop/screens/billers/model/billers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditBiller extends StatefulWidget {
  final BillersData biller;

  const EditBiller({super.key, required this.biller});

  @override
  State<EditBiller> createState() => _EditBiller();
}

class _EditBiller extends State<EditBiller> {
  final EditBillerController editBillerController =
      Get.put(EditBillerController());
  final WarehouseController warehouseController =
      Get.put(WarehouseController());
  final CountriesController countriesController =
      Get.put(CountriesController());

  @override
  void initState() {
    super.initState();
    editBillerController.firstNameController.text =
        widget.biller.firstName ?? "";
    editBillerController.lastNameController.text = widget.biller.lastName ?? "";
    editBillerController.phoneController.text = widget.biller.phone ?? "";
    editBillerController.emailController.text = widget.biller.email ?? "";
    editBillerController.selectedDate.value =
        DateTime.parse(widget.biller.dateOfJoin!);
    editBillerController.warehouseId.value = widget.biller.warehouseId ?? 0;
    editBillerController.nidPassportNumberController.text =
        widget.biller.nidPassportNumber ?? "";
    editBillerController.countryId.value = widget.biller.countryId ?? 0;
    editBillerController.cityController.text = widget.biller.city ?? "";
    editBillerController.zipCodeController.text = widget.biller.zipCode ?? "";
    editBillerController.billerCodeController.text =
        widget.biller.billerCode ?? "";
    editBillerController.addressController.text = widget.biller.address ?? "";
    loadData();
  }

  Future<void> loadData() async {
    editBillerController.isLoading.value = true;
    await warehouseController.getWarehouse();
    await countriesController.getCountries();
    editBillerController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarName: "Update Biller"),
      body: Obx(
        () => editBillerController.isLoading.value
            ? CustomLoading(withOpacity: 0.0)
            : Padding(
                padding: REdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextField(
                        label: "First Name",
                        controller: editBillerController.firstNameController,
                        hintText: "William",
                        keyboardType: TextInputType.name,
                      ),
                      _buildTextField(
                        label: "Last Name",
                        controller: editBillerController.lastNameController,
                        hintText: "Tylor",
                        keyboardType: TextInputType.name,
                      ),
                      _buildTextField(
                        label: "Phone",
                        controller: editBillerController.phoneController,
                        hintText: "00 000 000 000",
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        label: "Email",
                        controller: editBillerController.emailController,
                        hintText: "joseph@gmail.com",
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
                                editBillerController.selectedDate.value,
                            onDateSelected: (DateTime date) {
                              editBillerController.selectedDate.value = date;
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
                          editBillerController.warehouseId.value =
                              warehouseController.warehouseList
                                      .firstWhere((item) => item.name == value)
                                      .id ??
                                  0;
                        },
                      ),
                      _buildTextField(
                        label: "NID or Passport Number",
                        controller:
                            editBillerController.nidPassportNumberController,
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
                          editBillerController.countryId.value =
                              countriesController.countriesList
                                      .firstWhere((item) => item.title == value)
                                      .id ??
                                  0;
                        },
                      ),
                      _buildTextField(
                        label: "City",
                        controller: editBillerController.cityController,
                        hintText: "Enter City",
                        keyboardType: TextInputType.text,
                      ),
                      _buildTextField(
                        label: "Zip Code",
                        controller: editBillerController.zipCodeController,
                        hintText: "Code",
                        keyboardType: TextInputType.text,
                      ),
                      _buildTextField(
                        label: "Biller Code",
                        controller: editBillerController.billerCodeController,
                        hintText: "BW-00570",
                        keyboardType: TextInputType.text,
                      ),
                      _buildTextField(
                        label: "Address",
                        maxLines: 3,
                        controller: editBillerController.addressController,
                        hintText: "Malmate Station, New York, USA",
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomElevatedButton(
                          buttonName: "Update Now",
                          onPressed: () {
                            editBillerController.postBillerUpdate(
                                billerId: widget.biller.id.toString());
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

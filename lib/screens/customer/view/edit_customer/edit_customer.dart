import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/model/customer_model.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/screens/customer/controller/edit_customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditCustomer extends StatefulWidget {
  final CustomerData customer;

  const EditCustomer({super.key, required this.customer});

  @override
  State<EditCustomer> createState() => EditCustomerState();
}

class EditCustomerState extends State<EditCustomer> {
  final EditCustomerController editCustomerController =
      Get.put(EditCustomerController());

  @override
  void initState() {
    super.initState();
    editCustomerController.firstNameController.text =
        widget.customer.firstName ?? "";
    editCustomerController.lastNameController.text =
        widget.customer.lastName ?? "";
    editCustomerController.categoryId.value = widget.customer.categoryId ?? 0;
    editCustomerController.phoneController.text = widget.customer.phone ?? "";
    editCustomerController.emailController.text = widget.customer.email ?? "";
    editCustomerController.countryId.value = widget.customer.countryId ?? 0;
    editCustomerController.cityController.text = widget.customer.city ?? "";
    editCustomerController.zipCodeController.text =
        widget.customer.zipCode ?? "";
    editCustomerController.rewardPointController.text =
        widget.customer.rewardPoint ?? '';
    editCustomerController.addressController.text =
        widget.customer.address ?? "";

    editCustomerController.getCountries();
    editCustomerController.getCustomerByTypeCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarName: "Update Customer"),
      body: Obx(
        () => editCustomerController.isLoading.value
            ? CustomLoading(
                withOpacity: 0.0,
              )
            : Padding(
                padding: REdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            text: "First Name",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(
                            controller:
                                editCustomerController.firstNameController,
                            decoration: InputDecoration(hintText: "Steve"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            text: "Last Name",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(
                            controller:
                                editCustomerController.lastNameController,
                            decoration: InputDecoration(hintText: "Smith"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            text: "Customer Category",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomDropdownField(
                            validatorText: "Category",
                            hintText: "Select Category",
                            dropdownItems:
                                editCustomerController.categoryList.isEmpty
                                    ? ["Not Found"]
                                    : editCustomerController.categoryList
                                        .map((item) => item.title as String)
                                        .toList(),
                            onChanged: (value) {
                              editCustomerController.categoryId
                                  .value = editCustomerController.categoryList
                                      .firstWhere((item) => item.title == value)
                                      .id ??
                                  0;
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
                          CustomLabelText(
                            text: "Phone",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(
                            controller: editCustomerController.phoneController,
                            decoration:
                                InputDecoration(hintText: "00 000 000 000"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            text: "Email",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(
                            controller: editCustomerController.emailController,
                            decoration: InputDecoration(
                                hintText: "Steavesmith@gmail.com"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            text: "Country",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomDropdownField(
                            hintText: "Select Country",
                            dropdownItems:
                                editCustomerController.countriesList.isEmpty
                                    ? ["Not Found"]
                                    : editCustomerController.countriesList
                                        .map((item) => item.title as String)
                                        .toList(),
                            onChanged: (value) {
                              editCustomerController.countryId
                                  .value = editCustomerController.countriesList
                                      .firstWhere((item) => item.title == value)
                                      .id ??
                                  0;
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            text: "City",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(
                            controller: editCustomerController.cityController,
                            decoration: InputDecoration(hintText: "New York"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            text: "Zip Code",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(
                            controller:
                                editCustomerController.zipCodeController,
                            decoration: InputDecoration(hintText: "48756"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            text: "Reward Point",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(
                            controller:
                                editCustomerController.rewardPointController,
                            decoration: InputDecoration(hintText: "546"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            text: "Address",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(
                            maxLines: 3,
                            controller:
                                editCustomerController.addressController,
                            decoration: InputDecoration(
                                hintText: "Malmate Station, New York, USA"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomElevatedButton(
                          buttonName: "Update Now",
                          onPressed: () {
                            editCustomerController.postCustomerEdit(
                                customerId: widget.customer.id.toString());
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

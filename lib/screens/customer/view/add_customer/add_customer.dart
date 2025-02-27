import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_outline_button.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/screens/customer/controller/create_customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final CreateCustomerController createCustomerController =
      Get.put(CreateCustomerController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    createCustomerController.getCountries();
    createCustomerController.getCustomerByTypeCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarName: "Create Customer"),
      body: Obx(
        () => createCustomerController.isLoading.value
            ? CustomLoading(
                withOpacity: 0.0,
              )
            : Padding(
                padding: REdgeInsets.all(12),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabelText(
                              text: "First Name",
                              isRequired: true,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "First name is required";
                                }
                                return null;
                              },
                              controller:
                                  createCustomerController.firstNameController,
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
                                  createCustomerController.lastNameController,
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
                              isRequired: true,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            CustomDropdownField(
                              validatorText: "Category",
                              hintText: "Select Category",
                              dropdownItems:
                                  createCustomerController.categoryList.isEmpty
                                      ? ["Not Found"]
                                      : createCustomerController.categoryList
                                          .map((item) => item.title as String)
                                          .toList(),
                              onChanged: (value) {
                                createCustomerController.categoryId.value =
                                    createCustomerController.categoryList
                                            .firstWhere(
                                                (item) => item.title == value)
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
                              isRequired: true,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Phone is required";
                                }
                                return null;
                              },
                              controller:
                                  createCustomerController.phoneController,
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
                              isRequired: true,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                }
                                return null;
                              },
                              controller:
                                  createCustomerController.emailController,
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
                                  createCustomerController.countriesList.isEmpty
                                      ? ["Not Found"]
                                      : createCustomerController.countriesList
                                          .map((item) => item.title as String)
                                          .toList(),
                              onChanged: (value) {
                                createCustomerController.countryId.value =
                                    createCustomerController.countriesList
                                            .firstWhere(
                                                (item) => item.title == value)
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
                              controller:
                                  createCustomerController.cityController,
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
                                  createCustomerController.zipCodeController,
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
                              controller: createCustomerController
                                  .rewardPointController,
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
                                  createCustomerController.addressController,
                              decoration: InputDecoration(
                                  hintText: "Malmate Station, New York, USA"),
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
                                  createCustomerController
                                      .resetCreateCustomerFields();
                                }),
                            CustomElevatedButton(
                              buttonName: "Create Now",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  createCustomerController.postCustomerCreate();
                                }
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

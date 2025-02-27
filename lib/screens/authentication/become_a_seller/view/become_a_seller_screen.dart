import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/authentication/become_a_seller/controller/become_a_seller_controller.dart';
import 'package:invoshop/screens/authentication/become_a_seller/view/sub_sections/become_a_seller_payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BecomeASellerScreen extends StatefulWidget {
  const BecomeASellerScreen({super.key});

  @override
  State<BecomeASellerScreen> createState() => _BecomeASellerScreenState();
}

class _BecomeASellerScreenState extends State<BecomeASellerScreen> {
  final BecomeASellerController becomeASellerController =
      Get.put(BecomeASellerController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Become a Seller"),
      body: Container(
        color: AppColors.groceryWhite,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    Container(
                      padding: REdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                              color: AppColors.groceryRatingGray
                                  .withOpacity(0.2))),
                      child: const Icon(
                        Icons.person_outline,
                        size: 18,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Owner Information",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16.sp),
                    )
                  ],
                ),
                Divider(
                  color: AppColors.groceryRatingGray.withOpacity(0.2),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomLabelText(
                      text: "First Name",
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: becomeASellerController.firstNameController,
                      keyboardType: TextInputType.text,
                      validator: becomeASellerController
                          .requiredFieldValidator("First Name"),
                      style: TextStyle(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        hintText: "Steave",
                        prefixIcon: Icon(Icons.person_outline, size: 20),
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
                      text: "Last Name",
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: becomeASellerController.lastNameController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        hintText: "Smith",
                        prefixIcon: Icon(Icons.person_outline, size: 20),
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
                      isRequired: true,
                      text: "Email",
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: becomeASellerController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: becomeASellerController
                          .requiredFieldValidator("Email"),
                      style: TextStyle(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        hintText: "smith@gmail.com",
                        prefixIcon: Icon(Icons.email_outlined, size: 20),
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
                      text: "Phone",
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: becomeASellerController.phoneController,
                      keyboardType: TextInputType.phone,
                      validator: becomeASellerController
                          .requiredFieldValidator("Phone"),
                      style: TextStyle(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        hintText: "+8801734604086",
                        prefixIcon: Icon(Icons.phone_outlined, size: 20),
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
                      text: "City",
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: becomeASellerController.cityController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        hintText: "Manhaton",
                        prefixIcon:
                            Icon(Icons.location_city_outlined, size: 20),
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
                      text: "Zip Code",
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: becomeASellerController.zipCodeController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        hintText: "53167",
                        prefixIcon: Icon(Icons.code_outlined, size: 20),
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
                      text: "Supplier Code",
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller:
                          becomeASellerController.supplierCodeController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        hintText: "53167",
                        prefixIcon: Icon(Icons.code_outlined, size: 20),
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
                      text: "Domain Name",
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: becomeASellerController.domainNameController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        hintText: "organist.com",
                        prefixIcon: Icon(
                            Icons
                                .signal_cellular_connected_no_internet_0_bar_outlined,
                            size: 20),
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
                      text: "Address",
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      maxLines: 3,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: becomeASellerController.addressController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        hintText: "Write Here...",
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomElevatedButton(
                  buttonName: "Next",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.to(const BecomeASellerPaymentMethod());
                    }
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            )),
      ),
    );
  }
}

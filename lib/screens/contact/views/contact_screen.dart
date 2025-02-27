import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/contact/controller/contact_us_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ContactUsController contactUsController =
      Get.put(ContactUsController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString("user");
    if (userData != null && userData.isNotEmpty) {
      final user = jsonDecode(userData);
      contactUsController.fullNameController.text = user["user_full_name"];
      contactUsController.emailController.text = user["user_email"];
      contactUsController.phoneController.text = user["user_phone"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Contact Us"),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 15.h),
                  _buildFormFields(),
                  SizedBox(height: 10.h),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
          Obx(
            () => Visibility(
                visible: contactUsController.isLoading.value,
                child: CustomLoading()),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/images/sign_up/contact.png',
            width: 150.w,
            height: 150.h,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 15.h),
          Text(
            "Contact Us",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.groceryTitle,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            "Drop a message with us. One of your customer service agents will contact you.",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.grocerySubTitle,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildTextField(
          label: "Full Name",
          controller: contactUsController.fullNameController,
          keyboardType: TextInputType.text,
          validator: (value) =>
              value?.isEmpty ?? true ? "Full name is required" : null,
        ),
        SizedBox(height: 10.h),
        _buildTextField(
          label: "Email",
          controller: contactUsController.emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              value?.isEmpty ?? true ? "Email is required" : null,
        ),
        SizedBox(height: 10.h),
        _buildTextField(
          label: "Phone",
          controller: contactUsController.phoneController,
          keyboardType: TextInputType.phone,
          validator: (value) =>
              value?.isEmpty ?? true ? "Phone is required" : null,
        ),
        SizedBox(height: 10.h),
        _buildTextField(
          label: "Subject",
          controller: contactUsController.subjectController,
          keyboardType: TextInputType.text,
          validator: (value) =>
              value?.isEmpty ?? true ? "Subject is required" : null,
        ),
        SizedBox(height: 10.h),
        _buildTextField(
          label: "Message",
          controller: contactUsController.formDataController,
          keyboardType: TextInputType.text,
          maxLines: 3,
          validator: (value) =>
              value?.isEmpty ?? true ? "Message is required" : null,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabelText(text: label, isRequired: true),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: label),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomElevatedButton(
        buttonName: "Send",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            contactUsController.postContact();
          }
        },
      ),
    );
  }
}

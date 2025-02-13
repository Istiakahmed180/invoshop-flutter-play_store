import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/common_text_field.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/custom_text_area.dart';
import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _message = '';
  String? _userNameError;
  String? _emailError;
  String? _phoneError;
  String? _messageError;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _userNameError =
            _nameController.text.isEmpty ? 'Name is required' : null;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\d{10,15}$');
    return phoneRegex.hasMatch(phone);
  }

  bool _validateForm() {
    setState(() {
      _userNameError = _nameController.text.isEmpty ? 'Name is required' : null;
      _emailError =
          !_validateEmail(_emailController.text) ? 'Enter a valid email' : null;
      _phoneError = _phoneController.text.isEmpty
          ? 'Phone number is required'
          : !_validatePhoneNumber(_phoneController.text)
              ? 'Enter a valid phone number'
              : null;
      _messageError = _message.isEmpty ? 'Message is required' : null;
    });

    return _userNameError == null &&
        _emailError == null &&
        _phoneError == null &&
        _messageError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/sign_up/contact.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
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
              ),
              SizedBox(height: 10.h),
              CommonTextField(
                controller: _nameController,
                hintText: "Name",
              ),
              if (_userNameError != null)
                Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 5.w),
                  child: Text(
                    _userNameError!,
                    style: TextStyle(
                        color: AppColors.grocerySecondary, fontSize: 12.sp),
                  ),
                ),
              SizedBox(height: 10.h),
              CommonTextField(
                controller: _emailController,
                hintText: "Email",
              ),
              if (_emailError != null)
                Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 5.w),
                  child: Text(
                    _emailError!,
                    style: TextStyle(
                        color: AppColors.grocerySecondary, fontSize: 12.sp),
                  ),
                ),
              SizedBox(height: 10.h),
              CommonTextField(
                controller: _phoneController,
                hintText: "Phone",
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              if (_phoneError != null)
                Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 5.w),
                  child: Text(
                    _phoneError!,
                    style: TextStyle(
                        color: AppColors.grocerySecondary, fontSize: 12.sp),
                  ),
                ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Message",
                maxLines: 3,
                onSaved: (value) => _message = value ?? '',
              ),
              if (_messageError != null)
                Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 5.w),
                  child: Text(
                    _messageError!,
                    style: TextStyle(
                        color: AppColors.grocerySecondary, fontSize: 12.sp),
                  ),
                ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                height: 53,
                child: CustomElevatedButton(
                  buttonName: "Send",
                  onPressed: () {
                    if (_validateForm()) {
                      Fluttertoast.showToast(
                          msg: "Message Sent Successfully",
                          backgroundColor: AppColors.groceryPrimary,
                          textColor: AppColors.groceryWhite);
                      Get.offNamed(BaseRoute.signIn);
                    }
                  },
                  buttonTextSize: 14.sp,
                  buttonColor: AppColors.groceryPrimary,
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}

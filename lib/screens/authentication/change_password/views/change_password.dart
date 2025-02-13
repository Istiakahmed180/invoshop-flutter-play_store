import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/common_text_field.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  bool _validateForm() {
    setState(() {
      _passwordError = _validatePassword(_passwordController.text)
          ? null
          : 'Password must be at least 6 characters long';
      _confirmPasswordError =
          _passwordController.text == _confirmPasswordController.text
              ? null
              : 'Passwords do not match';
    });

    return _passwordError == null && _confirmPasswordError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/sign_up/change_pass.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "Create new password",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.groceryTitle,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Please enter a new password to",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.grocerySubTitle,
                      ),
                    ),
                    Text(
                      "secure your account.",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.grocerySubTitle,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              CommonTextField(
                controller: _passwordController,
                hintText: "Password",
                isPassword: true,
                isPasswordVisible: _isPasswordVisible,
                prefixIcon: Icons.lock_outline,
                togglePasswordVisibility: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              if (_passwordError != null)
                Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 5.w),
                  child: Text(
                    _passwordError!,
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),
              SizedBox(height: 10.h),
              CommonTextField(
                controller: _confirmPasswordController,
                hintText: "Confirm Password",
                isPassword: true,
                isPasswordVisible: _isConfirmPasswordVisible,
                prefixIcon: Icons.lock_outline,
                togglePasswordVisibility: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              if (_confirmPasswordError != null)
                Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 5.w),
                  child: Text(
                    _confirmPasswordError!,
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                width: double.infinity,
                height: 53,
                child: CustomElevatedButton(
                  buttonName: "Create",
                  onPressed: () {
                    if (_validateForm()) {
                      Fluttertoast.showToast(
                        msg: "Password changed successfully",
                        backgroundColor: AppColors.groceryPrimary,
                        textColor: AppColors.groceryWhite,
                      );
                      Get.offNamed(BaseRoute.home);
                    }
                  },
                  buttonTextSize: 14.sp,
                  buttonColor: AppColors.groceryPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

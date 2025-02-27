import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_text_field.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';

class ForgottenPassScreen extends StatefulWidget {
  const ForgottenPassScreen({super.key});

  @override
  State<ForgottenPassScreen> createState() => _ForgottenPassScreenState();
}

class _ForgottenPassScreenState extends State<ForgottenPassScreen> {
  final TextEditingController _emailController = TextEditingController();

  String? _emailError;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _emailError = _validateEmail(_emailController.text)
            ? null
            : 'Enter a valid email';
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  bool _validateForm() {
    setState(() {
      _emailError =
          _validateEmail(_emailController.text) ? null : 'Enter a valid email';
    });

    return _emailError == null;
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
                  'assets/images/sign_up/forgot.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.groceryTitle,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Enter your email address to request password reset.",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.grocerySubTitle,
                ),
              ),
              SizedBox(height: 10.h),
              CommonTextField(
                controller: _emailController,
                hintText: "Enter your Email",
                prefixIcon: Icons.email_outlined,
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
              SizedBox(height: 15.h),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: "Remember your password? ",
                    style: TextStyle(
                      color: AppColors.grocerySubTitle,
                      fontSize: 14.sp,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: AppColors.groceryPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offNamed(BaseRoute.signIn);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: double.infinity,
                height: 53,
                child: CustomElevatedButton(
                  buttonName: "Send Request",
                  onPressed: () {
                    if (_validateForm()) {
                      Fluttertoast.showToast(
                        msg:
                            "Password reset link sent. Please check your email.",
                        backgroundColor: AppColors.groceryPrimary,
                        textColor: AppColors.groceryWhite,
                      );
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

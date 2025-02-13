import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  String? _otpError;

  bool _validateForm() {
    if (_otpController.text.length < 6) {
      setState(() {
        _otpError = "Please enter the complete 6-digit code.";
      });
      return false;
    }
    return true;
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
                  'assets/images/sign_up/verify_otp.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Enter your verification code",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.groceryTitle,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Check your email, we sent you a verification code.",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.grocerySubTitle,
                ),
              ),
              SizedBox(height: 15.h),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _otpController,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  inactiveBorderWidth: 1.5,
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveColor: AppColors.groceryBorder,
                  activeColor: AppColors.groceryPrimary,
                  selectedColor: AppColors.groceryInfo,
                  activeFillColor: AppColors.groceryWhite,
                  selectedFillColor: AppColors.groceryWhite,
                  inactiveFillColor: AppColors.groceryWhite,
                ),
                onChanged: (value) {
                  setState(() {
                    _otpError = null;
                  });
                },
              ),
              if (_otpError != null)
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Text(
                    _otpError!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              SizedBox(height: 15.h),
              SizedBox(
                width: double.infinity,
                height: 53,
                child: CustomElevatedButton(
                  buttonName: "Verify OTP",
                  onPressed: () {
                    if (_validateForm()) {
                      Fluttertoast.showToast(
                        msg: "OTP verified successfully.",
                        backgroundColor: AppColors.groceryPrimary,
                        textColor: AppColors.groceryWhite,
                      );
                      Get.offNamed(BaseRoute.changePassword);
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

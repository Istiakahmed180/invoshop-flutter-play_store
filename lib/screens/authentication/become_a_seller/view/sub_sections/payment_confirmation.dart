import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentConfirmation extends StatelessWidget {
  const PaymentConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.groceryPrimary,
                size: 100,
              ),
              SizedBox(height: 20.h),
              Text(
                'We have received your seller request.\nWe will contact you shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              CustomElevatedButton(
                buttonName: "Go Back",
                onPressed: () {
                  Get.offAllNamed(BaseRoute.findDomain);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

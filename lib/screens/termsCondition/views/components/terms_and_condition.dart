import 'package:ai_store/common/widgets/section_title.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: "Terms & Conditions Agreement",
            ),
            SizedBox(
              height: 5.h,
            ),
            RichText(
              text: TextSpan(
                text: 'Welcome to ',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.grocerySubTitle,
                ),
                children: [
                  TextSpan(
                    text: 'Invoshop,',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grocerySubTitle,
                    ),
                  ),
                ],
              ),
            ),
            buildDescription(
                "By accessing and using our platform, you agree to comply with and be bound by the following terms and conditions. Please read these terms carefully."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "1. Acceptance of Terms"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
              "By creating an account, placing an order, or using any of our services, you acknowledge that you have read, understood, and agree to these terms.",
            ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(
              title: "2. User Responsibilities : ",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(
              title: "3. Order and Payment :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "All orders placed through our platform are subject to availability. You agree to provide accurate payment and billing information. Invoshop reserves the right to cancel or refuse any order."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(
              title: "4. Shipping and Delivery :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "Shipping times may vary depending on location and availability. Invoshop is not responsible for delays caused by shipping providers."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(
              title: "5. Returns and Refunds :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "We offer a return policy on certain products in accordance with our return policy guidelines. Refunds will be processed within a reasonable timeframe."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(
              title: "6. Use of Website :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "You agree not to misuse our website or services, including engaging in any unlawful activities or distributing harmful content."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "7. Limitation of Liability"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "Invoshop will not be liable for any direct, indirect, incidental, or consequential damages arising from your use of our services."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "8. Amendments to Terms"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "These terms are subject to change. Any changes will be posted on our website, and your continued use of our services constitutes acceptance of the revised terms."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "9. Contact Information"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "If you have any questions regarding these Terms & Conditions, please contact us at:"),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Invoshop",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.grocerySubTitle,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            RichText(
              text: TextSpan(
                text: 'Email : ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.grocerySubTitle,
                ),
                children: [
                  TextSpan(
                    text: 'inveshop@example.com,',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.groceryPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            RichText(
              text: TextSpan(
                text: 'Phone : ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.grocerySubTitle,
                ),
                children: [
                  TextSpan(
                    text: '+9845234636',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.groceryPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text buildDescription(String description) {
    return Text(description,
        style: TextStyle(
          fontSize: 13.sp,
          color: AppColors.grocerySubTitle,
        ));
  }
}

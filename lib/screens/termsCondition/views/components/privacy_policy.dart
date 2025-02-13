import 'package:ai_store/common/widgets/section_title.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Privacy Policy Agreement"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "At Invoshop, we value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you interact with our platform."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "1. Why We Collect Data"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "We collect data to provide you with a seamless shopping experience. This includes personalizing your experience, processing your orders, and offering customer support."),
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
              title: "2. Personal Information :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "When you create an account, place an order, or subscribe to our services, we may collect information like your name, email, phone number, shipping and billing addresses, and payment details."),
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
              title: "3. Order History and Preferences :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "To improve your shopping experience, we store data on your past purchases and preferences."),
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
              title: "4. Browsing Data :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "We track your browsing behavior, including the pages you visit, products you view, and items you add to your cart, to enhance your shopping experience."),
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
              title: "5. Cookies and Tracking Technologies :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "We use cookies and other tracking technologies to better understand how you interact with our website and to optimize your experience. This information helps us improve site performance and personalize content."),
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
              title: "6. Third-Party Services :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "In some cases, we may share your data with trusted third-party service providers to improve our services and support your shopping experience. These partners are required to maintain the confidentiality and security of your data."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "7. Data Security"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "We use appropriate technical and organizational measures to safeguard your personal data from unauthorized access, alteration, or disclosure."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "8. Changes to This Privacy Policy"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "We may update this Privacy Policy from time to time. We will notify you of any significant changes by posting the updated policy on our website. Your continued use of our services after the changes indicates your acceptance of the updated terms."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "9. Contact Us"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "If you have any questions or concerns regarding this Privacy Policy, please contact us at:"),
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
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.grocerySubTitle,
              ),
            ),
            const SizedBox(height: 5),
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

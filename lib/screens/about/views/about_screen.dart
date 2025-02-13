import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/section_title.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Widget buildDescription(String text,
      {double fontSize = 13, double height = 1.5}) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: fontSize.sp,
        height: height,
        color: AppColors.grocerySubTitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: 'About Us'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: Image.asset('assets/logos/logo.png'),
            ),
            const Center(
              child: Text(
                'Version 1.0.0',
                style:
                    TextStyle(fontSize: 14, color: AppColors.grocerySubTitle),
              ),
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: 'About Invoshop'),
            const SizedBox(height: 10),
            buildDescription(
              'Invoshop is a leading e-commerce platform that provides a seamless and intuitive shopping experience. Our mission is to deliver quality products at the best prices while ensuring customer satisfaction. We offer a wide range of products across various categories, making shopping easy and convenient for everyone.',
            ),
            const SizedBox(height: 5),
            const Divider(color: AppColors.groceryBorder),
            const SizedBox(height: 5),
            const SectionTitle(title: 'Features'),
            const SizedBox(height: 5),
            buildDescription(
              '• Wide variety of products\n'
              '• Secure payment options\n'
              '• Fast and reliable delivery\n'
              '• 24/7 customer support\n'
              '• Easy returns and refunds',
            ),
            const SizedBox(height: 5),
            const Divider(color: AppColors.groceryBorder),
            const SizedBox(height: 5),
            const SectionTitle(title: 'Our Mission'),
            const SizedBox(height: 5),
            buildDescription(
              'At Invoshop, our mission is to revolutionize the e-commerce industry by offering an unparalleled shopping experience. We aim to provide customers with an extensive product range, exceptional customer service, and a user-friendly platform that makes shopping enjoyable and stress-free.',
              fontSize: 13,
              height: 1.5,
            ),
            const SizedBox(height: 5),
            const Divider(color: AppColors.groceryBorder),
            const SectionTitle(title: 'Contact Us'),
            const SizedBox(height: 5),
            buildDescription(
              'We would love to hear from you! If you have any questions, suggestions, or feedback, please feel free to reach out to us:',
            ),
            const SizedBox(height: 5),
            const Divider(color: AppColors.groceryBorder),
            const SizedBox(height: 5),
            buildContactInfo(
                'Email : ', 'support@invoshop.com', AppColors.groceryPrimary),
            const SizedBox(height: 5),
            buildContactInfo(
                'Phone : ', '+1 234 567 890', AppColors.groceryPrimary),
            const SizedBox(height: 5),
            buildContactInfo(
                'Address : ',
                '1234 Shopping St, Commerce City, CA 90001',
                AppColors.groceryPrimary),
          ],
        ),
      ),
    );
  }

  RichText buildContactInfo(String label, String info, Color infoColor) {
    return RichText(
      text: TextSpan(
        text: label,
        style: TextStyle(fontSize: 14.sp, color: AppColors.grocerySubTitle),
        children: [
          TextSpan(
            text: info,
            style: TextStyle(
                fontSize: 14.sp, fontWeight: FontWeight.bold, color: infoColor),
          ),
        ],
      ),
    );
  }
}

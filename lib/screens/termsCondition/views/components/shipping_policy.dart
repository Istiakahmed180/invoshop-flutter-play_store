import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoshop/common/widgets/section_title.dart';
import 'package:invoshop/constants/app_colors.dart';

class ShippingPolicy extends StatelessWidget {
  final String type;
  const ShippingPolicy({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: "Shipping Policy",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "At Invoshop, we aim to provide prompt and reliable shipping for all orders. Below is our detailed shipping policy to help you understand our processes and timelines."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "1. Shipping Locations"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "We currently ship to a wide range of domestic and international locations. Availability of shipping services may vary based on your location."),
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
              title: "2. Shipping Methods :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "We offer several shipping options, including standard and express shipping. The available methods and costs will be displayed during checkout based on your delivery address."),
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
              title: "3. Processing Time :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "Orders are processed within 1-3 business days. Processing times may vary during peak shopping periods. Once your order has been processed, you will receive a confirmation email with tracking details."),
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
              title: "4. Shipping Time :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "Delivery times depend on the selected shipping method and your location. Standard shipping typically takes 5-7 business days, while express shipping may take 2-3 business days."),
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
              title: "5. Shipping Fees :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "Shipping fees are calculated based on the weight of your order, the shipping method selected, and your delivery location. All shipping costs will be displayed during the checkout process."),
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
              title: "6. International Shipping :",
            ),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "For international orders, shipping times may vary depending on the destination country. Please note that you may be responsible for customs duties, taxes, and import fees imposed by your country."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "7. Tracking Your Order"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "Once your order has shipped, you will receive a tracking number via email. You can use this number to track your shipment and monitor its delivery status."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "8. Lost or Delayed Shipments"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "If your shipment is delayed or lost, please contact our customer service team for assistance. While we are not responsible for carrier delays, we will do our best to resolve any shipping issues."),
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
                "For any questions or concerns about shipping, please contact us at:"),
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

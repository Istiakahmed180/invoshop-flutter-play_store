import 'package:ai_store/common/widgets/section_title.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancellationPolicy extends StatelessWidget {
  const CancellationPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Cancellation Policy"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "At Invoshop, we strive to ensure that our customers have the best shopping experience. We understand that situations may arise where you may need to cancel your order, and we have outlined our cancellation policy below."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "1. Order Cancellation Before Shipment"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "If you wish to cancel your order, you may do so at any time before your order has been shipped. Once the order is canceled, any payments made will be refunded to the original payment method within 5-7 business days."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "2. Order Cancellation After Shipment"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "If your order has already been shipped, cancellation is no longer possible. However, you may be eligible to return the product under our return policy once it is delivered to you."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "3. Non-Cancellable Items"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "Certain items, such as personalized or made-to-order products, are non-cancellable once the order has been placed. Please ensure to review the product details before making your purchase."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "4. How to Cancel an Order"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "To cancel an order, please log in to your Invoshop account, navigate to your order history, and select the order you wish to cancel. You can also contact our customer support team directly for assistance."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "5. Refund Process"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "Upon successful cancellation, we will process your refund within 5-7 business days. The time for the refund to reflect in your account may vary depending on your payment provider."),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: AppColors.groceryBorder,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SectionTitle(title: "6. Contact Us"),
            SizedBox(
              height: 5.h,
            ),
            buildDescription(
                "If you have any questions or concerns regarding cancellations, please contact our support team at:"),
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

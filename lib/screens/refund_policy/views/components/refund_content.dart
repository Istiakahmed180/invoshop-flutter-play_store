import 'package:ai_store/common/widgets/section_title.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RefundContent extends StatelessWidget {
  const RefundContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "Product Refund Policy"),
          SizedBox(
            height: 5.h,
          ),
          buildRichText('At ', 'Invoshop,', AppColors.grocerySubTitle, true),
          buildDescription(
              "we strive to provide you with high-quality products and an exceptional shopping experience. However, we understand that there may be instances where you need to return a product. We want to make the process as smooth as possible for you, so please take a moment to review our product refund policy."),
          _buildDivider(),
          const SectionTitle(title: "Eligibility for Refund"),
          SizedBox(
            height: 5.h,
          ),
          _buildSectionDescriptions([
            'To be eligible for a refund, the product must be in its original condition, unused, and in its original packaging.',
            'Returns must be initiated within 2 days of receiving the product.',
            'Personalized or customized items may not be eligible for a refund unless they arrive damaged or with a defect.',
          ]),
          _buildDivider(),
          const SectionTitle(title: "Return Shipping"),
          SizedBox(
            height: 5.h,
          ),
          _buildSectionDescriptions([
            'Customers are responsible for the cost of return shipping unless the product arrived damaged or with a defect.',
            'We recommend using a trackable shipping service to ensure that your return reaches us safely.',
          ]),
          _buildDivider(),
          const SectionTitle(title: "Inspection and Processing"),
          SizedBox(
            height: 5.h,
          ),
          _buildSectionDescriptions([
            'Once we receive your returned product, our team will inspect it to ensure it meets our eligibility criteria.',
            'If the product qualifies for a refund, we will process the refund within [X] business days.',
            'Refunds will be issued to the original payment method used for the purchase.',
          ]),
          _buildDivider(),
          const SectionTitle(title: "Refund Amount"),
          SizedBox(
            height: 5.h,
          ),
          _buildSectionDescriptions([
            'The refund amount will include the cost of the product and any applicable taxes.',
            'Shipping fees are non-refundable unless the return is due to a shipping error on our part.',
          ]),
          _buildDivider(),
          const SectionTitle(title: "Damaged or Defective Products"),
          SizedBox(
            height: 5.h,
          ),
          _buildSectionDescriptions([
            'If you receive a damaged or defective product, please contact us immediately.',
            'We may request photos or other documentation to assess the issue and provide a replacement or refund.',
          ]),
          _buildDivider(),
          const SectionTitle(title: "Exchanges"),
          SizedBox(
            height: 5.h,
          ),
          buildDescription(
              'We do not offer direct exchanges. If you need a different product, please return the original item following our refund policy guidelines and place a new order.'),
          _buildDivider(),
          const SectionTitle(title: "Non-Refundable Items"),
          SizedBox(
            height: 5.h,
          ),
          buildDescription(
              'Gift cards and downloadable software or digital products are non-refundable.'),
          _buildDivider(),
          const SectionTitle(title: "Changes to this Policy"),
          SizedBox(
            height: 5.h,
          ),
          buildDescription(
              'Invoshop reserves the right to update or modify this refund policy at any time without prior notice. Any changes will be effective immediately upon posting on our website.'),
          SizedBox(
            height: 5.h,
          ),
          buildDescription(
              'If you have any questions or concerns regarding our product refund policy, please do not hesitate to contact our customer support team. We are here to assist you and ensure that you have a positive shopping experience with us. Thank you for choosing Invoshop!'),
          _buildDivider(),
          buildContactInfo(
              'Email: ', 'inveshop@example.com', AppColors.groceryPrimary),
          const SizedBox(height: 5),
          buildContactInfo('Phone: ', '+9845234636', AppColors.groceryPrimary),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Column(
      children: [
        const Divider(color: AppColors.groceryBorder),
        SizedBox(height: 5.h),
      ],
    );
  }

  Widget _buildSectionDescriptions(List<String> descriptions) {
    return Column(
      children: descriptions
          .map((description) => buildDescription(description, true))
          .toList(),
    );
  }

  RichText buildRichText(
      String prefix, String boldText, Color color, bool isBold) {
    return RichText(
      text: TextSpan(
        text: prefix,
        style: TextStyle(fontSize: 13.sp, color: color),
        children: [
          TextSpan(
            text: boldText,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDescription(String description, [bool withBullet = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (withBullet)
              Container(
                margin: const EdgeInsets.only(right: 8.0, top: 8),
                child: const CircleAvatar(
                  radius: 4.0,
                  backgroundColor: AppColors.grocerySubTitle,
                ),
              ),
            Expanded(
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.grocerySubTitle,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
      ],
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

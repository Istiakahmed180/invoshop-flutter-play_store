import 'package:flutter/material.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/termsCondition/views/components/cancellation_policy.dart';
import 'package:ai_store/screens/termsCondition/views/components/privacy_policy.dart';
import 'package:ai_store/screens/termsCondition/views/components/shipping_policy.dart';
import 'package:ai_store/screens/termsCondition/views/components/terms_and_condition.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.groceryWhite,
          elevation: 2,
          centerTitle: true,
          title: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Terms & Condition",
              style: TextStyle(
                  color: AppColors.groceryTitle,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: AppColors.groceryPrimary,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            labelColor: AppColors.groceryPrimary,
            unselectedLabelColor: AppColors.groceryTitle,
            tabs: [
              Tab(
                child: Text("Privacy & Policy"),
              ),
              Tab(
                child: Text("Terms & Condition"),
              ),
              Tab(
                child: Text("Cancellation Policy"),
              ),
              Tab(
                child: Text("Shipping Policy"),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PrivacyPolicy(),
            TermsAndCondition(),
            CancellationPolicy(),
            ShippingPolicy(),
          ],
        ),
      ),
    );
  }
}

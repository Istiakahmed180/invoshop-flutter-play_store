import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/termsCondition/controller/terms_condition_controller.dart';
import 'package:invoshop/screens/termsCondition/views/components/privacy_policy.dart';
import 'package:invoshop/screens/termsCondition/views/components/terms_and_condition.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  final TermsConditionController termsConditionController =
      Get.put(TermsConditionController());

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await termsConditionController.getPrivacyPolicyContent();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.groceryPrimary,
          elevation: 2,
          centerTitle: true,
          title: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Policy",
              style: TextStyle(
                  color: AppColors.groceryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.groceryWhite,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(
            onTap: (int? value) async {
              termsConditionController.selectedTab.value = value ?? 0;
              if (termsConditionController.selectedTab.value == 0) {
                await termsConditionController.getPrivacyPolicyContent();
              } else {
                await termsConditionController.getTermsAndConditionContent();
              }
            },
            isScrollable: true,
            indicatorColor: AppColors.groceryWhite,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            labelColor: AppColors.groceryWhite,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(
                child: Text("Privacy & Policy"),
              ),
              Tab(
                child: Text("Terms & Condition"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PrivacyPolicy(
              type: "Privacy Policy",
              termsConditionController: termsConditionController,
            ),
            TermsAndCondition(
              type: "Terms and Condition",
              termsConditionController: termsConditionController,
            ),
          ],
        ),
      ),
    );
  }
}

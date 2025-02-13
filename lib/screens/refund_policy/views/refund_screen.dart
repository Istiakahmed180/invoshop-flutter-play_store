import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/refund_policy/views/components/refund_content.dart';
import 'package:ai_store/screens/refund_policy/views/components/refund_form.dart';

class RefundScreen extends StatelessWidget {
  const RefundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.groceryWhite,
          elevation: 2,
          centerTitle: true,
          title: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Refund Policy",
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
                child: Text("Refund Policy"),
              ),
              Tab(
                child: Text("Request For Refund"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
                color: AppColors.groceryWhite,
                padding: REdgeInsets.all(12),
                child: const RefundContent()),
            Container(
                color: AppColors.groceryWhite,
                padding: REdgeInsets.all(12),
                child: const RefundForm()),
          ],
        ),
      ),
    );
  }
}

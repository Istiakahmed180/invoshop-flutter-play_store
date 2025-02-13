import 'dart:convert';

import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/overview/controller/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final OverviewController overviewController = Get.put(OverviewController());
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString("user");
    if (userData != null && userData.isNotEmpty) {
      setState(() {
        user = jsonDecode(userData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Overview"),
      body: Obx(
        () => overviewController.isLoading.value
            ? const CustomLoading(withOpacity: 0.0)
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    SizedBox(height: 20.h),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 1.2,
                      ),
                      children: _buildCards(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, ${user?["user_full_name"] ?? "N/A"}',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.h),
        Text(
          'Welcome to your account, where you can manage your e-commerce experience all in one place. Check your balance, orders, and more.',
          style: TextStyle(fontSize: 12.sp, color: AppColors.groceryRatingGray),
        ),
      ],
    );
  }

  List<Widget> _buildCards() {
    return [
      _buildCard(
        title: 'Total Earnings',
        value:
            '\$${overviewController.overviewModel.data?.totalEarnings ?? 0.00}',
        icon: Icons.attach_money_rounded,
        color: Colors.green,
      ),
      _buildCard(
        title: 'Current Earnings',
        value:
            "\$${overviewController.overviewModel.data?.currentEarnings ?? "0.00"}",
        icon: Icons.trending_up_rounded,
        color: Colors.blue,
      ),
      _buildCard(
        title: 'Pending Earnings',
        value:
            '\$${overviewController.overviewModel.data?.pendingEarnings ?? "0.00"}',
        icon: Icons.pending_actions_rounded,
        color: Colors.orange,
      ),
      _buildCard(
        title: 'Total Orders',
        value: overviewController.overviewModel.data?.totalOrders ?? "0",
        icon: Icons.shopping_cart_rounded,
        color: Colors.purple,
      ),
      _buildCard(
        title: 'Current Orders',
        value: overviewController.overviewModel.data?.currentOrders ?? "0",
        icon: Icons.shopping_basket_rounded,
        color: Colors.teal,
      ),
      _buildCard(
        title: 'Pending Orders',
        value: overviewController.overviewModel.data?.pendingOrders ?? "0",
        icon: Icons.hourglass_empty_rounded,
        color: Colors.amber,
      ),
      _buildCard(
        title: 'Total Reviews',
        value: overviewController.overviewModel.data?.totalReviews ?? "0",
        icon: Icons.reviews_rounded,
        color: Colors.redAccent,
      ),
      _buildCard(
        title: 'Average Rating',
        value: overviewController.overviewModel.data?.avgRating ?? "0",
        icon: Icons.star_rate_rounded,
        color: Colors.yellow.shade700,
      ),
      _buildCard(
        title: 'Maximum Rating',
        value: overviewController.overviewModel.data?.maxRating ?? "0",
        icon: Icons.star_rounded,
        color: Colors.deepOrange,
      ),
      _buildCard(
        title: 'Royalty Points',
        value: overviewController.overviewModel.data?.royaltyPoints ?? "0",
        icon: Icons.verified_rounded,
        color: Colors.indigoAccent,
      ),
    ];
  }

  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSecondaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: REdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 30),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.groceryRatingGray,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

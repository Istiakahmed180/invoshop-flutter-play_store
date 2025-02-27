import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/wishlist/views/components/wishlist_cart.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  WishlistScreenState createState() => WishlistScreenState();
}

class WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: 'My Wishlist'),
      backgroundColor: AppColors.groceryWhite,
      body: SafeArea(
        child: Container(
          color: AppColors.groceryWhite,
          padding: REdgeInsets.all(12),
          child: const Column(
            children: [
              Expanded(
                child: WishlistCartList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

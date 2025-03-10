import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/cart/views/sub_sections/cart_list.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: 'My Cart'),
      backgroundColor: AppColors.groceryWhite,
      body: SafeArea(
        child: Container(
          color: AppColors.groceryWhite,
          child: const Column(
            children: [
              Expanded(
                child: CartList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

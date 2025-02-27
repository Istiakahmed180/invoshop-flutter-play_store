import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/bottom_navigation_controller.dart';
import 'package:invoshop/common/widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/web_view/custom_web_view_login.dart';
import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/constants/user_role.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/authentication/sign_in/controller/sign_in_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final SignInController signInController = Get.put(SignInController());
  final BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

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
    return Drawer(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              bottomNavigationController.onItemTapped(3);
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/drawer_image/drawer_banner.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder(
                        future: ApiPath.getImageUrl(user?["user_image"] ?? ""),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          }
                          if (snapshot.hasError) {
                            return const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: AppColors.groceryBorder,
                            );
                          }
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              backgroundColor:
                                  AppColors.groceryPrimary.withOpacity(0.15),
                              radius: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  imageUrl: snapshot.data ?? "",
                                  placeholder: (context, url) =>
                                      Image.asset("assets/gif/loading.gif"),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.broken_image,
                                    color: AppColors.groceryRatingGray,
                                  ),
                                ),
                              ),
                            );
                          }

                          return const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: AppColors.groceryBorder,
                          );
                        },
                      ),
                      CustomElevatedButton(
                        buttonName: "Web View",
                        onPressed: () {
                          Get.to(const CustomWebViewLogin());
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Name : ${user?['user_full_name'] ?? ''}",
                    style: const TextStyle(
                      color: AppColors.groceryWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Email : ${user?['user_email'] ?? ''}",
                    style: const TextStyle(
                      color: AppColors.groceryRatingGray,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/home.svg",
                    title: "Home",
                    onTap: () {
                      bottomNavigationController.onItemTapped(0);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin ||
                      user?["user_role"] == UserRole.customer,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/overview.svg",
                    title: "Overview",
                    onTap: () => Get.toNamed(BaseRoute.overView),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/vendor_products_icon.svg",
                    title: "Products",
                    onTap: () => Get.toNamed(BaseRoute.adminAndVendorProducts),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/brand.svg",
                    title: "Brand",
                    onTap: () => Get.toNamed(BaseRoute.brand),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/expenses_drawer.svg",
                    title: "Expense",
                    onTap: () => Get.toNamed(BaseRoute.expense),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.admin ||
                      user?["user_role"] == UserRole.customer,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/pos-drawer.svg",
                    title: "POS",
                    onTap: () => Get.toNamed(BaseRoute.pos),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin ||
                      user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/pos-drawer.svg",
                    title: "Sale",
                    onTap: () => Get.toNamed(BaseRoute.sale),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin ||
                      user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/pos-drawer.svg",
                    title: "Reports",
                    onTap: () => Get.toNamed(BaseRoute.reports),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/new_order.svg",
                    title: "New Order",
                    onTap: () => Get.toNamed(BaseRoute.newOrder),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.admin ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer,
                  child: _buildDrawerItem(
                    icon: "assets/icons/profile/orders_history.svg",
                    title: user?["user_role"] == UserRole.admin ||
                            user?["user_role"] == UserRole.superAdmin
                        ? "Orders"
                        : "My Orders",
                    onTap: () => user?["user_role"] == UserRole.vendor ||
                            user?["user_role"] == UserRole.admin ||
                            user?["user_role"] == UserRole.superAdmin
                        ? Get.toNamed(BaseRoute.orders)
                        : Get.toNamed(BaseRoute.customerOrders),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/profile/review.svg",
                    title: "Reviews",
                    onTap: () => Get.toNamed(BaseRoute.userReviews),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/order_return.svg",
                    title: "Order Return",
                    onTap: () => Get.toNamed(BaseRoute.orderReturn),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/payment_drawer.svg",
                    title: "Bank Account",
                    onTap: () => Get.toNamed(BaseRoute.bankAccount),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/user_management.svg",
                    title: "User Management",
                    onTap: () => Get.toNamed(BaseRoute.userManagement),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/user_management.svg",
                    title: "Customer",
                    onTap: () => Get.toNamed(BaseRoute.customer),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/user_management.svg",
                    title: "Supplier",
                    onTap: () => Get.toNamed(BaseRoute.supplier),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/user_management.svg",
                    title: "Billers",
                    onTap: () => Get.toNamed(BaseRoute.billers),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/user_management.svg",
                    title: "Warehouse",
                    onTap: () => Get.toNamed(BaseRoute.warehouse),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/combo.svg",
                    title: "Combo Offers",
                    onTap: () => Get.toNamed(BaseRoute.comboOffer),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/refund.svg",
                    title: "Refund Policy",
                    onTap: () => Get.toNamed(BaseRoute.refundPolicy),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/about.svg",
                    title: "About Us",
                    onTap: () => Get.toNamed(BaseRoute.about),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/contact.svg",
                    title: "Contact Us",
                    onTap: () => Get.toNamed(BaseRoute.contact),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/terms.svg",
                    title: "Policy",
                    onTap: () => Get.toNamed(BaseRoute.termsCondition),
                  ),
                ),
                Visibility(
                  visible: user?["user_role"] == UserRole.vendor ||
                      user?["user_role"] == UserRole.customer ||
                      user?["user_role"] == UserRole.superAdmin ||
                      user?["user_role"] == UserRole.admin,
                  child: _buildDrawerItem(
                    icon: "assets/icons/drawer/sign_out.svg",
                    title: "Sign Out",
                    onTap: () => _showLogoutConfirmation(context),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 20,
        colorFilter:
            const ColorFilter.mode(AppColors.grocerySubTitle, BlendMode.srcIn),
      ),
      title: buildDrawerMenuTitle(title),
      onTap: onTap,
    );
  }

  Text buildDrawerMenuTitle(String menuTitle) {
    return Text(
      menuTitle,
      style: TextStyle(
        color: AppColors.grocerySubTitle,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: "Confirm Sign Out",
        subTitle: "Are you sure you want to sign out?",
        okButtonName: "Sign out",
        pressedOk: () {
          Get.back();
          signInController.signOut();
        },
        noButtonName: "Cancel",
        pressedNo: () => Get.back(),
      ),
    );
  }
}

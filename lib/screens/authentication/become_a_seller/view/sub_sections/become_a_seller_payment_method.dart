import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/authentication/become_a_seller/controller/become_a_seller_controller.dart';
import 'package:invoshop/screens/authentication/become_a_seller/model/package_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BecomeASellerPaymentMethod extends StatefulWidget {
  const BecomeASellerPaymentMethod({super.key});

  @override
  State<BecomeASellerPaymentMethod> createState() =>
      _BecomeASellerPaymentMethodState();
}

class _BecomeASellerPaymentMethodState
    extends State<BecomeASellerPaymentMethod> {
  final BecomeASellerController _controller =
      Get.put(BecomeASellerController());

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller.getPackage();
    _controller.selectedPaymentMethod.value = "Pay Later";
    _controller.cuoponCodeController.text = "";
    _controller.couponStatus.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Payment Method"),
      body: Stack(
        children: [
          Container(
            color: AppColors.groceryBody,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: ListView(
              children: [
                SizedBox(height: 12.h),
                _buildPaymentMethods(),
                SizedBox(height: 20.h),
                _buildCouponCodeSection(),
                SizedBox(height: 10.h),
                _buildPackageSelection(),
                SizedBox(height: 10.h),
                CustomElevatedButton(
                  buttonName: "Make Payment",
                  onPressed: () => _controller.makePayment(),
                ),
              ],
            ),
          ),
          Obx(() => Visibility(
                visible: _controller.isLoading.value,
                child: const CustomLoading(),
              )),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    final paymentMethods = [
      {'title': 'Pay Later', 'value': 'Pay Later', 'imageUrl': null},
      {
        'title': 'Cash On Delivery',
        'value': 'Cash On Delivery',
        'imageUrl': "https://inventual.app/build/assets/money-98cbcd2d.png"
      },
      {
        'title': 'Paypal',
        'value': 'Paypal',
        'imageUrl': "https://inventual.app/build/assets/paypal-8adce8ac.png"
      },
      {
        'title': 'Stripe',
        'value': 'Stripe',
        'imageUrl': "https://inventual.app/build/assets/stripe-00ca3ccb.png"
      },
    ];

    return Column(
      children: paymentMethods.map((method) {
        return Column(
          children: [
            _buildPaymentMethodOption(
              title: method['title']!,
              value: method['value']!,
              imageUrl: method['imageUrl'],
            ),
            SizedBox(height: 10.h),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildPaymentMethodOption({
    required String title,
    required String value,
    String? imageUrl,
  }) {
    return GestureDetector(
      onTap: () => _controller.selectedPaymentMethod.value = value,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          border:
              Border.all(color: AppColors.groceryRatingGray.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Obx(() => Radio(
                        activeColor: AppColors.groceryPrimary,
                        value: value,
                        groupValue: _controller.selectedPaymentMethod.value,
                        onChanged: (String? selectedValue) {
                          if (selectedValue != null) {
                            _controller.selectedPaymentMethod.value =
                                selectedValue;
                          }
                        },
                      )),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.onBackgroundColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (imageUrl != null)
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Image.network(imageUrl, width: 40.w),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: "Coupon Code",
          icon: Icons.code,
        ),
        Divider(color: AppColors.groceryRatingGray.withOpacity(0.2)),
        SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomLabelText(text: "Coupon Code"),
                  SizedBox(height: 3.h),
                  TextFormField(
                    controller: _controller.cuoponCodeController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 12.sp),
                    decoration: const InputDecoration(hintText: "Coupon"),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            CustomElevatedButton(
              buttonName: "Apply",
              onPressed: () => _controller.getCouponCode(),
              buttonColor: AppColors.groceryPrimary,
            ),
          ],
        ),
        Obx(() {
          final status = _controller.couponStatus.value;
          if (status.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              status,
              style: TextStyle(
                color: status == "Added Code Successfully"
                    ? AppColors.groceryPrimary
                    : AppColors.grocerySecondary,
                fontSize: 12.sp,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPackageSelection() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: "Packages",
          ),
          Column(
            children: _controller.packageList.map((package) {
              return GestureDetector(
                onTap: () {
                  _controller.selectedPackage.value = package;
                  _controller.packageID.value = package.id!;
                },
                child: Row(
                  children: [
                    Obx(() => Radio<PackageData>(
                          activeColor: AppColors.groceryPrimary,
                          value: package,
                          groupValue: _controller.selectedPackage.value,
                          onChanged: (PackageData? selectedPackage) {
                            if (selectedPackage != null) {
                              _controller.selectedPackage.value =
                                  selectedPackage;
                              _controller.packageID.value = selectedPackage.id!;
                            }
                          },
                        )),
                    Text(
                      package.title!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.onBackgroundColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }

  Widget _buildSectionHeader({required String title, IconData? icon}) {
    return Row(
      children: [
        if (icon != null)
          Container(
            padding: REdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                  color: AppColors.groceryRatingGray.withOpacity(0.4)),
            ),
            child: Icon(icon, size: 18),
          ),
        if (icon != null) SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
      ],
    );
  }
}

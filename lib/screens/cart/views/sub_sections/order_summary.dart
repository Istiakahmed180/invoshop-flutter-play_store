import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/checkout_controller.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/controller/wish_cart_list_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/make_payment/view/make_payment_screen.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final WishListAndCartListController wishListAndCartListController =
      Get.put(WishListAndCartListController());
  final CurrencyController currencyController = Get.put(CurrencyController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Order Summery"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12.w, left: 12.w, right: 12.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Obx(
                      () => TextFormField(
                        readOnly: checkoutController.couponAmount.value == 0
                            ? false
                            : true,
                        controller: checkoutController.couponCodeController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 12.sp),
                        decoration:
                            const InputDecoration(hintText: "Coupon Code"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx(
                    () => checkoutController.isVisibleRemoveButton.value
                        ? CustomElevatedButton(
                            buttonName: "Remove",
                            onPressed: () {
                              checkoutController.isVisibleRemoveButton.value =
                                  false;
                              checkoutController.couponCodeController.clear();
                              checkoutController.couponType.value = "";
                              checkoutController.couponAmount.value = 0;
                              wishListAndCartListController.calculateTotals();
                            },
                            buttonColor: AppColors.grocerySecondary,
                          )
                        : CustomElevatedButton(
                            buttonName: "Apply",
                            onPressed: () {
                              if (checkoutController
                                  .couponCodeController.text.isNotEmpty) {
                                checkoutController.getCoupon(
                                    couponCode: checkoutController
                                        .couponCodeController.text);
                                wishListAndCartListController.calculateTotals();
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Write your coupon code",
                                    backgroundColor:
                                        AppColors.grocerySecondary);
                              }
                            },
                            buttonColor: AppColors.groceryPrimary,
                          ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildSupplierMethod(),
                  Obx(
                    () => Visibility(
                      visible: checkoutController.courierKey.value == "redx",
                      child: _buildDeliveryArea(),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Visibility(
                  visible: checkoutController.courierID.value != 0,
                  child: _buildSideRadio()),
            ),
            Divider(
              color: AppColors.groceryBorder,
              endIndent: 12.w,
              indent: 12.w,
            ),
            _summaryRow(
                'Items Price:', wishListAndCartListController.subtotal.value),
            Obx(
              () => Visibility(
                  visible: wishListAndCartListController.discount.value != 0,
                  child: _summaryRow('DISCOUNT:',
                      wishListAndCartListController.discount.value)),
            ),
            _summaryRow('TAX:', wishListAndCartListController.productTax.value),
            Obx(
              () => _summaryRow(
                  'Shipping Charge:', checkoutController.shippingCharge.value),
            ),
            Divider(
              color: AppColors.groceryBorder,
              endIndent: 12.w,
              indent: 12.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.groceryText,
                        fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => Text(
                      "${currencyController.currencySymbol}${wishListAndCartListController.total.value.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.groceryText,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.w, bottom: 8.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: CustomElevatedButton(
                  buttonName: "Make Payment",
                  verticalPadding: 10,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (checkoutController.shippingCharge.value != 0) {
                        Get.to(MakePaymentScreen(
                          products:
                              wishListAndCartListController.cartProductsList,
                          totalAmount:
                              wishListAndCartListController.total.value,
                        ));
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please check shipping method",
                            backgroundColor: AppColors.grocerySecondary);
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideRadio() {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                value: checkoutController.selectedInSide.value,
                activeColor: AppColors.groceryPrimary,
                side: const BorderSide(
                  color: AppColors.groceryBorder,
                  width: 2.0,
                ),
                onChanged: (bool? value) {
                  if (value != null) {
                    if (value) {
                      checkoutController.selectedInSide.value = true;
                      checkoutController.selectedOutSide.value = false;
                      checkoutController.shippingCharge.value = 0.0;
                      checkoutController.shippingCharge.value =
                          checkoutController.insideCost.value.toDouble();
                      checkoutController.deliveryType.value = "";
                      checkoutController.deliveryType.value = "inside_dhaka";
                    } else {
                      checkoutController.selectedInSide.value = false;
                      checkoutController.shippingCharge.value = 0.0;
                      checkoutController.deliveryType.value = "";
                    }
                  }
                },
              ),
              GestureDetector(
                onTap: () {
                  checkoutController.selectedInSide.value =
                      !checkoutController.selectedInSide.value;
                  checkoutController.shippingCharge.value = 0.0;
                  checkoutController.deliveryType.value = "";
                  if (checkoutController.selectedInSide.value) {
                    checkoutController.selectedOutSide.value = false;
                    checkoutController.shippingCharge.value = 0.0;
                    checkoutController.shippingCharge.value =
                        checkoutController.insideCost.value.toDouble();
                    checkoutController.deliveryType.value = "";
                    checkoutController.deliveryType.value = "inside_dhaka";
                  }
                },
                child: Text(
                  "${currencyController.currencySymbol}${checkoutController.insideCost.value}/kg Inside Dhaka",
                  style: const TextStyle(
                      fontSize: 14, color: AppColors.groceryText),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Row(
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                value: checkoutController.selectedOutSide.value,
                activeColor: AppColors.groceryPrimary,
                side: const BorderSide(
                  color: AppColors.groceryBorder,
                  width: 2.0,
                ),
                onChanged: (bool? value) {
                  if (value != null) {
                    if (value) {
                      checkoutController.selectedOutSide.value = true;
                      checkoutController.selectedInSide.value = false;
                      checkoutController.shippingCharge.value = 0.0;
                      checkoutController.shippingCharge.value =
                          checkoutController.outsideCost.value.toDouble();
                      checkoutController.deliveryType.value = "";
                      checkoutController.deliveryType.value = "outside_dhaka";
                    } else {
                      checkoutController.selectedOutSide.value = false;
                      checkoutController.shippingCharge.value = 0.0;
                      checkoutController.deliveryType.value = "";
                    }
                  }
                },
              ),
              GestureDetector(
                onTap: () {
                  checkoutController.selectedOutSide.value =
                      !checkoutController.selectedOutSide.value;
                  checkoutController.shippingCharge.value = 0.0;
                  checkoutController.deliveryType.value = "";
                  if (checkoutController.selectedOutSide.value) {
                    checkoutController.selectedInSide.value = false;
                    checkoutController.shippingCharge.value = 0.0;
                    checkoutController.shippingCharge.value =
                        checkoutController.outsideCost.value.toDouble();
                    checkoutController.deliveryType.value = "";
                    checkoutController.deliveryType.value = "outside_dhaka";
                  }
                },
                child: Text(
                  "${currencyController.currencySymbol}${checkoutController.outsideCost.value}/kg Outside Dhaka",
                  style: const TextStyle(
                      fontSize: 14, color: AppColors.groceryText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupplierMethod() {
    return Padding(
      padding: EdgeInsets.only(top: 12.w, left: 12.w, right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomLabelText(
            text: "Shipping Method",
            isRequired: true,
          ),
          SizedBox(
            height: 5.h,
          ),
          CustomDropdownField(
            validatorText: "Shipping",
            hintText: "Select Shipping",
            dropdownItems: checkoutController.courierList.isEmpty
                ? ["Not Available"]
                : checkoutController.courierList
                    .map((item) => item.values?.name ?? "Unknown")
                    .toList(),
            onChanged: (value) async {
              final selectedCourier = checkoutController.courierList.firstWhere(
                (item) => item.values?.name == value,
              );
              checkoutController.courierID.value = selectedCourier.id ?? 0;
              checkoutController.insideCost.value = int.tryParse(
                      selectedCourier.values?.insideDhakaCost ?? '0') ??
                  0;
              checkoutController.outsideCost.value = int.tryParse(
                      selectedCourier.values?.outsideDhakaCost ?? '0') ??
                  0;
              checkoutController.courierKey.value = "";
              checkoutController.courierKey.value =
                  selectedCourier.keyName ?? "";
              if (checkoutController.courierKey.value == "redx") {
                await checkoutController.getDeliveryArea();
              } else {
                checkoutController.deliveryAreaList.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryArea() {
    return Padding(
      padding: EdgeInsets.only(top: 12.w, left: 12.w, right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomLabelText(
            isRequired: true,
            text: "Delivery Area",
          ),
          SizedBox(
            height: 5.h,
          ),
          CustomDropdownField(
            validatorText: "Area",
            hintText: "Select Area",
            dropdownItems: checkoutController.deliveryAreaList.isEmpty
                ? ["Not Available"]
                : checkoutController.deliveryAreaList
                    .map((item) => item.name ?? "Unknown")
                    .toList(),
            onChanged: (value) {
              checkoutController.deliveryArea.value = "";
              checkoutController.deliveryArea.value = value!;
              checkoutController.deliveryAreaID.value = checkoutController
                      .deliveryAreaList
                      .firstWhere((item) => item.title == value)
                      .id ??
                  0;
            },
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String title, double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: AppColors.groceryText),
          ),
          Text(
            '${currencyController.currencySymbol}${value.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.groceryPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

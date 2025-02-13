import 'dart:convert';

import 'package:ai_store/common/controller/checkout_controller.dart';
import 'package:ai_store/common/controller/wish_cart_list_controller.dart';
import 'package:ai_store/common/model/country_model.dart';
import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/home/model/products_model.dart';
import 'package:ai_store/screens/profile/models/coupon_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakePaymentController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final WishListAndCartListController wishListAndCartListController =
      Get.put(WishListAndCartListController());
  final RxBool isLoading = false.obs;
  final RxBool isCheckoutLoading = false.obs;
  final RxBool isSameAsBillingAddress = false.obs;
  final RxInt currentPage = 0.obs;
  final PageController pageController = PageController();
  final billerFirstName = TextEditingController();
  final billerLastName = TextEditingController();
  final billerPhone = TextEditingController();
  final billerEmail = TextEditingController();
  final RxInt billerCountryId = 0.obs;
  final billerCity = TextEditingController();
  final billerZipCode = TextEditingController();
  final billerAddress = TextEditingController();
  final shippingFirstName = TextEditingController();
  final shippingLastName = TextEditingController();
  final shippingEmail = TextEditingController();
  final shippingPhone = TextEditingController();
  final RxInt shippingCountryId = 0.obs;
  final shippingCity = TextEditingController();
  final shippingZipCode = TextEditingController();
  final shippingAddress = TextEditingController();
  final RxList<CountryData> countriesList = <CountryData>[].obs;
  final RxString shippingFirstNameValue = ''.obs;
  final RxString shippingLastNameValue = ''.obs;
  final RxString shippingEmailValue = ''.obs;
  final RxString shippingPhoneValue = ''.obs;
  final RxString shippingCityValue = ''.obs;
  final RxString shippingZipCodeValue = ''.obs;
  final RxString shippingAddressValue = ''.obs;

  void updateShippingValues() {
    shippingFirstNameValue.value = shippingFirstName.text;
    shippingLastNameValue.value = shippingLastName.text;
    shippingEmailValue.value = shippingEmail.text;
    shippingPhoneValue.value = shippingPhone.text;
    shippingCityValue.value = shippingCity.text;
    shippingZipCodeValue.value = shippingZipCode.text;
    shippingAddressValue.value = shippingAddress.text;
  }

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getCountries();
  }

  void nextPage() {
    if (currentPage.value < 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void nextPageTwo() {
    if (currentPage.value < 2) {
      updateShippingValues();
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void sameAsBillingAddress() {
    if (isSameAsBillingAddress.value) {
      shippingFirstName.text = billerFirstName.text;
      shippingLastName.text = billerLastName.text;
      shippingEmail.text = billerEmail.text;
      shippingPhone.text = billerPhone.text;
      shippingCountryId.value = billerCountryId.value;
      shippingCity.text = billerCity.text;
      shippingZipCode.text = billerZipCode.text;
      shippingAddress.text = billerAddress.text;
      updateShippingValues();
    } else {
      shippingFirstName.clear();
      shippingLastName.clear();
      shippingEmail.clear();
      shippingPhone.clear();
      shippingCountryId.value = 0;
      shippingCity.clear();
      shippingZipCode.clear();
      shippingAddress.clear();
      updateShippingValues();
    }
    update();
  }

  Future<void> getCountries() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getCountriesEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final CountryModel response = CountryModel.fromJson(jsonResponse.data!);
        countriesList.clear();
        countriesList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch countries');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching countries');
    }
  }

  Future<void> checkoutSave({
    required List<ProductsData> products,
    required String taxAmount,
    required String discount,
    required String amount,
    required String totalAmount,
  }) async {
    isCheckoutLoading.value = true;
    try {
      final String? userId = prefs.getString("user_id");
      final String? customerId = prefs.getString("customer_id");
      final List<Map<String, dynamic>> productsJson =
          products.map((product) => product.toJson()).toList();

      final Map<String, dynamic> requestBody = {
        'countryId': billerCountryId.value.toString(),
        'billerFirstName': billerFirstName.text,
        'billerLastName': billerLastName.text,
        'billerPhone': billerPhone.text,
        'billerEmail': billerEmail.text,
        'billerCity': billerCity.text,
        'billerZipCode': billerZipCode.text,
        'billerAddress': billerAddress.text,
        'receiverFirstName': shippingFirstName.text,
        'receiverLastName': shippingLastName.text,
        'receiverPhone': shippingPhone.text,
        'receiverEmail': shippingEmail.text,
        'receiverCity': shippingCity.text,
        'receiverZipCode': shippingZipCode.text,
        'receiverAddress': shippingAddress.text,
        'products': jsonEncode(productsJson),
        'shippingMethod': checkoutController.courierKey.toString(),
        'deliveryType': checkoutController.deliveryType.toString(),
        'deliveryAreaId': checkoutController.deliveryAreaID.value == 0
            ? null
            : checkoutController.deliveryAreaID.toString(),
        'deliveryAreaName': checkoutController.deliveryArea.toString(),
        'couponId': checkoutController.couponId.value == 0
            ? null
            : checkoutController.couponId.toString(),
        'userId': userId.toString(),
        'customerId': customerId.toString(),
        'taxAmount': taxAmount.toString(),
        'discount': discount.toString(),
        'amount': amount.toString(),
        'shippingAmount': checkoutController.shippingCharge.toString(),
        'totalAmount': totalAmount.toString(),
      };
      final String url = await ApiPath.postCheckoutEndpoint();
      final response = await _networkService.post(url, requestBody);
      isCheckoutLoading.value = false;

      if (response.status == Status.completed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          wishListAndCartListController.cartProductsList.clear();
          wishListAndCartListController.cartItemCount.value = 0;
        });
        Get.offNamed(BaseRoute.home);
        Fluttertoast.showToast(
          msg: "Checkout Successfully",
          backgroundColor: AppColors.groceryPrimary,
        );
        reset();
      } else {
        _showErrorToast(response.message ?? 'Failed to posting checkout');
      }
    } catch (e) {
      isCheckoutLoading.value = false;
      _showErrorToast('An error occurred while posting checkout');
    }
  }

  void reset() {
    checkoutController.isVisibleRemoveButton.value = false;
    checkoutController.courierID.value = 0;
    checkoutController.deliveryAreaID.value = 0;
    checkoutController.deliveryArea.value = "";
    checkoutController.courierKey.value = "";
    checkoutController.deliveryType.value = "";
    checkoutController.insideCost.value = 0;
    checkoutController.outsideCost.value = 0;
    checkoutController.shippingCharge.value = 0.0;
    checkoutController.couponAmount.value = 0.0;
    checkoutController.couponType.value = "";
    checkoutController.couponId.value = 0;
    checkoutController.total.value = 0.0;
    checkoutController.selectedInSide.value = false;
    checkoutController.selectedOutSide.value = false;
    checkoutController.couponData.value = CouponModel();
    checkoutController.couponCodeController.clear();
    checkoutController.courierList.clear();
    checkoutController.deliveryAreaList.clear();
  }

  @override
  void onClose() {
    billerFirstName.dispose();
    billerLastName.dispose();
    billerPhone.dispose();
    billerEmail.dispose();
    billerCity.dispose();
    billerZipCode.dispose();
    billerAddress.dispose();
    shippingFirstName.dispose();
    shippingLastName.dispose();
    shippingEmail.dispose();
    shippingPhone.dispose();
    shippingCity.dispose();
    shippingZipCode.dispose();
    shippingAddress.dispose();
    pageController.dispose();
    super.onClose();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

import 'package:invoshop/common/model/courier_model.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/cart/model/delivery_area_model.dart';
import 'package:invoshop/screens/profile/models/coupon_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;

  final RxBool isLoading = false.obs;
  final RxBool isVisibleRemoveButton = false.obs;
  final RxInt courierID = 0.obs;
  final RxInt deliveryAreaID = 0.obs;
  final RxString deliveryArea = "".obs;
  final RxString courierKey = "".obs;
  final RxString deliveryType = "".obs;
  final RxInt insideCost = 0.obs;
  final RxInt outsideCost = 0.obs;
  final RxDouble shippingCharge = 0.0.obs;
  final RxDouble couponAmount = 0.0.obs;
  final RxString couponType = "".obs;
  final RxInt couponId = 0.obs;
  final RxDouble total = 0.0.obs;
  final RxBool selectedInSide = RxBool(false);
  final RxBool selectedOutSide = RxBool(false);
  final Rx<CouponModel> couponData = CouponModel().obs;
  final couponCodeController = TextEditingController();
  final RxList<CourierData> courierList = <CourierData>[].obs;
  final RxList<Redx> deliveryAreaList = <Redx>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getCourier() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getCourierEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final CourierModel response = CourierModel.fromJson(jsonResponse.data!);
        courierList.clear();
        courierList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch courier');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching courier');
    }
  }

  Future<void> getDeliveryArea() async {
    if (courierKey.value == "redx") {
      try {
        final String url = await ApiPath.getDeliveryAreaEndpoint();
        final jsonResponse = await _networkService.get(url);
        if (jsonResponse.status == Status.completed) {
          final DeliveryAreaModel response =
              DeliveryAreaModel.fromJson(jsonResponse.data!);
          deliveryAreaList.clear();
          deliveryAreaList.addAll(response.data!.redx!);
        } else {
          _showErrorToast(
              jsonResponse.message ?? 'Failed to fetch delivery area');
        }
      } catch (e) {
        _showErrorToast('An error occurred while fetching delivery area');
      }
    } else {
      deliveryAreaList.clear();
    }
  }

  Future<void> getCoupon({required String couponCode}) async {
    try {
      final String url =
          await ApiPath.getCouponEndpoint(couponCode: couponCode);
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final CouponModel response = CouponModel.fromJson(jsonResponse.data!);
        couponData.value = response;
        isVisibleRemoveButton.value = true;
        Fluttertoast.showToast(
            msg: couponData.value.message.toString(),
            backgroundColor: AppColors.groceryPrimary);
        couponType.value = "";
        couponType.value = couponData.value.data!.type!;
        couponAmount.value = 0;
        couponAmount.value = double.parse(couponData.value.data!.amount!);
        couponId.value = 0;
        couponId.value = couponData.value.data!.id!;
      } else {
        _showErrorToast('Invalid code');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching coupon');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

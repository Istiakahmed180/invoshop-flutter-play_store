import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/authentication/become_a_seller/model/coupon_code_model.dart';
import 'package:ai_store/screens/authentication/become_a_seller/model/package_model.dart';
import 'package:ai_store/screens/authentication/become_a_seller/view/sub_sections/payment_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BecomeASellerController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final supplierCodeController = TextEditingController();
  final domainNameController = TextEditingController();
  final addressController = TextEditingController();
  final RxString selectedPaymentMethod = 'Pay Later'.obs;
  final cuoponCodeController = TextEditingController();
  final RxString couponStatus = ''.obs;
  final RxInt packageID = 0.obs;
  final RxInt couponID = 1.obs;
  final RxList<PackageData> packageList = <PackageData>[].obs;
  final Rx<PackageData?> selectedPackage = Rx<PackageData?>(null);

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  String? Function(String?) requiredFieldValidator(String fieldName) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return "$fieldName is required";
      }
      return null;
    };
  }

  Future<void> getPackage() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getPackageEndpoint();
      final jsonResponse = await _networkService.authGet(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final PackageModel response = PackageModel.fromJson(jsonResponse.data!);
        packageList.clear();
        packageList.addAll(response.data!);
        final selected = packageList.firstWhere(
            (package) => package.title == "Free for one month",
            orElse: () => packageList.first);
        selectedPackage.value = selected;
        packageID.value = selected.id!;
      } else {
        Fluttertoast.showToast(
          msg: jsonResponse.message ?? 'An error occurred',
          backgroundColor: AppColors.grocerySecondary,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
        msg: 'An error occurred',
        backgroundColor: AppColors.grocerySecondary,
      );
    }
  }

  Future<void> getCouponCode() async {
    isLoading.value = true;
    try {
      if (cuoponCodeController.text.isNotEmpty) {
        final String url = await ApiPath.getCouponCodeEndpoint(
            couponCode: cuoponCodeController.text);
        final jsonResponse = await _networkService.authGet(url);
        isLoading.value = false;
        if (jsonResponse.status == Status.completed) {
          final CouponCodeModel response =
              CouponCodeModel.fromJson(jsonResponse.data!);
          if (response.data != null) {
            couponStatus.value = "Added Code Successfully";
            couponID.value = response.data!.id!;
          } else {
            couponStatus.value = "Invalid Code!";
            couponID.value = 0;
          }
        } else {
          Fluttertoast.showToast(
            msg: jsonResponse.message ?? 'An error occurred',
            backgroundColor: AppColors.grocerySecondary,
          );
        }
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(
            msg: "Please Write Coupon Code",
            backgroundColor: AppColors.groceryWarning);
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
        msg: 'An error occurred',
        backgroundColor: AppColors.grocerySecondary,
      );
    }
  }

  Future<void> makePayment() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.postSellerSaveEndpoint();
      final Map<String, String> requestBody = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "city": cityController.text,
        "zipCode": zipCodeController.text,
        "supplierCode": supplierCodeController.text,
        "domainName": domainNameController.text,
        "paymentMethod": selectedPaymentMethod.value,
        "couponId": couponID.toString(),
        "subscriptionPackageId": packageID.toString(),
        "transactionNumber": ""
      };
      final jsonResponse = await _networkService.authPost(url, requestBody);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        if (jsonResponse.data != null && jsonResponse.data!['success']) {
          Fluttertoast.showToast(
              msg: "Payment Complete",
              backgroundColor: AppColors.groceryPrimary);
          clearController();
        }
        Get.off(const PaymentConfirmation());
      } else {
        Fluttertoast.showToast(
          msg: jsonResponse.message ?? 'An error occurred',
          backgroundColor: AppColors.grocerySecondary,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
        msg: 'An error occurred',
        backgroundColor: AppColors.grocerySecondary,
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    supplierCodeController.dispose();
    domainNameController.dispose();
    addressController.dispose();
    cuoponCodeController.dispose();
  }

  void clearController() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    cityController.clear();
    zipCodeController.clear();
    supplierCodeController.clear();
    domainNameController.clear();
    addressController.clear();
    cuoponCodeController.clear();
    couponStatus.value = '';
    couponID.value = 0;
    packageID.value = 0;
  }
}

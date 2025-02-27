import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;

  final RxBool isLoading = false.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final RxString selectedGender = ''.obs;
  final RxBool isPasswordVisible = true.obs;
  final RxBool isConfirmPasswordVisible = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  @override
  void onClose() {
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    userNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    selectedGender.value = '';
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? passwordMatchValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    }
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  String? Function(String?) requiredFieldValidator(String fieldName) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return "$fieldName is required";
      }
      return null;
    };
  }

  Future<void> submitSignUp() async {
    isLoading.value = true;

    final Map<String, String> requestBody = {
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'email': emailController.text,
      'username': userNameController.text,
      'phone': phoneController.text,
      'password': passwordController.text,
      'gender': selectedGender.value,
      'roleId': "1",
    };

    try {
      final String url = await ApiPath.postSignUpEndpoint();
      final response = await _networkService.authPost(url, requestBody);
      isLoading.value = false;
      if (response.status == Status.completed) {
        if (response.data!["message"] == "Already exists this Username!") {
          Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.grocerySecondary,
          );
        } else {
          Get.back();
          resetFields();
          Fluttertoast.showToast(
            msg: "Sign-up successful!",
            backgroundColor: AppColors.groceryPrimary,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: response.message ?? 'An error occurred',
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

  void resetFields() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    userNameController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    selectedGender.value = '';
  }
}

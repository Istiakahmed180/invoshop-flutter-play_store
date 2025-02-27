import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/controller/settings_controller.dart';
import 'package:invoshop/common/controller/shared_preference_service.dart';
import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/constants/user_role.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isPasswordVisible = true.obs;

  @override
  Future<void> onInit() async {
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

  Future<void> submitSignIn() async {
    isLoading.value = true;
    final Map<String, String> requestBody = {
      'username': userNameController.text,
      'password': passwordController.text,
    };
    try {
      final String url = await ApiPath.postSignInEndpoint();
      final response = await _networkService.authPost(url, requestBody);
      isLoading.value = false;
      if (response.status == Status.completed) {
        if (response.data!["message"] ==
            "Invalid Username/Password or not approved!") {
          Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.grocerySecondary,
          );
        } else {
          Map<String, dynamic> userData = response.data!["data"];
          List<dynamic> roles = response.data!["data"]["roles"];
          await prefs.setString('user_id', userData["id"].toString());
          await prefs.setString("token", userData["bearer_token"]);
          await prefs.setString("user_role", roles[0]["name"]);
          await prefs.setString("user_name", userData["username"]);
          final String userFullName = [
            userData["first_name"] ?? "",
            userData["last_name"] ?? ""
          ].join(" ").trim();
          await prefs.setString("user_full_name", userFullName);

          Map<String, dynamic> user = {
            "user_id": userData["id"],
            "user_first_name": userData["first_name"] ?? "",
            "user_last_name": userData["last_name"] ?? "",
            "user_full_name": userFullName,
            "user_name": userData["username"],
            "user_role": roles[0]["name"],
            "user_email": userData["email"],
            "user_phone": userData["phone"],
            "user_gender": userData["gender"],
            "user_image":
                userData["image"] != null && userData["image"].isNotEmpty
                    ? userData["image"] is Map
                        ? userData["image"]["path"]
                        : ""
                    : ""
          };
          String userJsonString = jsonEncode(user);
          await prefs.setString('user', userJsonString);

          String? route;
          if (roles.any((role) => role["name"] == UserRole.superAdmin)) {
            final SettingsController settingsController =
                Get.put(SettingsController());
            await settingsController.getSettings();
            final String currencyName = settingsController
                .settingsModel.value.data!.settings!.general!.currencyName
                .toString();
            final String currencySymbol = settingsController
                .settingsModel.value.data!.settings!.general!.currencySymbol
                .toString();
            final sharedPreferencesService = SharedPreferencesService();
            await sharedPreferencesService.setCurrencyInfo(
                currencyName, currencySymbol);
            Get.put(CurrencyController());
            route = BaseRoute.home;
          } else if (roles.any((role) => role["name"] == UserRole.admin)) {
            final SettingsController settingsController =
                Get.put(SettingsController());
            await settingsController.getSettings();
            final String currencyName = settingsController
                .settingsModel.value.data!.settings!.general!.currencyName
                .toString();
            final String currencySymbol = settingsController
                .settingsModel.value.data!.settings!.general!.currencySymbol
                .toString();
            final sharedPreferencesService = SharedPreferencesService();
            await sharedPreferencesService.setCurrencyInfo(
                currencyName, currencySymbol);
            Get.put(CurrencyController());
            route = BaseRoute.home;
          } else if (roles.any((role) => role["name"] == UserRole.vendor)) {
            final SettingsController settingsController =
                Get.put(SettingsController());
            await settingsController.getSettings();
            final String currencyName = settingsController
                .settingsModel.value.data!.settings!.general!.currencyName
                .toString();
            final String currencySymbol = settingsController
                .settingsModel.value.data!.settings!.general!.currencySymbol
                .toString();
            final sharedPreferencesService = SharedPreferencesService();
            await sharedPreferencesService.setCurrencyInfo(
                currencyName, currencySymbol);
            Get.put(CurrencyController());
            final String supplierId = userData["profile"]["id"].toString();
            await prefs.setString("supplier_id", supplierId);
            route = BaseRoute.home;
          } else if (roles.any((role) => role["name"] == UserRole.customer)) {
            final SettingsController settingsController =
                Get.put(SettingsController());
            await settingsController.getSettings();
            final String currencyName = settingsController
                .settingsModel.value.data!.settings!.general!.currencyName
                .toString();
            final String currencySymbol = settingsController
                .settingsModel.value.data!.settings!.general!.currencySymbol
                .toString();
            final sharedPreferencesService = SharedPreferencesService();
            await sharedPreferencesService.setCurrencyInfo(
                currencyName, currencySymbol);
            Get.put(CurrencyController());
            final String customerId = userData["profile"]["id"].toString();
            await prefs.setString("customer_id", customerId);
            route = BaseRoute.home;
          }
          if (route != null) {
            isLoading.value = false;
            Fluttertoast.showToast(
              msg: "Sign-in successful!",
              backgroundColor: AppColors.groceryPrimary,
            );
            Get.offNamed(route);
            resetFields();
          }
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
    userNameController.clear();
    passwordController.clear();
  }

  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_id");
    await prefs.remove("supplier_id");
    await prefs.remove("token");
    await prefs.remove("user_role");
    await prefs.remove("user_name");
    await prefs.remove("user_full_name");
    await prefs.remove("user");
    await prefs.remove("currency_symbol");
    await prefs.remove("currency_name");
    Get.offAllNamed(BaseRoute.signIn);
  }
}

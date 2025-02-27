import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUsController extends GetxController {
  final RxBool isLoading = false.obs;
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();
  final formDataController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> postContact() async {
    isLoading.value = true;
    final String? userId = prefs.getString("user_id");
    try {
      final List<Map<String, String>> formDataList = [
        {
          "name": "name",
          "type": "Text",
          "label": "Full Name",
          "value": fullNameController.text,
        },
        {
          "name": "email",
          "type": "Email",
          "label": "Email",
          "value": emailController.text,
        },
        {
          "name": "phone",
          "type": "Text",
          "label": "Phone Number",
          "value": phoneController.text,
        },
        {
          "name": "subject",
          "type": "Text",
          "label": "Subject",
          "value": subjectController.text,
        },
        {
          "name": "message",
          "type": "Textarea",
          "label": "Write Your Message",
          "value": formDataController.text,
        },
      ];
      final Map<String, dynamic> requestBody = {
        "userId": userId.toString(),
        "type": "Contact",
        "email": emailController.text,
        "formData": jsonEncode(formDataList),
      };
      final String url = await ApiPath.postContactEndpoint();
      final response = await _networkService.post(url, requestBody);
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.groceryPrimary);
        resetFields();
      } else {
        _showErrorToast(response.message ?? 'Failed to post contact');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while posting contact');
    } finally {
      isLoading.value = false;
    }
  }

  void resetFields() {
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
    subjectController.clear();
    formDataController.clear();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }

  @override
  void onClose() {
    super.onClose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    formDataController.dispose();
  }
}

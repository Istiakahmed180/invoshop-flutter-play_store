import 'package:invoshop/common/controller/camara_controller.dart';
import 'package:invoshop/common/controller/gallery_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/api_response.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/user_management/controller/user_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUserController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final CameraAccessController cameraAccessController =
      Get.put(CameraAccessController());
  final GalleryAccessController galleryAccessController =
      Get.put(GalleryAccessController());
  final UserManagementController userManagementController =
      Get.put(UserManagementController());
  final RxBool isUserCreateLoading = false.obs;
  final RxBool isPasswordVisible = true.obs;
  final RxString gender = "".obs;
  final RxInt roleId = 0.obs;
  final RxString status = "".obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> postCreateUser() async {
    isUserCreateLoading.value = true;
    final Map<String, String> requestBody = {
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "phone": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "gender": gender.toString(),
      "roleId": roleId.toString(),
      "status": status.toString(),
      "username": userNameController.text.trim(),
      "password": passwordController.text.trim(),
    };
    String? filePath;
    if (cameraAccessController.selectedFilePath.value != null) {
      filePath = cameraAccessController.selectedFilePath.value!.path;
    } else if (galleryAccessController.selectedFilePath.value != null) {
      filePath = galleryAccessController.selectedFilePath.value!.path;
    }
    final ApiResponse<Map<String, dynamic>> response;
    if (filePath != null) {
      response = await _networkService.postMultipart(
        url: await ApiPath.postUserRegisterEndpoint(),
        fields: requestBody,
        fileField: "profile_image",
        filePath: filePath,
      );
    } else {
      response = await _networkService.post(
        await ApiPath.postUserRegisterEndpoint(),
        requestBody,
      );
    }
    isUserCreateLoading.value = false;
    if (response.status == Status.completed) {
      Fluttertoast.showToast(
          msg: response.data!["message"],
          backgroundColor: AppColors.groceryPrimary);
      resetFields();
      Get.back();
      await userManagementController.getUsers();
    } else {
      _showErrorToast(response.message ?? 'Failed to post create user');
    }
  }

  void resetFields() {
    gender.value = "";
    roleId.value = 0;
    status.value = "";
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    userNameController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

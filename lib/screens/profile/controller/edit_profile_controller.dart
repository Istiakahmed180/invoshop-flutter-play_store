import 'package:ai_store/common/controller/camara_controller.dart';
import 'package:ai_store/common/controller/gallery_controller.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/api_response.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/authentication/sign_in/controller/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final SignInController signInController = Get.put(SignInController());
  final CameraAccessController cameraAccessController =
      Get.put(CameraAccessController());
  final GalleryAccessController galleryAccessController =
      Get.put(GalleryAccessController());
  final firstNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> postUpdateProfile() async {
    isLoading.value = true;
    final Map<String, String> requestBody = {
      "first_name": firstNameController.text,
      "username": userNameController.text,
      "phone": phoneController.text,
      "email": emailController.text,
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
        url: await ApiPath.postUpdateProfileEndpoint(),
        fields: requestBody,
        fileField: "profile_image",
        filePath: filePath,
      );
    } else {
      response = await _networkService.post(
        await ApiPath.postUpdateProfileEndpoint(),
        requestBody,
      );
    }

    isLoading.value = false;

    if (response.status == Status.completed) {
      Fluttertoast.showToast(
          msg: "Profile updated successfully!",
          backgroundColor: AppColors.groceryPrimary);
      signInController.signOut();
    } else {
      _showErrorToast(response.message ?? 'Failed to update profile');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

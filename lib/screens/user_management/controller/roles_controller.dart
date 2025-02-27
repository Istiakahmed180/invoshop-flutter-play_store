import 'package:invoshop/common/controller/user_role_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RolesController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isRoleLoading = false.obs;
  final RxInt roleId = 0.obs;
  final UserRoleController userRoleController = Get.put(UserRoleController());
  final roleNameController = TextEditingController();
  final editRoleNameController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> postRoleCreate() async {
    isRoleLoading.value = true;
    try {
      final String url = await ApiPath.postRoleCreateEndpoint();
      final Map<String, dynamic> requestBody = {
        "name": roleNameController.text.trim()
      };
      final response = await _networkService.post(url, requestBody);
      isRoleLoading.value = false;
      Get.back();
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.groceryPrimary);
        resetFields();
        await userRoleController.loadData();
      } else {
        _showErrorToast(
            response.data!["message"] ?? 'Failed to posting role create');
      }
    } catch (e) {
      isRoleLoading.value = false;
      _showErrorToast('An error occurred while posting role create');
    }
  }

  Future<void> deleteRole({required String roleId}) async {
    userRoleController.isLoading.value = true;
    try {
      final String url = await ApiPath.deleteRoleEndpoint(roleId: roleId);
      final response = await _networkService.delete(url);
      userRoleController.isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Role delete successfully!",
            backgroundColor: AppColors.groceryPrimary);
        await userRoleController.loadData();
      } else {
        _showErrorToast(response.data!["message"] ?? 'Failed to deleting role');
      }
    } catch (e) {
      userRoleController.isLoading.value = false;
      _showErrorToast('An error occurred while deleting role');
    }
  }

  Future<void> postRoleUpdate({required String roleId}) async {
    isRoleLoading.value = true;
    try {
      final String url = await ApiPath.postRoleEditEndpoint(roleId: roleId);
      final Map<String, dynamic> requestBody = {
        "name": editRoleNameController.text.trim(),
        "_method": "PUT"
      };
      final response = await _networkService.post(url, requestBody);
      isRoleLoading.value = false;
      Get.back();
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.groceryPrimary);
        resetEditFields();
        await userRoleController.loadData();
      } else {
        _showErrorToast(
            response.data!["message"] ?? 'Failed to posting role edit');
      }
    } catch (e) {
      isRoleLoading.value = false;
      _showErrorToast('An error occurred while posting role edit');
    }
  }

  void resetFields() {
    roleNameController.clear();
  }

  void resetEditFields() {
    editRoleNameController.clear();
  }

  @override
  void onClose() {
    super.onClose();
    roleNameController.dispose();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

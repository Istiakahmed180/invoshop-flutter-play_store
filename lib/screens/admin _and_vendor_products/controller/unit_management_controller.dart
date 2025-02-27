import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnitManagementController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final RxBool isUnitsLoading = false.obs;
  final addUnitNameController = TextEditingController();
  final addUnitShortNameController = TextEditingController();
  final editUnitNameController = TextEditingController();
  final editUnitShortNameController = TextEditingController();
  final RxList<UnitData> unitList = <UnitData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getUnits() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getUnitsEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final UnitModel response = UnitModel.fromJson(jsonResponse.data!);
        unitList.clear();
        unitList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch units');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching units');
    }
  }

  Future<void> postCreateUnit() async {
    isUnitsLoading.value = true;
    try {
      final String url = await ApiPath.postCreateUnitEndpoint();
      final Map<String, dynamic> requestBody = {
        "name": addUnitNameController.text.trim(),
        "unit_type": addUnitShortNameController.text.trim(),
      };
      final response = await _networkService.post(url, requestBody);
      isUnitsLoading.value = false;
      Get.back();
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.groceryPrimary);
        createResetFields();
        await getUnits();
      } else {
        _showErrorToast(
            response.data!["message"] ?? 'Failed to posting unit create');
      }
    } catch (e) {
      isUnitsLoading.value = false;
      _showErrorToast('An error occurred while posting unit create');
    }
  }

  Future<void> deleteUnit({required String unitId}) async {
    isUnitsLoading.value = true;
    try {
      final String url = await ApiPath.deleteUnitEndpoint(unitId: unitId);
      final response = await _networkService.delete(url);
      isUnitsLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Unit delete successfully!",
            backgroundColor: AppColors.groceryPrimary);
        await getUnits();
      } else {
        _showErrorToast(response.data!["message"] ?? 'Failed to deleting unit');
      }
    } catch (e) {
      isUnitsLoading.value = false;
      _showErrorToast('An error occurred while deleting unit');
    }
  }

  Future<void> postUnitUpdate({required String unitId}) async {
    isUnitsLoading.value = true;
    try {
      final String url = await ApiPath.postUpdateUnitEndpoint(unitId: unitId);
      final Map<String, dynamic> requestBody = {
        "name": editUnitNameController.text.trim(),
        "unit_type": editUnitShortNameController.text.trim(),
        "_method": "PUT"
      };
      final response = await _networkService.post(url, requestBody);
      isUnitsLoading.value = false;
      Get.back();
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.groceryPrimary);
        editResetFields();
        await getUnits();
      } else {
        _showErrorToast(
            response.data!["message"] ?? 'Failed to posting unit update');
      }
    } catch (e) {
      isUnitsLoading.value = false;
      _showErrorToast('An error occurred while posting unit update');
    }
  }

  void createResetFields() {
    addUnitNameController.clear();
    addUnitShortNameController.clear();
  }

  void editResetFields() {
    editUnitNameController.clear();
    editUnitShortNameController.clear();
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
    addUnitNameController.dispose();
    addUnitShortNameController.dispose();
    editUnitNameController.dispose();
    editUnitShortNameController.dispose();
  }
}

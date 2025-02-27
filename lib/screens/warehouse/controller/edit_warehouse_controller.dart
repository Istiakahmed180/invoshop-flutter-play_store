import 'package:invoshop/common/controller/warehouse_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditWarehouseController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final RxInt countryId = 0.obs;
  final RxInt companyId = 0.obs;
  final warehouseNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> postUpdateWarehouse({required String warehouseId}) async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.postUpdateWarehouseEndpoint(warehouseId: warehouseId);
      final Map<String, String> requestBody = {
        "countryId": countryId.toString(),
        "name": warehouseNameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "city": cityController.text,
        "zipCode": zipCodeController.text,
        "address": addressController.text,
        "description": descriptionController.text,
        "_method": 'PUT'
      };
      final response = await _networkService.post(url, requestBody);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Warehouse update successfully",
            backgroundColor: AppColors.groceryPrimary);
        resetFields();
        Get.back();
        await Get.find<WarehouseController>().loadWarehouse();
      } else {
        _showErrorToast(
            response.message ?? 'Failed to updating warehouse account');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while updating warehouse account');
    }
  }

  void resetFields() {
    countryId.value = 0;
    companyId.value = 0;
    warehouseNameController.clear();
    phoneController.clear();
    emailController.clear();
    cityController.clear();
    zipCodeController.clear();
    addressController.clear();
    descriptionController.clear();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

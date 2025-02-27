import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/billers/controller/billers_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditBillerController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final RxInt countryId = 0.obs;
  final RxInt warehouseId = 0.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final billerCodeController = TextEditingController();
  final zipCodeController = TextEditingController();
  final addressController = TextEditingController();
  final nidPassportNumberController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> postBillerUpdate({required String billerId}) async {
    isLoading.value = true;
    try {
      final String? userId = prefs.getString("user_id");
      final String url =
          await ApiPath.postBillerUpdateEndpoint(billerId: billerId);
      final Map<String, String> requestBody = {
        "userId": userId.toString(),
        "warehouseId": warehouseId.toString(),
        "countryId": countryId.toString(),
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "city": cityController.text,
        "address": addressController.text,
        "zipCode": zipCodeController.text,
        "billerCode": billerCodeController.text,
        "nidPassportNumber": nidPassportNumberController.text,
        "dateOfJoin": DateFormat("yyyy-MM-dd")
            .format(DateTime.parse(selectedDate.toString())),
        "_method": 'PUT',
      };
      final response = await _networkService.post(url, requestBody);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Biller update successfully",
            backgroundColor: AppColors.groceryPrimary);
        resetFields();
        Get.back();
        await Get.find<BillersController>().getBillers();
      } else {
        _showErrorToast(
            response.message ?? 'Failed to updating Biller account');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while updating Biller account');
    }
  }

  void resetFields() {
    countryId.value = 0;
    warehouseId.value = 0;
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    cityController.clear();
    billerCodeController.clear();
    zipCodeController.clear();
    addressController.clear();
    nidPassportNumberController.clear();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/bank_accounts/model/all_bank_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditBankAccountController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final accountNameController = TextEditingController();
  final accountDisplayNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final branchAddressController = TextEditingController();
  final branchNameController = TextEditingController();
  final RxInt bankId = 0.obs;
  final RxList<AllBankData> allBankList = <AllBankData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getAllBanks();
  }

  @override
  void onClose() {
    accountNameController.dispose();
    accountDisplayNameController.dispose();
    accountNumberController.dispose();
    branchAddressController.dispose();
    branchNameController.dispose();
  }

  Future<void> getAllBanks() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getAllBanksEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final AllBankModel response = AllBankModel.fromJson(jsonResponse.data!);
        allBankList.clear();
        allBankList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch all banks');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching all banks');
    }
  }

  Future<void> postBankAccountEdit({required String bankId}) async {
    isLoading.value = true;
    try {
      final String? supplierID = prefs.getString("supplier_id");
      final String url =
          await ApiPath.postBankAccountEditEndpoint(bankId: bankId);
      final Map<String, String> requestBody = {
        "bankId": bankId.toString(),
        "supplierId": supplierID.toString(),
        "accountName": accountNameController.text,
        "accountDisplayName": accountDisplayNameController.text,
        "accountNo": accountNumberController.text,
        "branchName": branchNameController.text,
        "branchAddress": branchAddressController.text,
        "_method": "put"
      };
      final response = await _networkService.post(url, requestBody);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Bank account edit successfully",
            backgroundColor: AppColors.groceryPrimary);
        resetForm();
        Get.back();
      } else {
        _showErrorToast(response.message ?? 'Failed to editing bank account');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while editing bank account');
    }
  }

  void resetForm() {
    accountNameController.clear();
    accountDisplayNameController.clear();
    accountNumberController.clear();
    branchAddressController.clear();
    branchNameController.clear();
    bankId.value = 0;
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

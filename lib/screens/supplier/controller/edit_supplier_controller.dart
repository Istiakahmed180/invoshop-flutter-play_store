import 'package:invoshop/common/model/company_model.dart';
import 'package:invoshop/common/model/country_model.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/supplier/controller/supplier_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditSupplierController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final RxInt countryId = 0.obs;
  final RxInt companyId = 0.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final supplierCodeController = TextEditingController();
  final zipCodeController = TextEditingController();
  final addressController = TextEditingController();
  final RxList<CountryData> countriesList = <CountryData>[].obs;
  final RxList<CompanyData> companyList = <CompanyData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getCountries() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getCountriesEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final CountryModel response = CountryModel.fromJson(jsonResponse.data!);
        countriesList.clear();
        countriesList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch countries');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching countries');
    }
  }

  Future<void> getCompanies() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getCompaniesEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final CompanyModel response = CompanyModel.fromJson(jsonResponse.data!);
        companyList.clear();
        companyList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch companies');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching companies');
    }
  }

  Future<void> postSupplierUpdate({required String supplierId}) async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.postSupplierUpdateEndpoint(supplierId: supplierId);
      final Map<String, String> requestBody = {
        "countryId": countryId.toString(),
        "companyId": companyId.toString(),
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "city": cityController.text,
        "address": addressController.text,
        "supplierCode": supplierCodeController.text,
        "zipCode": zipCodeController.text,
        "_method": "PUT",
      };
      final response = await _networkService.post(url, requestBody);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Supplier update successfully",
            backgroundColor: AppColors.groceryPrimary);
        resetFields();
        Get.back();
        await Get.find<SupplierController>().getSuppliers();
      } else {
        _showErrorToast(
            response.message ?? 'Failed to updating supplier account');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while updating supplier account');
    }
  }

  void resetFields() {
    countryId.value = 0;
    companyId.value = 0;
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    cityController.clear();
    supplierCodeController.clear();
    zipCodeController.clear();
    addressController.clear();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

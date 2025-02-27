import 'package:invoshop/common/model/country_model.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/customer/controller/customer_controller.dart';
import 'package:invoshop/screens/customer/model/category_by_type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCustomerController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final RxInt categoryId = 0.obs;
  final RxInt countryId = 0.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final rewardPointController = TextEditingController();
  final addressController = TextEditingController();
  final RxList<CountryData> countriesList = <CountryData>[].obs;
  final RxList<CategoryByTypeData> categoryList = <CategoryByTypeData>[].obs;

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

  Future<void> getCustomerByTypeCategories() async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.getCategoriesByTypeEndpoint(categoryType: "Customer");
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final CategoryByTypeModel response =
            CategoryByTypeModel.fromJson(jsonResponse.data!);
        categoryList.clear();
        categoryList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch categories');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching categories');
    }
  }

  Future<void> postCustomerEdit({required String customerId}) async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.postCustomerEditEndpoint(customerId: customerId);
      final Map<String, String> requestBody = {
        "countryId": countryId.toString(),
        "categoryId": categoryId.toString(),
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "city": cityController.text,
        "address": addressController.text,
        "rewardPoint": rewardPointController.text,
        "zipCode": zipCodeController.text,
        "_method": "PUT",
      };
      final response = await _networkService.post(url, requestBody);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Customer update successfully",
            backgroundColor: AppColors.groceryPrimary);
        resetUpdateCustomerFields();
        Get.back();
        await Get.find<CustomerController>().getCustomers();
      } else {
        _showErrorToast(
            response.message ?? 'Failed to updating customer account');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while updating customer account');
    }
  }

  void resetUpdateCustomerFields() {
    categoryId.value = 0;
    countryId.value = 0;
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    cityController.clear();
    zipCodeController.clear();
    rewardPointController.clear();
    addressController.clear();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

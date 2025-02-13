import 'package:ai_store/common/model/customer_model.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final RxList<CustomerData> customerList = <CustomerData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> deleteCustomer({required String customerId}) async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.deleteCustomerEndpoint(customerId: customerId);
      final response = await _networkService.delete(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.groceryPrimary);
        await getCustomers();
      } else {
        _showErrorToast(response.message ?? 'Failed to delete customer');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while deleting customers');
    }
  }

  Future<void> getCustomers() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getCustomersEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final CustomerModel response =
            CustomerModel.fromJson(jsonResponse.data!);
        customerList.clear();
        customerList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch customers');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching customers');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/billers/model/billers_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillersController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final RxList<BillersData> billersList = <BillersData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getBillers() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getBillersEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final BillersModel response = BillersModel.fromJson(jsonResponse.data!);
        billersList.clear();
        billersList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch billers');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching billers');
    }
  }

  Future<void> deleteBiller({required String billerId}) async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.deleteBillerEndpoint(billerId: billerId);
      final response = await _networkService.delete(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.groceryPrimary);
        await getBillers();
      } else {
        _showErrorToast(response.message ?? 'Failed to delete biller');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while deleting biller');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/sale/model/sales_return_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesReturnController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<SalesReturnData> salesReturnList = <SalesReturnData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getSalesReturn() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getSalesReturnEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final SalesReturnModel response =
            SalesReturnModel.fromJson(jsonResponse.data!);
        salesReturnList.clear();
        salesReturnList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch sales return');
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching sales return');
    }
  }

  Future<void> deleteSalesReturn({required String saleId}) async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.deleteSalesReturnEndpoint(saleId: saleId);
      final response = await _networkService.delete(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Sale return delete successfully",
            backgroundColor: AppColors.groceryPrimary);
        await getSalesReturn();
      } else {
        _showErrorToast(response.message ?? 'Failed to delete sale return');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while deleting sale return');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

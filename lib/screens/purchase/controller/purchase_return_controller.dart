import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/purchase/model/purchase_return_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseReturnController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<PurchaseReturnData> purchaseReturnList =
      <PurchaseReturnData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getPurchaseReturn() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getPurchaseReturnEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final PurchaseReturnModel response =
            PurchaseReturnModel.fromJson(jsonResponse.data!);
        purchaseReturnList.clear();
        purchaseReturnList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch purchases return');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching purchases return');
    }
  }

  Future<void> deletePurchaseReturn({required String purchaseId}) async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.deletePurchaseReturnEndpoint(purchaseId: purchaseId);
      final response = await _networkService.delete(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Purchase return delete successfully",
            backgroundColor: AppColors.groceryPrimary);
        await getPurchaseReturn();
      } else {
        _showErrorToast(response.message ?? 'Failed to delete purchase return');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while deleting purchase return');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

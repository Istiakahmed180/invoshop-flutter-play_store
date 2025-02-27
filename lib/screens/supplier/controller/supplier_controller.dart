import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/supplier/model/suppliers_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final RxList<SuppliersData> supplierList = <SuppliersData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getSuppliers() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getSuppliersEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final SuppliersModel response =
            SuppliersModel.fromJson(jsonResponse.data!);
        supplierList.clear();
        supplierList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch suppliers');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching suppliers');
    }
  }

  Future<void> deleteSupplier({required String supplierId}) async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.deleteSupplierEndpoint(supplierId: supplierId);
      final response = await _networkService.delete(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.groceryPrimary);
        await getSuppliers();
      } else {
        _showErrorToast(response.message ?? 'Failed to delete supplier');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while deleting supplier');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

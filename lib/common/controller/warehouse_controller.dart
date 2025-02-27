import 'package:invoshop/common/model/warehouse_model.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WarehouseController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<WarehouseData> warehouseList = <WarehouseData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> loadWarehouse() async {
    isLoading.value = true;
    await getWarehouse();
    isLoading.value = false;
  }

  Future<void> getWarehouse() async {
    try {
      final String url = await ApiPath.getWarehousesEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final WarehouseModel response =
            WarehouseModel.fromJson(jsonResponse.data!);
        warehouseList.clear();
        warehouseList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch warehouses');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching warehouses');
    }
  }

  Future<void> deleteWarehouse({required String warehouseId}) async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.deleteWarehouseEndpoint(warehouseId: warehouseId);
      final response = await _networkService.delete(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: response.data!["message"],
            backgroundColor: AppColors.groceryPrimary);
        await loadWarehouse();
      } else {
        _showErrorToast(response.message ?? 'Failed to delete warehouse');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while deleting warehouse');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

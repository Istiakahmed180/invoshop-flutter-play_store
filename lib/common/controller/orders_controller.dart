import 'dart:convert';

import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/orders/model/orders_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxBool isStatusUpdateLoading = false.obs;
  final RxBool isHeaderChecked = false.obs;
  final RxList<bool> selectedRows = <bool>[].obs;
  final RxList<OrdersData> ordersList = <OrdersData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getOrders();
  }

  void toggleAllCheckboxes() {
    isHeaderChecked.value = !isHeaderChecked.value;
    for (int i = 0; i < selectedRows.length; i++) {
      selectedRows[i] = isHeaderChecked.value;
    }
  }

  Future<void> postOrderStatusUpdate() async {
    isStatusUpdateLoading.value = true;
    final String? userId = prefs.getString("user_id");
    List<int> selectedProductIds = [];
    for (int i = 0; i < selectedRows.length; i++) {
      if (selectedRows[i]) {
        final productId = ordersList[i].id;
        if (productId != null) {
          selectedProductIds.add(productId);
        }
      }
    }
    final Map<String, dynamic> requestBody = {
      "userId": userId,
      "supplierOrderProductIds": jsonEncode(selectedProductIds),
    };
    try {
      final String url = await ApiPath.postOrderStatusUpdateEndpoint();
      final response = await _networkService.post(url, requestBody);
      isStatusUpdateLoading.value = false;
      if (response.status == Status.completed) {
        await getOrders();
        Fluttertoast.showToast(
            msg: 'Product status update successfully.',
            backgroundColor: AppColors.groceryPrimary);
      } else {
        _showErrorToast(response.message ?? 'Failed to product status update.');
      }
    } catch (e) {
      isStatusUpdateLoading.value = false;
      _showErrorToast('An error occurred while posting product status update');
    }
  }

  Future<void> getOrders() async {
    isLoading.value = true;
    final String? userId = prefs.getString("user_id");
    try {
      final String url =
          await ApiPath.getMyOrderEndpoint(userID: userId.toString());
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final OrdersModel response = OrdersModel.fromJson(jsonResponse.data!);
        ordersList.clear();
        ordersList.addAll(response.data!);
        selectedRows.clear();
        selectedRows.addAll(
          List.generate(ordersList.length, (index) => false),
        );
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch orders');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching orders');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

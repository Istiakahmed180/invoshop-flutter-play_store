import 'dart:convert';

import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/new_order/model/new_order_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewOrderController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxBool isAcceptOrdersLoading = false.obs;
  final RxBool isHeaderChecked = false.obs;
  final RxList<bool> selectedRows = <bool>[].obs;
  final RxList<NewOrderData> newOrderList = <NewOrderData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getNewOrders();
  }

  void toggleAllCheckboxes() {
    isHeaderChecked.value = !isHeaderChecked.value;
    for (int i = 0; i < selectedRows.length; i++) {
      selectedRows[i] = isHeaderChecked.value;
    }
  }

  Future<void> postOrderAccept() async {
    isAcceptOrdersLoading.value = true;
    final String? userId = prefs.getString("user_id");
    List<int> selectedProductIds = [];
    for (int i = 0; i < selectedRows.length; i++) {
      if (selectedRows[i]) {
        final productId = newOrderList[i].id;
        if (productId != null) {
          selectedProductIds.add(productId);
        }
      }
    }
    final Map<String, dynamic> requestBody = {
      "userId": userId,
      "orderProductIds": jsonEncode(selectedProductIds),
    };
    try {
      final String url = await ApiPath.postAcceptOrderEndpoint();
      final response = await _networkService.post(url, requestBody);
      isAcceptOrdersLoading.value = false;
      if (response.status == Status.completed) {
        await getNewOrders();
        Fluttertoast.showToast(
            msg: 'Orders accepted successfully.',
            backgroundColor: AppColors.groceryPrimary);
      } else {
        _showErrorToast(response.message ?? 'Failed to accept orders.');
      }
    } catch (e) {
      isAcceptOrdersLoading.value = false;
      _showErrorToast('An error occurred while posting accept orders');
    }
  }

  Future<void> getNewOrders() async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.getNewOrderEndpoint(statusType: "pending");
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final NewOrderModel response =
            NewOrderModel.fromJson(jsonResponse.data!);
        newOrderList.clear();
        newOrderList.addAll(response.data!);
        selectedRows.clear();
        selectedRows.addAll(
          List.generate(newOrderList.length, (index) => false),
        );
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch new orders');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching new orders');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

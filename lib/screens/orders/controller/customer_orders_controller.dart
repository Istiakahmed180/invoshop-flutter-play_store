import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/orders/model/customer_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerOrdersController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxBool isStatusUpdateLoading = false.obs;
  final RxBool isHeaderChecked = false.obs;
  final RxInt selectedRating = 0.obs;
  final reviewContentController = TextEditingController();
  final RxList<bool> selectedRows = <bool>[].obs;
  final RxList<int> selectedProductIds = <int>[].obs;
  final RxList<CustomerOrderData> customerOrdersList =
      <CustomerOrderData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getCustomerOrders();
  }

  void toggleAllCheckboxes() {
    isHeaderChecked.value = !isHeaderChecked.value;
    for (int i = 0; i < selectedRows.length; i++) {
      selectedRows[i] = isHeaderChecked.value;
      final order = customerOrdersList[i];
      if (isHeaderChecked.value) {
        if (order.orderProducts != null) {
          for (var product in order.orderProducts!) {
            selectedProductIds.add(product.product!.id!);
          }
        }
      } else {
        if (order.orderProducts != null) {
          for (var product in order.orderProducts!) {
            selectedProductIds.remove(product.product!.id!);
          }
        }
      }
    }
  }

  void toggleProductSelection(int index, bool? value) {
    if (value != null) {
      selectedRows[index] = value;
      final order = customerOrdersList[index];
      if (value) {
        if (order.orderProducts != null) {
          for (var product in order.orderProducts!) {
            selectedProductIds.add(product.product!.id!);
          }
        }
      } else {
        if (order.orderProducts != null) {
          for (var product in order.orderProducts!) {
            selectedProductIds.remove(product.product!.id!);
          }
        }
      }
      isHeaderChecked.value = selectedRows.every((isSelected) => isSelected);
    }
  }

  Future<void> getCustomerOrders() async {
    isLoading.value = true;
    final String? userId = prefs.getString("user_id");
    final String? userRole = prefs.getString("user_role");
    try {
      final String url = await ApiPath.getCustomerOrderEndpoint(
          userID: userId.toString(), role: userRole.toString());
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final CustomerOrderModel response =
            CustomerOrderModel.fromJson(jsonResponse.data!);
        customerOrdersList.clear();
        customerOrdersList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch customer orders');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching customer orders');
    }
  }

  Future<void> postProductReviewSave() async {
    isStatusUpdateLoading.value = true;
    final String? userId = prefs.getString("user_id");
    final Map<String, dynamic> requestBody = {
      "userId": userId.toString(),
      "productId": jsonEncode(selectedProductIds),
      "rating": selectedRating.toString(),
      "content": reviewContentController.text,
    };

    try {
      final String url = await ApiPath.postProductReviewEndpoint();
      final jsonResponse = await _networkService.post(url, requestBody);
      isStatusUpdateLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        Fluttertoast.showToast(
          msg: "Review submitted successfully",
          backgroundColor: AppColors.groceryPrimary,
        );
        resetFields();
        await getCustomerOrders();
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to submit review');
      }
    } catch (e) {
      isStatusUpdateLoading.value = false;
      _showErrorToast('An error occurred while submitting the review');
    }
  }

  Future<void> postProductRefundSave({required String orderProductId}) async {
    isStatusUpdateLoading.value = true;
    final String? userId = prefs.getString("user_id");
    final Map<String, dynamic> requestBody = {
      "userId": userId.toString(),
      "orderProductId": orderProductId.toString(),
    };

    try {
      final String url = await ApiPath.postProductRefundEndpoint();
      final jsonResponse = await _networkService.post(url, requestBody);
      isStatusUpdateLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        Fluttertoast.showToast(
          msg: "Product refund successfully",
          backgroundColor: AppColors.groceryPrimary,
        );
        Get.back();
        await getCustomerOrders();
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to product refund');
      }
    } catch (e) {
      isStatusUpdateLoading.value = false;
      _showErrorToast('An error occurred while product refund');
    }
  }

  void resetFields() {
    selectedRating.value = 0;
    selectedProductIds.clear();
    selectedRows.clear();
    reviewContentController.clear();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/expense/controller/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpenseController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxBool isExpenseLoading = false.obs;
  final RxInt warehouseId = 0.obs;
  final RxInt categoryId = 0.obs;
  final RxString expenseType = "".obs;
  final voucherController = TextEditingController();
  final amountController = TextEditingController();
  final expenseNoteController = TextEditingController();
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  @override
  void onClose() {
    super.onClose();
    voucherController.dispose();
    amountController.dispose();
    expenseNoteController.dispose();
  }

  Future<void> postExpense() async {
    isExpenseLoading.value = true;
    final String? userId = prefs.getString("user_id");
    final String? supplierId = prefs.getString("supplier_id");
    final Map<String, String> requestBody = {
      "userId": userId.toString(),
      "warehouseId": warehouseId.toString(),
      "supplierId": supplierId != null ? supplierId.toString() : "",
      "categoryId": categoryId.toString(),
      "amount": amountController.text,
      "expenseDateAt": DateFormat("yyyy-MM-dd")
          .format(DateTime.parse(selectedDate.toString())),
      "voucherNo": voucherController.text,
      "expenseType": expenseType.value,
      "comment": expenseNoteController.text
    };
    try {
      final String url = await ApiPath.postExpenseEndpoint();
      final response = await _networkService.post(url, requestBody);
      isExpenseLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Expense Create Successfully",
            backgroundColor: AppColors.groceryPrimary);
        Get.back();
        resetFields();
        await Get.find<ExpenseController>().getExpenses();
      } else {
        _showErrorToast(response.message ?? 'Failed to posting expense');
      }
    } catch (e) {
      isExpenseLoading.value = false;
      _showErrorToast('An error occurred while posting expense');
    }
  }

  void resetFields() {
    warehouseId.value = 0;
    categoryId.value = 0;
    expenseType.value = "";
    voucherController.clear();
    amountController.clear();
    expenseNoteController.clear();
    selectedDate.value = DateTime.now();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

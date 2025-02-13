import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/pos/controller/pos_controller.dart';
import 'package:ai_store/screens/pos/view/pay_complete/pay_complete.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PosMakePaymentController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final PosController posController = Get.put(PosController());
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString paymentType = "".obs;
  final RxBool isLoading = false.obs;
  final RxBool isValidAmount = false.obs;
  final payableAmountController = TextEditingController();
  final paidAmountController = TextEditingController();
  final changeAmountController = TextEditingController();
  final accountNumberController = TextEditingController();
  final transactionIdController = TextEditingController();
  final cardNumberController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  void calculateChangeAmount() {
    try {
      if (paidAmountController.text.trim().isEmpty) {
        isValidAmount.value = false;
        changeAmountController.text = "0.00";
        return;
      }

      final payableAmount = double.parse(payableAmountController.text);
      final paidAmount = double.parse(paidAmountController.text);

      isValidAmount.value = paidAmount > 0;

      if (paidAmount >= payableAmount) {
        final changeAmount = paidAmount - payableAmount;
        changeAmountController.text = changeAmount.toStringAsFixed(2);
      } else {
        changeAmountController.text = "0.00";
      }
    } catch (e) {
      isValidAmount.value = false;
      changeAmountController.text = "0.00";
    }
  }

  Future<void> makePayment() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.postMakePaymentEndpoint();
      Map<String, dynamic> requestBody = {
        "orderId": "",
        "payableAmount": payableAmountController.text,
        "paidAmount": paidAmountController.text,
        "paymentDate": DateFormat("yyyy-MM-dd")
            .format(DateTime.parse(selectedDate.value.toString())),
        "paymentType": paymentType.toString(),
        "accountNumber": accountNumberController.text,
        "trxNumber": transactionIdController.text,
        "remark": "",
      };
      final response = await _networkService.post(url, requestBody);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Payment Complete", backgroundColor: AppColors.groceryPrimary);
        resetFields();
        Get.off(const PayComplete());
      } else {
        _showErrorToast(response.message ?? 'Failed to posting make payment');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while posting make payment');
    }
  }

  void resetFields() {
    posController.selectedItems.clear();
    paymentType.value = "";
    payableAmountController.clear();
    paidAmountController.clear();
    changeAmountController.clear();
    accountNumberController.clear();
    transactionIdController.clear();
    cardNumberController.clear();
    noteController.clear();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

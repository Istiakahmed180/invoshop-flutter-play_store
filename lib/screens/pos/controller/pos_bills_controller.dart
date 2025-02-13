import 'package:ai_store/common/model/biller_model.dart';
import 'package:ai_store/common/model/customer_model.dart';
import 'package:ai_store/common/model/warehouse_model.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/home/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PosBillsController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxDouble totalSubtotals = 0.0.obs;
  final RxDouble totalTax = 0.0.obs;
  final RxDouble totalDiscount = 0.0.obs;
  final RxDouble totalAmount = 0.0.obs;
  final RxList<int> quantities = <int>[].obs;
  final RxList<double> subtotals = <double>[].obs;
  final amount = TextEditingController();
  final shippingAmount = TextEditingController();
  final RxList<WarehouseData> warehouseList = <WarehouseData>[].obs;
  final RxList<CustomerData> customerList = <CustomerData>[].obs;
  final RxList<BillerData> billerList = <BillerData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getWarehouses();
    await getCustomers();
    await getBillers();
  }

  Future<void> getWarehouses() async {
    isLoading.value = true;
    try {
      final url = await ApiPath.getWarehousesEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final WarehouseModel response =
            WarehouseModel.fromJson(jsonResponse.data!);
        warehouseList.clear();
        warehouseList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch warehouses');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching warehouses');
    }
  }

  Future<void> getCustomers() async {
    isLoading.value = true;
    try {
      final url = await ApiPath.getCustomerEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final CustomerModel response =
            CustomerModel.fromJson(jsonResponse.data!);
        customerList.clear();
        customerList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch customers');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching customers');
    }
  }

  Future<void> getBillers() async {
    isLoading.value = true;
    try {
      final url = await ApiPath.getBillersEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final BillerModel response = BillerModel.fromJson(jsonResponse.data!);
        billerList.clear();
        billerList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch billers');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching billers');
    }
  }

  void calculateSubtotals({
    required List<ProductsData> product,
  }) {
    double totalSubtotal = 0;
    double totalTaxValue = 0;
    double totalDiscountValue = 0;
    List<double> newSubtotals = List<double>.filled(product.length, 0.0);
    for (int i = 0; i < product.length; i++) {
      double price = double.parse(product[i].price!);
      int quantity = quantities[i];
      double productTax = product[i].taxType == "Percent"
          ? (price * double.parse(product[i].tax!) / 100)
          : double.parse(product[i].tax!);
      double productDiscount = product[i].discountType == "Percent"
          ? (price * double.parse(product[i].discount!) / 100)
          : double.parse(product[i].discount!);
      double subtotalPerItem = (price + productTax - productDiscount);
      double subtotal = subtotalPerItem * quantity;
      newSubtotals[i] = subtotal;
      totalSubtotal += subtotal;
      totalTaxValue += productTax * quantity;
      totalDiscountValue += productDiscount * quantity;
    }

    subtotals.value = newSubtotals;
    int shippingAmountInt =
        shippingAmount.text.isNotEmpty ? int.parse(shippingAmount.text) : 0;
    totalSubtotals.value = totalSubtotal + shippingAmountInt;
    totalTax.value = double.parse(totalTaxValue.toStringAsFixed(2));
    totalDiscount.value = totalDiscountValue;
    totalAmount.value = totalSubtotal;
    amount.text = totalAmount.value.toStringAsFixed(2);
  }

  void updateQuantity(int index, int newQuantity, List<ProductsData> products) {
    List<int> newQuantities = List<int>.from(quantities);
    newQuantities[index] = newQuantity;
    quantities.value = newQuantities;
    calculateSubtotals(product: products);
  }

  void initializeProductArrays(List<ProductsData> products) {
    quantities.value = List.filled(products.length, 1);
    subtotals.value = List.filled(products.length, 0.0);
    calculateSubtotals(product: products);
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

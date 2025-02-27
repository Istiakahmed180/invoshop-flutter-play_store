import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/report/model/customer_report_model.dart';
import 'package:invoshop/screens/report/model/discount_report_model.dart';
import 'package:invoshop/screens/report/model/expense_report_model.dart';
import 'package:invoshop/screens/report/model/payment_report_model.dart';
import 'package:invoshop/screens/report/model/product_report_model.dart';
import 'package:invoshop/screens/report/model/purchase_report_model.dart';
import 'package:invoshop/screens/report/model/sales_report_model.dart';
import 'package:invoshop/screens/report/model/stock_report_model.dart';
import 'package:invoshop/screens/report/model/supplier_report_model.dart';
import 'package:invoshop/screens/report/model/tax_report_model.dart';
import 'package:invoshop/screens/report/model/user_report_model.dart';
import 'package:invoshop/screens/report/model/warehouse_report_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportsController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxInt selectedIndex = (-1).obs;
  final RxList<SalesReportData> salesReportList = <SalesReportData>[].obs;
  final RxList<PurchaseReportData> purchaseReportList =
      <PurchaseReportData>[].obs;
  final RxList<PaymentReportData> paymentReportList = <PaymentReportData>[].obs;
  final RxList<ProductReportData> productReportList = <ProductReportData>[].obs;
  final RxList<StockReportData> stockReportList = <StockReportData>[].obs;
  final RxList<ExpenseReportData> expenseReportList = <ExpenseReportData>[].obs;
  final RxList<UserReportData> userReportList = <UserReportData>[].obs;
  final RxList<CustomerReportData> customerReportList =
      <CustomerReportData>[].obs;
  final RxList<WarehouseReportData> warehouseReportList =
      <WarehouseReportData>[].obs;
  final RxList<SupplierReportData> supplierReportList =
      <SupplierReportData>[].obs;
  final RxList<DiscountReportData> discountReportList =
      <DiscountReportData>[].obs;
  final RxList<TaxReportData> taxReportList = <TaxReportData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  final List<Map<String, dynamic>> reports = [
    {"icon": Icons.bar_chart, "title": "Sales Report"},
    {"icon": Icons.shopping_cart, "title": "Purchase Report"},
    {"icon": Icons.payment, "title": "Payment Report"},
    {"icon": Icons.inventory, "title": "Products Report"},
    {"icon": Icons.inventory_2, "title": "Stock Report"},
    {"icon": Icons.receipt_long, "title": "Expense Report"},
    {"icon": Icons.people, "title": "User Report"},
    {"icon": Icons.person, "title": "Customer Report"},
    {"icon": Icons.store, "title": "Warehouse Report"},
    {"icon": Icons.local_shipping, "title": "Supplier Report"},
    {"icon": Icons.discount, "title": "Discount Report"},
    {"icon": Icons.receipt, "title": "Tax Report"},
  ];

  Future<void> getSalesReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getSalesReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final SalesReportModel response =
            SalesReportModel.fromJson(jsonResponse.data!);
        salesReportList.clear();
        salesReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch sales reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching sales reports');
    }
  }

  Future<void> getPurchaseReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getPurchaseReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final PurchaseReportModel response =
            PurchaseReportModel.fromJson(jsonResponse.data!);
        purchaseReportList.clear();
        purchaseReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch purchase reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching purchase reports');
    }
  }

  Future<void> getPaymentReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getPaymentReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final PaymentReportModel response =
            PaymentReportModel.fromJson(jsonResponse.data!);
        paymentReportList.clear();
        paymentReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch payment reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching payment reports');
    }
  }

  Future<void> getProductReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getProductReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final ProductReportModel response =
            ProductReportModel.fromJson(jsonResponse.data!);
        productReportList.clear();
        productReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch product reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching product reports');
    }
  }

  Future<void> getStockReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getStockReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final StockReportModel response =
            StockReportModel.fromJson(jsonResponse.data!);
        stockReportList.clear();
        stockReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch stock reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching stock reports');
    }
  }

  Future<void> getExpenseReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getExpenseReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final ExpenseReportModel response =
            ExpenseReportModel.fromJson(jsonResponse.data!);
        expenseReportList.clear();
        expenseReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch expense reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching expense reports');
    }
  }

  Future<void> getUserReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getUserReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final UserReportModel response =
            UserReportModel.fromJson(jsonResponse.data!);
        userReportList.clear();
        userReportList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch user reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching user reports');
    }
  }

  Future<void> getCustomerReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getCustomerReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final CustomerReportModel response =
            CustomerReportModel.fromJson(jsonResponse.data!);
        customerReportList.clear();
        customerReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch customer reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching customer reports');
    }
  }

  Future<void> getWarehouseReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getWarehouseReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final WarehouseReportModel response =
            WarehouseReportModel.fromJson(jsonResponse.data!);
        warehouseReportList.clear();
        warehouseReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch warehouse reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching warehouse reports');
    }
  }

  Future<void> getSupplierReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getSupplierReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final SupplierReportModel response =
            SupplierReportModel.fromJson(jsonResponse.data!);
        supplierReportList.clear();
        supplierReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch supplier reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching supplier reports');
    }
  }

  Future<void> getDiscountReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getDiscountReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final DiscountReportModel response =
            DiscountReportModel.fromJson(jsonResponse.data!);
        discountReportList.clear();
        discountReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch discount reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching discount reports');
    }
  }

  Future<void> getTaxReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getTaxReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final TaxReportModel response =
            TaxReportModel.fromJson(jsonResponse.data!);
        taxReportList.clear();
        taxReportList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch tax reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching tax reports');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/home/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchingController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final searchController = TextEditingController();
  final RxList<ProductsData> productList = <ProductsData>[].obs;
  final RxList<ProductsData> filteredProductList = <ProductsData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getAllProducts() async {
    isLoading.value = true;
    try {
      final url = await ApiPath.getProductsEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        productList.assignAll(response.data!);
        filteredProductList.assignAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching products');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }

  void searchProducts(String query) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    if (query.isEmpty) {
      filteredProductList.assignAll(productList);
    } else {
      filteredProductList.assignAll(
        productList.where(
          (product) =>
              product.title!.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
    isLoading.value = false;
  }
}

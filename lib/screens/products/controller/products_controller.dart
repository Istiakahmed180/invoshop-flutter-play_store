import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/categories_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/home/model/products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsController extends GetxController {
  late final SharedPreferences prefs;
  late final NetworkService _networkService;
  final TextEditingController searchController = TextEditingController();
  final CategoriesController categoriesController =
      Get.put(CategoriesController());
  final RxBool isLoading = false.obs;
  final RxBool isProductsLoading = false.obs;
  final RxInt selectedIndex = 0.obs;
  final RxList<ProductsData> productList = <ProductsData>[].obs;
  final RxList<ProductsData> filteredProductList = <ProductsData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await loadData();
  }

  void onCategorySelected(int index) {
    selectedIndex.value = index;
  }

  Future<void> loadData() async {
    isLoading.value = true;
    try {
      await categoriesController.getCategories();
      await getAllProducts();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllProducts() async {
    await _fetchProducts(ApiPath.getProductsEndpoint());
  }

  Future<void> getCategoryIdByProducts({required String categoryID}) async {
    await _fetchProducts(
        ApiPath.getCategoryIdByProductsEndpoint(categoryId: categoryID));
  }

  Future<void> _fetchProducts(Future<String> endpointFuture) async {
    isProductsLoading.value = true;
    try {
      final url = await endpointFuture;
      final jsonResponse = await _networkService.get(url);

      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        productList.assignAll(response.data!);
        filteredProductList.assignAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching products');
    } finally {
      isProductsLoading.value = false;
    }
  }

  void searchProducts(String query) async {
    isProductsLoading.value = true;
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
    isProductsLoading.value = false;
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

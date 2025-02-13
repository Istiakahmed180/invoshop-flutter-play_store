import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/brand/models/brands_model.dart';
import 'package:ai_store/screens/home/model/categories_model.dart';
import 'package:ai_store/screens/home/model/products_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PosController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxBool isProductsLoading = false.obs;
  final RxInt categoryId = 0.obs;
  final RxInt brandId = 0.obs;
  final RxString searchParameter = "".obs;
  final RxList<ProductsData> selectedItems = <ProductsData>[].obs;
  final RxList<ProductsData> productList = <ProductsData>[].obs;
  final RxList<BrandsData> brandList = <BrandsData>[].obs;
  final RxList<CategoriesData> categoriesList = <CategoriesData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  List<ProductsData> get filteredProducts {
    if (searchParameter.value.isEmpty) {
      return productList;
    }
    return productList.where((product) {
      return product.title!.toLowerCase().contains(
            searchParameter.value.toLowerCase(),
          );
    }).toList();
  }

  Future<void> getProducts() async {
    try {
      final url = await ApiPath.getProductsEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        productList.clear();
        productList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching products');
    }
  }

  Future<void> getCategories() async {
    try {
      final String url = await ApiPath.getCategoriesEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final CategoriesModel response =
            CategoriesModel.fromJson(jsonResponse.data!);
        categoriesList.clear();
        categoriesList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch categories');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching categories');
    }
  }

  Future<void> getBrands() async {
    try {
      final String url = await ApiPath.getBrandsEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final BrandsModel response = BrandsModel.fromJson(jsonResponse.data!);
        brandList.clear();
        brandList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch brands');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching brands');
    }
  }

  Future<void> getCategoryIdByProducts() async {
    isProductsLoading.value = true;
    try {
      final String url = await ApiPath.getCategoryIdByProductsEndpoint(
          categoryId: categoryId.toString());
      final jsonResponse = await _networkService.get(url);
      isProductsLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        selectedItems.clear();
        productList.clear();
        productList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      isProductsLoading.value = false;
      _showErrorToast('An error occurred while fetching products');
    }
  }

  Future<void> getBrandIdByProducts() async {
    isProductsLoading.value = true;
    try {
      final String url = await ApiPath.getBrandIdByProductsEndpoint(
          brandId: brandId.toString());
      final jsonResponse = await _networkService.get(url);
      isProductsLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        selectedItems.clear();
        productList.clear();
        productList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      isProductsLoading.value = false;
      _showErrorToast('An error occurred while fetching products');
    }
  }

  Future<void> getFeaturedProducts() async {
    isProductsLoading.value = true;
    try {
      final url = await ApiPath.getProductsEndpoint();
      final jsonResponse = await _networkService.get(url);
      isProductsLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        selectedItems.clear();
        productList.clear();
        for (var product in response.data!) {
          if (product.isFeatured == 1) {
            productList.add(product);
          }
        }
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      isProductsLoading.value = false;
      _showErrorToast('An error occurred while fetching products');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

import 'package:ai_store/common/controller/categories_controller.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/home/model/products_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final CategoriesController categoriesController =
      Get.find<CategoriesController>();
  final RxList<ProductsData> freshProductList = <ProductsData>[].obs;
  final RxList<ProductsData> specialOffersProductList = <ProductsData>[].obs;
  final RxList<ProductsData> newArrivalsProductList = <ProductsData>[].obs;
  final RxList<ProductsData> bestSellersProductList = <ProductsData>[].obs;
  final RxList<ProductsData> trendingProductList = <ProductsData>[].obs;
  final RxList<ProductsData> featuredProductList = <ProductsData>[].obs;
  final RxList<ProductsData> exclusiveAppOnlyProductList = <ProductsData>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  Future<void> _initializeController() async {
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    try {
      await categoriesController.getCategories();
      await getFreshProducts();
      await getSpecialOffersProducts();
      await getNewArrivalsProducts();
      await getBestSellersProducts();
      await getTrendingProducts();
      await getFeaturedProducts();
      await getExclusiveAppOnlyProducts();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFreshProducts() async {
    try {
      final String url =
          await ApiPath.getFreshProductsEndpoint(sectionType: "freshProducts");
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        freshProductList.clear();
        freshProductList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching fresh products');
    }
  }

  Future<void> getSpecialOffersProducts() async {
    try {
      final String url = await ApiPath.getSpecialOffersProductsEndpoint(
          sectionType: "specialOffers");
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        specialOffersProductList.clear();
        specialOffersProductList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      _showErrorToast(
          'An error occurred while fetching special offers products');
    }
  }

  Future<void> getNewArrivalsProducts() async {
    try {
      final String url = await ApiPath.getNewArrivalsProductsEndpoint(
          sectionType: "newArrivals");
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        newArrivalsProductList.clear();
        newArrivalsProductList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching new arrivals products');
    }
  }

  Future<void> getBestSellersProducts() async {
    try {
      final String url = await ApiPath.getBestSellersProductsEndpoint(
          sectionType: "bestSellers");
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        bestSellersProductList.clear();
        bestSellersProductList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching best sellers products');
    }
  }

  Future<void> getTrendingProducts() async {
    try {
      final String url = await ApiPath.getTrendingProductsEndpoint(
          sectionType: "trendingProducts");
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        trendingProductList.clear();
        trendingProductList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching trending products');
    }
  }

  Future<void> getFeaturedProducts() async {
    try {
      final String url = await ApiPath.getFeaturedProductsEndpoint(
          sectionType: "featuredProducts");
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        featuredProductList.clear();
        featuredProductList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching featured products');
    }
  }

  Future<void> getExclusiveAppOnlyProducts() async {
    try {
      final String url = await ApiPath.getExclusiveAppOnlyProductsEndpoint(
          sectionType: "exclusiveAppOnly");
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        exclusiveAppOnlyProductList.clear();
        exclusiveAppOnlyProductList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch products');
      }
    } catch (e) {
      _showErrorToast(
          'An error occurred while fetching exclusive app only products');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

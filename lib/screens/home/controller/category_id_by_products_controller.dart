import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/home/model/products_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryIdByProductsController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<ProductsData> categoryIdByProductsList = <ProductsData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getCategoryIdByProducts(
      {String? categoryID,
      String? brandID,
      required String requestType}) async {
    isLoading.value = true;
    try {
      final String url = requestType == "Category"
          ? await ApiPath.getCategoryIdByProductsEndpoint(
              categoryId: categoryID.toString())
          : await ApiPath.getBrandIdByProductsEndpoint(
              brandId: brandID.toString());
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;

      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        categoryIdByProductsList.clear();
        categoryIdByProductsList.addAll(response.data!);
      } else {
        Fluttertoast.showToast(
          msg: jsonResponse.message ?? 'An error occurred',
          backgroundColor: AppColors.grocerySecondary,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
        msg: 'An error occurred',
        backgroundColor: AppColors.grocerySecondary,
      );
    }
  }
}

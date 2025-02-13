import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/constants/user_role.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/home/model/products_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAndVendorProductsController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<ProductsData> vendorProductList = <ProductsData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getAdminAndVendorProducts();
  }

  Future<void> getAdminAndVendorProducts() async {
    isLoading.value = true;
    try {
      final String? userRole = prefs.getString("user_role");
      final String? supplierId = prefs.getString("supplier_id");
      final String url = userRole == UserRole.vendor
          ? await ApiPath.getVendorProductsEndpoint(
              supplierId: supplierId.toString())
          : await ApiPath.getAdminProductsEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final ProductsModel response =
            ProductsModel.fromJson(jsonResponse.data!);
        vendorProductList.clear();
        vendorProductList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch vendor products');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching vendor products');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

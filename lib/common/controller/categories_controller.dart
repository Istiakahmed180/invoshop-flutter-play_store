import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/home/model/categories_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxInt categoryID = 0.obs;
  final RxList<CategoriesData> categoriesList = <CategoriesData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> loadCategory() async {
    isLoading.value = true;
    await getCategories();
    isLoading.value = false;
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

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

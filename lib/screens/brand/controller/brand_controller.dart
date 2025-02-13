import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/brand/models/brands_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrandController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<BrandsData> brandList = <BrandsData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    getBrands();
  }

  Future<void> getBrands() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getBrandsEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final BrandsModel response = BrandsModel.fromJson(jsonResponse.data!);
        brandList.clear();
        brandList.addAll(response.data!);
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

import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/vendor_reviews/model/vendor_review_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorReviewsController extends GetxController {
  late SharedPreferences preferences;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<VendorReviewData> reviewsList = <VendorReviewData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    preferences = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: preferences);
    await getVendorReview();
  }

  Future<void> getVendorReview() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getProduceReviewsEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final VendorReviewModel response =
            VendorReviewModel.fromJson(jsonResponse.data!);
        reviewsList.clear();
        reviewsList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch products review');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching products review');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

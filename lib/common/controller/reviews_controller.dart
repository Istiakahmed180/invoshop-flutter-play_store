import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/reviews/model/review_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewsController extends GetxController {
  late SharedPreferences preferences;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<ReviewData> reviewsList = <ReviewData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    preferences = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: preferences);
    await getReviews();
  }

  Future<void> getReviews() async {
    isLoading.value = true;
    final String? userId = preferences.getString("user_id");
    try {
      final String url =
          await ApiPath.getProduceReviewsEndpoint(userId: userId.toString());
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final ReviewModel response = ReviewModel.fromJson(jsonResponse.data!);
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

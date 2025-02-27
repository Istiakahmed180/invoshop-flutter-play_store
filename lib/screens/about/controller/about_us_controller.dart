import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/about/model/about_us_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUsController extends GetxController {
  final RxBool isLoading = false.obs;
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final Rx<AboutUsModel> aboutUsModel = AboutUsModel().obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getAboutUsContent();
  }

  Future<void> getAboutUsContent() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getAboutUsContentEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final AboutUsModel response = AboutUsModel.fromJson(jsonResponse.data!);
        aboutUsModel.value = response;
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch about us content');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching about us content');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

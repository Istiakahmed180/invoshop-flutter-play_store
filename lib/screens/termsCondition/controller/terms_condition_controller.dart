import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/termsCondition/model/privacy_policy_model.dart';
import 'package:invoshop/screens/termsCondition/model/terms_and_condition_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsConditionController extends GetxController {
  final RxBool isLoading = false.obs;
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxInt selectedTab = 0.obs;
  final Rx<PrivacyPolicyModel> privacyPolicyModel = PrivacyPolicyModel().obs;
  final Rx<TermsAndConditionModel> termsAndConditionModel =
      TermsAndConditionModel().obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getPrivacyPolicyContent() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getPrivacyPolicyEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final PrivacyPolicyModel response =
            PrivacyPolicyModel.fromJson(jsonResponse.data!);
        privacyPolicyModel.value = response;
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch privacy policy content');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast(
          'An error occurred while fetching privacy policy content');
    }
  }

  Future<void> getTermsAndConditionContent() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getTermsAndConditionEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final TermsAndConditionModel response =
            TermsAndConditionModel.fromJson(jsonResponse.data!);
        termsAndConditionModel.value = response;
      } else {
        _showErrorToast(jsonResponse.message ??
            'Failed to fetch terms and condition content');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast(
          'An error occurred while fetching terms and condition content');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

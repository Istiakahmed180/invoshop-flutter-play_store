import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/model/settings_model.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final Rx<SettingsModel> settingsModel = SettingsModel().obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> loadSettings() async {
    try {
      isLoading.value = true;
      await getSettings();
    } catch (e) {
      _showErrorToast('An error occurred while loading settings');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSettings() async {
    try {
      final String url = await ApiPath.getSettingsEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final SettingsModel response =
            SettingsModel.fromJson(jsonResponse.data!);
        settingsModel.value = response;
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch settings');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching settings');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

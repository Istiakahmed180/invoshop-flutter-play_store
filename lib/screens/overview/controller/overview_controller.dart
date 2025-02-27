import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/overview/model/overview_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OverviewController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  late OverviewModel overviewModel = OverviewModel();

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getOverview();
  }

  Future<void> getOverview() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getOverviewEndpoint();
      final response = await _networkService.get(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        final OverviewModel responseDate =
            OverviewModel.fromJson(response.data!);
        overviewModel = responseDate;
      } else {
        _showErrorToast(response.message ?? 'Failed to fetch overview');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching overview');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

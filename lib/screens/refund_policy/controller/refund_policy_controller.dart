import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/refund_policy/views/model/refund_policy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefundPolicyController extends GetxController {
  final RxBool isLoading = false.obs;
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final Rx<RefundPolicyModel> refundPolicyModel = RefundPolicyModel().obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getRefundPolicyContent();
  }

  Future<void> getRefundPolicyContent() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getRefundPolicyEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final RefundPolicyModel response =
            RefundPolicyModel.fromJson(jsonResponse.data!);
        refundPolicyModel.value = response;
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch refund policy content');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching refund policy content');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

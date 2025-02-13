import 'package:ai_store/common/model/roles_model.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRoleController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<RolesData> rolesList = <RolesData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getRoles() async {
    try {
      final String url = await ApiPath.getRolesEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final RolesModel response = RolesModel.fromJson(jsonResponse.data!);
        rolesList.clear();
        rolesList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch roles');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching roles');
    }
  }

  Future<void> loadData() async {
    isLoading.value = true;
    await getRoles();
    isLoading.value = false;
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

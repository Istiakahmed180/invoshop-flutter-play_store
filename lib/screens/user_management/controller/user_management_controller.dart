import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/user_management/model/users_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManagementController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<UsersData> usersList = <UsersData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getUsers() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getUsersEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final UsersModes response = UsersModes.fromJson(jsonResponse.data!);
        usersList.clear();
        usersList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch users');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching users');
    }
  }

  Future<void> deleteUser({required String userId}) async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.deleteUserEndpoint(userId: userId);
      final response = await _networkService.delete(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "User delete successfully",
            backgroundColor: AppColors.groceryPrimary);
        await getUsers();
      } else {
        _showErrorToast(response.message ?? 'Failed to delete user');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while deleting user');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

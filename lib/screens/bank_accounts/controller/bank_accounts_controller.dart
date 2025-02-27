import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/bank_accounts/model/bank_account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankAccountsController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<BankAccountData> bankAccountList = <BankAccountData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getBankAccounts();
  }

  Future<void> getBankAccounts() async {
    isLoading.value = true;
    try {
      final String? supplierId = prefs.getString("supplier_id");
      final String url = await ApiPath.getBankAccountsEndpoint(
          supplierId: supplierId.toString());
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final BankAccountModel response =
            BankAccountModel.fromJson(jsonResponse.data!);
        bankAccountList.clear();
        bankAccountList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch bank accounts');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching bank accounts');
    }
  }

  Future<void> deleteBankAccount({required String bankId}) async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.deleteBankAccountEndpoint(bankId: bankId);
      final response = await _networkService.delete(url);
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Bank delete successfully",
            backgroundColor: AppColors.groceryPrimary);
        await getBankAccounts();
      } else {
        _showErrorToast(response.message ?? 'Failed to delete bank account');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while deleting bank account');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

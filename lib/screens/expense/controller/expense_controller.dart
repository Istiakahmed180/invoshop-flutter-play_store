import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/expense/model/expense_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<ExpenseData> expenseList = <ExpenseData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getExpenses();
  }

  Future<void> getExpenses() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getExpensesEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final ExpenseModel response = ExpenseModel.fromJson(jsonResponse.data!);
        expenseList.clear();
        expenseList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch expenses');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching expenses');
    }
  }

  Future<void> deleteExpenses({required String expenseId}) async {
    isLoading.value = true;
    try {
      final String url =
          await ApiPath.deleteExpensesEndpoint(expenseId: expenseId);
      final response = await _networkService.delete(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Expense delete successfully",
            backgroundColor: AppColors.grocerySecondary);
        await getExpenses();
      } else {
        _showErrorToast(response.message ?? 'Failed to delete expenses');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while deleting expenses');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

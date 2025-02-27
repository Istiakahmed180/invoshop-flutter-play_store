import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/report/model/sales_report_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaleController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<SalesReportData> salesReportList = <SalesReportData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getSalesReports() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getSalesReportEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final SalesReportModel response =
            SalesReportModel.fromJson(jsonResponse.data!);
        salesReportList.clear();
        salesReportList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch sales reports');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching sales reports');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

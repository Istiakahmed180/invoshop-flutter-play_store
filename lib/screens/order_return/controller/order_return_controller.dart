import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/constants/user_role.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/order_return/model/order_return_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderReturnController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<OrderReturnData> orderReturnList = <OrderReturnData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getOrderReturns();
  }

  Future<void> getOrderReturns() async {
    isLoading.value = true;
    try {
      final String? userRole = prefs.getString("user_role");
      final String? supplierId = prefs.getString("supplier_id");
      final String? customerId = prefs.getString("customer_id");
      final String url = userRole == UserRole.vendor
          ? await ApiPath.getVendorOrderReturnsEndpoint(
              supplierId: supplierId.toString())
          : await ApiPath.getCustomerOrderReturnsEndpoint(
              customerId: customerId.toString());
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final OrderReturnModel response =
            OrderReturnModel.fromJson(jsonResponse.data!);
        orderReturnList.clear();
        orderReturnList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch order returns');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching order returns');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

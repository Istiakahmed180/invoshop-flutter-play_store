import 'package:get/get.dart';
import 'package:invoshop/common/controller/shared_preference_service.dart';

class CurrencyController extends GetxController {
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  var currencyName = ''.obs;
  var currencySymbol = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrencyInfo();
  }

  Future<void> fetchCurrencyInfo() async {
    currencyName.value =
        await sharedPreferencesService.getCurrencyName() ?? 'USD';
    currencySymbol.value =
        await sharedPreferencesService.getCurrencySymbol() ?? '\$';
  }
}

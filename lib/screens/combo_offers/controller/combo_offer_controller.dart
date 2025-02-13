import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/combo_offers/model/combo_offer_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComboOfferController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;
  final RxList<ComboOfferData> comboOfferList = <ComboOfferData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    await getComboOffers();
  }

  Future<void> getComboOffers() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getComboOfferEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final ComboOfferModel response =
            ComboOfferModel.fromJson(jsonResponse.data!);
        comboOfferList.clear();
        comboOfferList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch combo offers');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching combo offers');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }
}

import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/network/response/status.dart';
import 'package:ai_store/network/services/network_services.dart';
import 'package:ai_store/screens/authentication/find_supplier/model/find_supplier_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindSupplierController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;

  final RxInt districtId = 0.obs;
  final List<DistrictData> districtList = <DistrictData>[].obs;

  final RxInt areaId = 0.obs;
  final List<AreaData> areaList = <AreaData>[].obs;

  final RxString supplierKey = "".obs;
  final List<SupplierData> supplierList = <SupplierData>[].obs;

  @override
  onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    getDistrict();
  }

  Future<void> getDistrict() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getDistrictEndpoint(countryID: "1");
      final response = await _networkService.authGet(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        final responseData = DistrictModel.fromJson(response.data!);
        districtList.clear();
        districtList.addAll(responseData.data!);
      } else {
        Fluttertoast.showToast(
          msg: response.message ?? 'An error occurred',
          backgroundColor: AppColors.grocerySecondary,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
        msg: 'An error occurred',
        backgroundColor: AppColors.grocerySecondary,
      );
    }
  }

  Future<void> getArea() async {
    try {
      isLoading.value = true;
      final String url =
          await ApiPath.getAreaEndpoint(districtID: districtId.toString());
      final response = await _networkService.authGet(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        final responseData = AreaModel.fromJson(response.data!);
        areaList.clear();
        areaList.addAll(responseData.data!);
      } else {
        Fluttertoast.showToast(
          msg: response.message ?? 'An error occurred',
          backgroundColor: AppColors.grocerySecondary,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
        msg: 'An error occurred',
        backgroundColor: AppColors.grocerySecondary,
      );
    }
  }

  Future<void> getSupplier() async {
    try {
      isLoading.value = true;
      final String url =
          await ApiPath.getSupplierEndpoint(areaID: areaId.toString());
      final response = await _networkService.authGet(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        final responseData = SupplierModel.fromJson(response.data!);
        supplierList.clear();
        supplierList.addAll(responseData.data!);
      } else {
        Fluttertoast.showToast(
          msg: response.message ?? 'An error occurred',
          backgroundColor: AppColors.grocerySecondary,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
        msg: 'An error occurred',
        backgroundColor: AppColors.grocerySecondary,
      );
    }
  }

  Future<void> submitSupplierVerify() async {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('supplier_key', supplierKey.toString());
      Get.offNamed(BaseRoute.signIn);
      resetFields();
      isLoading.value = false;
    });
  }

  void resetFields() {
    districtId.value = 0;
    districtList.clear();

    areaId.value = 0;
    areaList.clear();

    supplierKey.value = "";
    supplierList.clear();
  }
}

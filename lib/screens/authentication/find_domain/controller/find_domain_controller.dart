import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/authentication/find_domain/model/find_domain_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindDomainController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = false.obs;

  final RxInt districtId = 0.obs;
  final List<DistrictData> districtList = <DistrictData>[].obs;

  final RxInt areaId = 0.obs;
  final List<AreaData> areaList = <AreaData>[].obs;

  final RxString domainKey = "".obs;
  final RxString domainName = "".obs;
  final RxInt domainId = 0.obs;
  final List<DomainData> domainList = <DomainData>[].obs;

  @override
  onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
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

  Future<void> getDomain() async {
    try {
      isLoading.value = true;
      final String url = await ApiPath.getSupplierEndpoint();
      final response = await _networkService.authGet(url);
      isLoading.value = false;
      if (response.status == Status.completed) {
        final responseData = DomainModel.fromJson(response.data!);
        domainList.clear();
        domainList.addAll(responseData.data!);
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

  Future<void> submitDomainVerify() async {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('domain_key', domainKey.toString());
      await prefs.setString('domain_name', domainName.toString());
      await prefs.setString('domain_id', domainId.toString());
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

    domainKey.value = "";
    domainId.value = 0;
    domainName.value = "";
    domainList.clear();
  }
}

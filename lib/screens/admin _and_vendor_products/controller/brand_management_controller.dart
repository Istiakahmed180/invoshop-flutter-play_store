import 'package:invoshop/common/controller/camara_controller.dart';
import 'package:invoshop/common/controller/gallery_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/api_response.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/brand/models/brands_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrandManagementController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final RxBool isBrandsLoading = false.obs;
  final CameraAccessController cameraAccessController =
      Get.put(CameraAccessController());
  final GalleryAccessController galleryAccessController =
      Get.put(GalleryAccessController());
  final addBrandNameController = TextEditingController();
  final editBrandNameController = TextEditingController();
  final RxList<BrandsData> brandList = <BrandsData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getBrands() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getBrandsEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final BrandsModel response = BrandsModel.fromJson(jsonResponse.data!);
        brandList.clear();
        brandList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch brands');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching brands');
    }
  }

  Future<void> postCreateBrand() async {
    isBrandsLoading.value = true;
    final Map<String, String> requestBody = {
      "title": addBrandNameController.text.trim(),
    };

    String? filePath;
    if (cameraAccessController.selectedFilePath.value != null) {
      filePath = cameraAccessController.selectedFilePath.value!.path;
    } else if (galleryAccessController.selectedFilePath.value != null) {
      filePath = galleryAccessController.selectedFilePath.value!.path;
    }

    final ApiResponse<Map<String, dynamic>> response;
    Get.back();
    if (filePath != null) {
      response = await _networkService.postMultipart(
        url: await ApiPath.postCreateBrandEndpoint(),
        fields: requestBody,
        fileField: "brand_image",
        filePath: filePath,
      );
    } else {
      response = await _networkService.post(
        await ApiPath.postCreateBrandEndpoint(),
        requestBody,
      );
    }

    isBrandsLoading.value = false;

    if (response.status == Status.completed) {
      Fluttertoast.showToast(
          msg: "Brand create successfully!",
          backgroundColor: AppColors.groceryPrimary);
      createResetFields();
      await getBrands();
    } else {
      _showErrorToast(response.message ?? 'Failed to create brand');
    }
  }

  Future<void> deleteBrand({required String brandId}) async {
    isBrandsLoading.value = true;
    try {
      final String url = await ApiPath.deleteBrandEndpoint(brandId: brandId);
      final response = await _networkService.delete(url);
      isBrandsLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Brand delete successfully!",
            backgroundColor: AppColors.groceryPrimary);
        await getBrands();
      } else {
        _showErrorToast(
            response.data!["message"] ?? 'Failed to deleting brand');
      }
    } catch (e) {
      isBrandsLoading.value = false;
      _showErrorToast('An error occurred while deleting brand');
    }
  }

  Future<void> postUpdateBrand({required String brandId}) async {
    isBrandsLoading.value = true;
    final Map<String, String> requestBody = {
      "title": editBrandNameController.text.trim(),
      "_method": "PUT",
    };

    String? filePath;
    if (cameraAccessController.selectedFilePath.value != null) {
      filePath = cameraAccessController.selectedFilePath.value!.path;
    } else if (galleryAccessController.selectedFilePath.value != null) {
      filePath = galleryAccessController.selectedFilePath.value!.path;
    }

    final ApiResponse<Map<String, dynamic>> response;
    Get.back();
    if (filePath != null) {
      response = await _networkService.postMultipart(
        url: await ApiPath.postBrandUpdateEndpoint(brandId: brandId),
        fields: requestBody,
        fileField: "brand_image",
        filePath: filePath,
      );
    } else {
      response = await _networkService.post(
        await ApiPath.postBrandUpdateEndpoint(brandId: brandId),
        requestBody,
      );
    }

    isBrandsLoading.value = false;

    if (response.status == Status.completed) {
      Fluttertoast.showToast(
          msg: "Brand update successfully!",
          backgroundColor: AppColors.groceryPrimary);
      editResetFields();
      await getBrands();
    } else {
      _showErrorToast(response.message ?? 'Failed to update brand');
    }
  }

  void createResetFields() {
    addBrandNameController.clear();
    cameraAccessController.clearFile();
    galleryAccessController.clearFile();
  }

  void editResetFields() {
    editBrandNameController.clear();
    cameraAccessController.clearFile();
    galleryAccessController.clearFile();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }

  @override
  void onClose() {
    super.onClose();
    addBrandNameController.dispose();
    editBrandNameController.dispose();
  }
}

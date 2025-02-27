import 'package:invoshop/common/controller/camara_controller.dart';
import 'package:invoshop/common/controller/gallery_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/api_response.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/home/model/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryManagementController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final RxBool isCategoriesLoading = false.obs;
  final RxInt parentCategoryId = 0.obs;
  final RxString categoryType = "".obs;
  final CameraAccessController cameraAccessController =
      Get.put(CameraAccessController());
  final GalleryAccessController galleryAccessController =
      Get.put(GalleryAccessController());
  final addCategoryNameController = TextEditingController();
  final editCategoryNameController = TextEditingController();
  final RxList<CategoriesData> categoriesList = <CategoriesData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
  }

  Future<void> getCategories() async {
    isLoading.value = true;
    try {
      final String url = await ApiPath.getCategoriesEndpoint();
      final jsonResponse = await _networkService.get(url);
      isLoading.value = false;
      if (jsonResponse.status == Status.completed) {
        final CategoriesModel response =
            CategoriesModel.fromJson(jsonResponse.data!);
        categoriesList.clear();
        categoriesList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch categories');
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorToast('An error occurred while fetching categories');
    }
  }

  Future<void> postCreateCategory() async {
    isCategoriesLoading.value = true;
    final Map<String, String> requestBody = {
      "parent_id": parentCategoryId.toString(),
      "type": categoryType.toString(),
      "title": addCategoryNameController.text.trim(),
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
        url: await ApiPath.postCreateCategoryEndpoint(),
        fields: requestBody,
        fileField: "category_image",
        filePath: filePath,
      );
    } else {
      response = await _networkService.post(
        await ApiPath.postCreateCategoryEndpoint(),
        requestBody,
      );
    }

    isCategoriesLoading.value = false;

    if (response.status == Status.completed) {
      Fluttertoast.showToast(
          msg: "Category create successfully!",
          backgroundColor: AppColors.groceryPrimary);
      createResetFields();
      await getCategories();
    } else {
      _showErrorToast(response.message ?? 'Failed to create category');
    }
  }

  Future<void> deleteCategory({required String categoryId}) async {
    isCategoriesLoading.value = true;
    try {
      final String url =
          await ApiPath.deleteCategoryEndpoint(categoryId: categoryId);
      final response = await _networkService.delete(url);
      isCategoriesLoading.value = false;
      if (response.status == Status.completed) {
        Fluttertoast.showToast(
            msg: "Category delete successfully!",
            backgroundColor: AppColors.groceryPrimary);
        await getCategories();
      } else {
        _showErrorToast(
            response.data!["message"] ?? 'Failed to deleting category');
      }
    } catch (e) {
      isCategoriesLoading.value = false;
      _showErrorToast('An error occurred while deleting category');
    }
  }

  Future<void> postUpdateBrand({required String categoryId}) async {
    isCategoriesLoading.value = true;
    final Map<String, String> requestBody = {
      "parent_id": parentCategoryId.toString(),
      "type": categoryType.toString(),
      "title": editCategoryNameController.text.trim(),
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
        url: await ApiPath.postUpdateCategoryEndpoint(categoryId: categoryId),
        fields: requestBody,
        fileField: "category_image",
        filePath: filePath,
      );
    } else {
      response = await _networkService.post(
        await ApiPath.postUpdateCategoryEndpoint(categoryId: categoryId),
        requestBody,
      );
    }

    isCategoriesLoading.value = false;

    if (response.status == Status.completed) {
      Fluttertoast.showToast(
          msg: "Category update successfully!",
          backgroundColor: AppColors.groceryPrimary);
      editResetFields();
      await getCategories();
    } else {
      _showErrorToast(response.message ?? 'Failed to update Category');
    }
  }

  void createResetFields() {
    categoryType.value = "";
    parentCategoryId.value = 0;
    addCategoryNameController.clear();
    cameraAccessController.clearFile();
    galleryAccessController.clearFile();
  }

  void editResetFields() {
    categoryType.value = "";
    parentCategoryId.value = 0;
    editCategoryNameController.clear();
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
    addCategoryNameController.dispose();
    editCategoryNameController.dispose();
  }
}

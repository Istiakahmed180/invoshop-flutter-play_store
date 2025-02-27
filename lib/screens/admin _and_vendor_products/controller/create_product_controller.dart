import 'dart:math';

import 'package:invoshop/common/controller/camara_controller.dart';
import 'package:invoshop/common/controller/gallery_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/network/response/api_response.dart';
import 'package:invoshop/network/response/status.dart';
import 'package:invoshop/network/services/network_services.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/controller/admin_and_vendor_products_controller.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/model/color_variants_model.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/model/product_type_model.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/model/size_variants_model.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/model/tax_model.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/model/unit_model.dart';
import 'package:invoshop/screens/brand/models/brands_model.dart';
import 'package:invoshop/screens/home/model/categories_model.dart';
import 'package:invoshop/screens/supplier/model/suppliers_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProductController extends GetxController {
  late SharedPreferences prefs;
  late NetworkService _networkService;
  final RxBool isLoading = true.obs;
  final CameraAccessController cameraAccessController =
      Get.put(CameraAccessController());
  final GalleryAccessController galleryAccessController =
      Get.put(GalleryAccessController());
  final AdminAndVendorProductsController adminAndVendorProductsController =
      Get.put(AdminAndVendorProductsController());
  final RxString discountType = "".obs;
  final RxString taxType = "".obs;
  final RxString taxMethod = "".obs;
  final RxInt colorVariantId = 0.obs;
  final RxInt sizeVariantId = 0.obs;
  final RxInt categoryId = 0.obs;
  final RxInt brandId = 0.obs;
  final RxInt supplierId = 0.obs;
  final RxInt productTypeId = 0.obs;
  final RxInt unitId = 0.obs;
  final RxInt taxId = 0.obs;
  final RxBool isFeatured = false.obs;
  final RxBool isPromotionalSale = false.obs;
  final Rx<DateTime> startDate = DateTime.now().obs;
  final Rx<DateTime> endDate = DateTime.now().obs;
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final discountController = TextEditingController();
  final taxAmountController = TextEditingController();
  final promotionalPriceController = TextEditingController();
  final RxList<ColorVariantsData> colorVariantList = <ColorVariantsData>[].obs;
  final RxList<SizeVariantsData> sizeVariantList = <SizeVariantsData>[].obs;
  final RxList<CategoriesData> categoriesList = <CategoriesData>[].obs;
  final RxList<BrandsData> brandList = <BrandsData>[].obs;
  final RxList<SuppliersData> supplierList = <SuppliersData>[].obs;
  final RxList<ProductTypeData> productTypeList = <ProductTypeData>[].obs;
  final RxList<UnitData> unitList = <UnitData>[].obs;
  final RxList<TaxData> taxList = <TaxData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _networkService = NetworkService(prefs: prefs);
    generateProductCode();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    await getColorVariants();
    await getSizeVariants();
    await getCategories();
    await getBrands();
    await getSuppliers();
    await getProductType();
    await getUnits();
    await getTaxes();
    isLoading.value = false;
  }

  void generateProductCode() {
    final random = Random();
    const digits = '0123456789';
    const length = 6;
    String code =
        List.generate(length, (index) => digits[random.nextInt(digits.length)])
            .join();
    codeController.text = code;
  }

  Future<void> getColorVariants() async {
    try {
      final String url = await ApiPath.getColorVariantsEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final ColorVariantsModel response =
            ColorVariantsModel.fromJson(jsonResponse.data!);
        colorVariantList.clear();
        colorVariantList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch color variants');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching color variants');
    }
  }

  Future<void> getSizeVariants() async {
    try {
      final String url = await ApiPath.getSizeVariantsEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final SizeVariantsModel response =
            SizeVariantsModel.fromJson(jsonResponse.data!);
        sizeVariantList.clear();
        sizeVariantList.addAll(response.data!);
      } else {
        _showErrorToast(
            jsonResponse.message ?? 'Failed to fetch size variants');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching size variants');
    }
  }

  Future<void> getCategories() async {
    try {
      final String url = await ApiPath.getCategoriesEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final CategoriesModel response =
            CategoriesModel.fromJson(jsonResponse.data!);
        categoriesList.clear();
        categoriesList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch categories');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching categories');
    }
  }

  Future<void> getBrands() async {
    try {
      final String url = await ApiPath.getBrandsEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final BrandsModel response = BrandsModel.fromJson(jsonResponse.data!);
        brandList.clear();
        brandList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch brand');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching brands');
    }
  }

  Future<void> getSuppliers() async {
    try {
      final String url = await ApiPath.getSuppliersEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final SuppliersModel response =
            SuppliersModel.fromJson(jsonResponse.data!);
        supplierList.clear();
        supplierList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch suppliers');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching suppliers');
    }
  }

  Future<void> getProductType() async {
    try {
      final String url = await ApiPath.getProductTypesEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final ProductTypeModel response =
            ProductTypeModel.fromJson(jsonResponse.data!);
        productTypeList.clear();
        productTypeList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch product type');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching product types');
    }
  }

  Future<void> getUnits() async {
    try {
      final String url = await ApiPath.getUnitsEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final UnitModel response = UnitModel.fromJson(jsonResponse.data!);
        unitList.clear();
        unitList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch units');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching units');
    }
  }

  Future<void> getTaxes() async {
    try {
      final String url = await ApiPath.getTaxesEndpoint();
      final jsonResponse = await _networkService.get(url);
      if (jsonResponse.status == Status.completed) {
        final TaxModel response = TaxModel.fromJson(jsonResponse.data!);
        taxList.clear();
        taxList.addAll(response.data!);
      } else {
        _showErrorToast(jsonResponse.message ?? 'Failed to fetch tax');
      }
    } catch (e) {
      _showErrorToast('An error occurred while fetching tax');
    }
  }

  Future<void> postCreateProduct() async {
    isLoading.value = true;
    final Map<String, String> requestBody = {
      "supplierId": supplierId.value == 0 ? "" : supplierId.toString(),
      "brandId": brandId.value == 0 ? "" : brandId.toString(),
      "typeId": productTypeId.value == 0 ? "" : productTypeId.toString(),
      "taxId": taxId.value == 0 ? "" : taxId.toString(),
      "taxAmount": taxAmountController.text,
      "taxType": taxType.toString(),
      "unitId": unitId.value == 0 ? "" : unitId.toString(),
      "title": nameController.text,
      "quantity": quantityController.text,
      "price": priceController.text,
      "discount": discountController.text,
      "isFeatured": isFeatured.value ? "1" : "0",
      "isPromoSale": isPromotionalSale.value ? '1' : '0',
      "taxMethod": taxMethod.toString(),
      "discountType": discountType.toString(),
      "productCode": codeController.text,
      "promoPrice": promotionalPriceController.text,
      "promoStartAt": isPromotionalSale.value
          ? DateFormat("yyyy-MM-dd")
              .format(DateTime.parse(startDate.toString()))
          : "",
      "promoEndAt": isPromotionalSale.value
          ? DateFormat("yyyy-MM-dd").format(DateTime.parse(endDate.toString()))
          : "",
      "status": "Active",
      "categoryId": categoryId.value == 0 ? "" : categoryId.toString(),
      "colorVariantId":
          colorVariantId.value == 0 ? "" : colorVariantId.toString(),
      "sizeVariantId": sizeVariantId.value == 0 ? "" : sizeVariantId.toString(),
    };

    String? filePath;
    if (cameraAccessController.selectedFilePath.value != null) {
      filePath = cameraAccessController.selectedFilePath.value!.path;
    } else if (galleryAccessController.selectedFilePath.value != null) {
      filePath = galleryAccessController.selectedFilePath.value!.path;
    }
    final ApiResponse<Map<String, dynamic>> response;
    if (filePath != null) {
      response = await _networkService.postMultipart(
        url: await ApiPath.postCreateProductEndpoint(),
        fields: requestBody,
        fileField: "productFile",
        filePath: filePath,
      );
    } else {
      response = await _networkService.post(
        await ApiPath.postCreateProductEndpoint(),
        requestBody,
      );
    }
    isLoading.value = false;
    if (response.status == Status.completed) {
      Fluttertoast.showToast(
          msg: "Product created successfully!",
          backgroundColor: AppColors.groceryPrimary);
      Get.back();
      resetFields();
      await adminAndVendorProductsController.getAdminAndVendorProducts();
    } else {
      Fluttertoast.showToast(
          msg: response.message ?? 'Failed to create product',
          backgroundColor: AppColors.grocerySecondary);
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grocerySecondary,
    );
  }

  void resetFields() {
    nameController.clear();
    codeController.clear();
    priceController.clear();
    quantityController.clear();
    discountController.clear();
    taxAmountController.clear();
    promotionalPriceController.clear();
    discountType.value = "";
    taxType.value = "";
    taxMethod.value = "";
    colorVariantId.value = 0;
    sizeVariantId.value = 0;
    categoryId.value = 0;
    brandId.value = 0;
    supplierId.value = 0;
    productTypeId.value = 0;
    unitId.value = 0;
    isFeatured.value = false;
    isPromotionalSale.value = false;
    startDate.value = DateTime.now();
    endDate.value = DateTime.now();
    cameraAccessController.clearFile();
    galleryAccessController.clearFile();
    generateProductCode();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    codeController.dispose();
    priceController.dispose();
    quantityController.dispose();
    discountController.dispose();
    taxAmountController.dispose();
    promotionalPriceController.dispose();
  }
}

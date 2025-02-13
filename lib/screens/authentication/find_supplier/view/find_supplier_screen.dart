import 'package:ai_store/common/widgets/alert_dialog/custom_exit_confirmation_dialog.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/authentication/find_supplier/controller/find_supplier_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FindSupplierScreen extends StatefulWidget {
  const FindSupplierScreen({super.key});

  @override
  State<FindSupplierScreen> createState() => _FindSupplierScreenState();
}

class _FindSupplierScreenState extends State<FindSupplierScreen> {
  final FindSupplierController findSupplierController =
      Get.put(FindSupplierController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool _, __) async {
        _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.groceryPrimary,
                    AppColors.grocerySecondary
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(context),
                  SizedBox(height: 20.h),
                  _buildForm(),
                  SizedBox(height: 20.h),
                  _buildFooter(),
                ],
              ),
            ),
            Obx(
              () => Visibility(
                visible: findSupplierController.isLoading.value,
                child: const CustomLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: Image.asset(
        "assets/logos/logo_white.png",
        width: MediaQuery.of(context).size.width * 0.5,
      ),
    );
  }

  Widget _buildForm() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 10,
      shadowColor: AppColors.groceryPrimary.withOpacity(0.3),
      color: AppColors.groceryBody,
      child: Padding(
        padding: REdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Obx(
                () => _buildDropdownField(
                  hintText: "Select District",
                  validatorText: "District",
                  dropdownItems: findSupplierController.districtList.isEmpty
                      ? ["District Not Found"]
                      : findSupplierController.districtList
                          .where((district) => district.title != null)
                          .map((district) => district.title!)
                          .toList(),
                  onChanged: (String? value) async {
                    findSupplierController.districtId.value = 0;
                    findSupplierController.districtId.value =
                        findSupplierController.districtList
                            .firstWhere((district) => district.title == value)
                            .id!;
                    await findSupplierController.getArea();
                  },
                  icon: Icons.location_city,
                ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => _buildDropdownField(
                  hintText: "Select Area",
                  validatorText: "Area",
                  dropdownItems: findSupplierController.areaList.isEmpty
                      ? ["Area Not Found"]
                      : findSupplierController.areaList
                          .where((area) => area.title != null)
                          .map((area) => area.title!)
                          .toList(),
                  onChanged: (String? value) async {
                    findSupplierController.areaId.value = 0;
                    findSupplierController.areaId.value = findSupplierController
                        .areaList
                        .firstWhere((area) => area.title == value)
                        .id!;
                    await findSupplierController.getSupplier();
                  },
                  icon: Icons.map,
                ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => _buildDropdownField(
                  hintText: "Select Supplier",
                  validatorText: "Supplier",
                  dropdownItems: findSupplierController.supplierList.isEmpty
                      ? ["Supplier Not Found"]
                      : findSupplierController.supplierList
                          .where((supplier) => supplier.storeName != null)
                          .map((supplier) => supplier.storeName!)
                          .toList(),
                  onChanged: (String? value) async {
                    findSupplierController.supplierKey.value = "";
                    findSupplierController.supplierKey.value =
                        findSupplierController.supplierList
                            .firstWhere(
                                (supplier) => supplier.storeName == value)
                            .supplierKey!;
                    findSupplierController.supplierList
                        .firstWhere((supplier) => supplier.storeName == value)
                        .id!;
                  },
                  icon: Icons.store,
                ),
              ),
              SizedBox(height: 10.h),
              _buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hintText,
    required String validatorText,
    required List<String> dropdownItems,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return CustomDropdownField(
      hintText: hintText,
      validatorText: validatorText,
      dropdownItems: dropdownItems,
      onChanged: onChanged,
      prefixIcon: Icon(
        icon,
        color: AppColors.groceryPrimary.withOpacity(0.7),
        size: 20,
      ),
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.maxFinite,
      child: CustomElevatedButton(
        buttonColor: AppColors.groceryPrimary,
        buttonName: "Verify",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            findSupplierController.submitSupplierVerify();
          }
        },
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(BaseRoute.becomeASeller),
          child: const Text(
            "Become a Seller",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.groceryWhite,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(width: 5.w),
        const Icon(
          Icons.arrow_forward,
          color: AppColors.groceryWhite,
          size: 18,
        ),
      ],
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const CustomExitConfirmationDialog(),
    ).then((value) => value ?? false);
  }
}

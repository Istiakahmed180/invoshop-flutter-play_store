import 'package:invoshop/common/widgets/alert_dialog/custom_exit_confirmation_dialog.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/authentication/find_domain/controller/find_domain_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FindDomainScreen extends StatefulWidget {
  const FindDomainScreen({super.key});

  @override
  State<FindDomainScreen> createState() => _FindDomainScreenState();
}

class _FindDomainScreenState extends State<FindDomainScreen> {
  final FindDomainController findDomainController =
      Get.put(FindDomainController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    findDomainController.getDomain();
  }

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
                visible: findDomainController.isLoading.value,
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
        "assets/logos/logo_bg.png",
        width: MediaQuery.of(context).size.width * 0.5,
      ),
    );
  }

  Widget _buildForm() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      shadowColor: AppColors.groceryPrimary.withOpacity(0.3),
      child: Padding(
        padding: REdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Obx(
              //   () => _buildDropdownField(
              //     hintText: "Select District",
              //     validatorText: "District",
              //     dropdownItems: findDomainController.districtList.isEmpty
              //         ? ["District Not Found"]
              //         : findDomainController.districtList
              //             .where((district) => district.title != null)
              //             .map((district) => district.title!)
              //             .toList(),
              //     onChanged: (String? value) async {
              //       findDomainController.districtId.value = 0;
              //       findDomainController.districtId.value = findDomainController
              //           .districtList
              //           .firstWhere((district) => district.title == value)
              //           .id!;
              //       await findDomainController.getArea();
              //     },
              //     icon: Icons.location_city,
              //   ),
              // ),
              // SizedBox(height: 10.h),
              // Obx(
              //   () => _buildDropdownField(
              //     hintText: "Select Area",
              //     validatorText: "Area",
              //     dropdownItems: findDomainController.areaList.isEmpty
              //         ? ["Area Not Found"]
              //         : findDomainController.areaList
              //             .where((area) => area.title != null)
              //             .map((area) => area.title!)
              //             .toList(),
              //     onChanged: (String? value) async {
              //       findDomainController.areaId.value = 0;
              //       findDomainController.areaId.value = findDomainController
              //           .areaList
              //           .firstWhere((area) => area.title == value)
              //           .id!;
              //       await findDomainController.getSupplier();
              //     },
              //     icon: Icons.map,
              //   ),
              // ),
              // SizedBox(height: 10.h),
              Obx(
                () => _buildDropdownField(
                  hintText: "Select Domain",
                  validatorText: "Domain",
                  dropdownItems: findDomainController.domainList.isEmpty
                      ? ["Domain Not Found"]
                      : findDomainController.domainList
                          .where((domain) => domain.storeName != null)
                          .map((domain) => domain.storeName!)
                          .toList(),
                  onChanged: (String? value) async {
                    final selectedDomain =
                        findDomainController.domainList.firstWhere(
                      (domain) => domain.storeName == value,
                    );

                    findDomainController.domainKey.value =
                        selectedDomain.supplierKey ?? "";
                    findDomainController.domainId.value =
                        selectedDomain.id ?? 0;
                    findDomainController.domainName.value =
                        selectedDomain.domainName ?? "";
                  },
                  icon: Icons.public,
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
            findDomainController.submitDomainVerify();
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
              color: Colors.black,
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

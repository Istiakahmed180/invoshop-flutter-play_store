import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/common_outline_button.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/custom_label_text.dart';
import 'package:ai_store/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/screens/payment/controller/edit_bank_account_controller.dart';
import 'package:ai_store/screens/payment/model/bank_account_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditBankAccountScreen extends StatefulWidget {
  const EditBankAccountScreen({super.key, required this.bankAccountData});

  final BankAccountData bankAccountData;

  @override
  State<EditBankAccountScreen> createState() => _EditBankAccountScreenState();
}

class _EditBankAccountScreenState extends State<EditBankAccountScreen> {
  final EditBankAccountController _controller =
      Get.put(EditBankAccountController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.accountNameController.text =
        widget.bankAccountData.accountName ?? "N/A";
    _controller.accountDisplayNameController.text =
        widget.bankAccountData.accountDisplayName ?? "N/A";
    _controller.accountNumberController.text =
        widget.bankAccountData.accountNo ?? "N/A";
    _controller.branchNameController.text =
        widget.bankAccountData.branchName ?? "N/A";
    _controller.branchAddressController.text =
        widget.bankAccountData.branchAddress ?? "N/A";
    _controller.bankId.value = widget.bankAccountData.bankId ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Add Bank Account"),
      body: Stack(
        children: [
          Padding(
            padding: REdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildFormField(
                      hintText: "Name",
                      label: "Account Name",
                      isRequired: true,
                      controller: _controller.accountNameController,
                    ),
                    SizedBox(height: 10.h),
                    _buildFormField(
                      hintText: "Display Name",
                      label: "Account Display Name",
                      isRequired: true,
                      controller: _controller.accountDisplayNameController,
                    ),
                    SizedBox(height: 10.h),
                    _buildFormField(
                      hintText: "Account No",
                      label: "Account No",
                      isRequired: true,
                      controller: _controller.accountNumberController,
                    ),
                    SizedBox(height: 10.h),
                    _buildFormField(
                      hintText: "Branch",
                      isRequired: true,
                      label: "Branch Name",
                      controller: _controller.branchNameController,
                    ),
                    SizedBox(height: 10.h),
                    Obx(
                      () => _buildDropdownField(
                        label: "Bank",
                        items: _controller.allBankList.isEmpty
                            ? ["Not Available"]
                            : _controller.allBankList
                                .map((item) => item.name as String)
                                .toList(),
                        onChanged: (value) {
                          _controller.bankId.value = _controller.allBankList
                                  .firstWhere((item) => item.name == value)
                                  .id ??
                              0;
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _buildFormField(
                      hintText: "Address...",
                      maxLines: 3,
                      label: "Branch Address",
                      controller: _controller.branchAddressController,
                    ),
                    SizedBox(height: 10.h),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
                visible: _controller.isLoading.value,
                child: const CustomLoading()),
          )
        ],
      ),
    );
  }

  Widget _buildFormField(
      {required String label,
      bool isRequired = false,
      required TextEditingController controller,
      int? maxLines,
      required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabelText(
          text: label,
          isRequired: isRequired,
        ),
        SizedBox(height: 5.h),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hintText),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return "Required this field";
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabelText(
          text: label,
          isRequired: true,
        ),
        SizedBox(height: 5.h),
        CustomDropdownField(
          validatorText: "Bank",
          dropdownItems: items,
          hintText: "Select $label",
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        CustomElevatedButton(
          buttonName: "Update",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _controller.postBankAccountEdit(
                  bankId: widget.bankAccountData.id.toString());
            }
          },
        ),
        SizedBox(width: 10.w),
        CustomOutlinedButton(
          buttonText: "Reset",
          onPressed: () {
            _formKey.currentState!.reset();
            _controller.resetForm();
          },
        ),
      ],
    );
  }
}

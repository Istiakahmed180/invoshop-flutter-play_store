import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/bank_accounts/controller/bank_accounts_controller.dart';
import 'package:invoshop/screens/bank_accounts/model/bank_account_model.dart';
import 'package:invoshop/screens/bank_accounts/view/bank_account/edit_bank_account_screen.dart';

class BankAccountsScreen extends StatelessWidget {
  const BankAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BankAccountsController bankAccountsController =
        Get.put(BankAccountsController());

    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Bank Accounts"),
      body: Obx(
        () => bankAccountsController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : RefreshIndicator(
                color: AppColors.groceryPrimary,
                onRefresh: () async {
                  await bankAccountsController.getBankAccounts();
                },
                child: Column(
                  children: [
                    _buildHeaderSection(),
                    Expanded(
                      child: bankAccountsController.bankAccountList.isNotEmpty
                          ? _buildAccountList(bankAccountsController)
                          : Center(
                              child: Text(
                                'No Accounts available',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color:
                                      AppColors.groceryPrimary.withOpacity(0.6),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h),
      child: SectionHeader(
        icon: Icons.food_bank_outlined,
        title: "Account List",
        backgroundColor: AppColors.groceryPrimary.withOpacity(0.7),
      ),
    );
  }

  Widget _buildAccountList(BankAccountsController paymentController) {
    return CustomScrollbar(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
        itemCount: paymentController.bankAccountList.length,
        itemBuilder: (context, index) {
          final BankAccountData bank = paymentController.bankAccountList[index];

          return BankAccountCard(
            account: BankAccount(
              paymentController: paymentController,
              bankAccountData: bank,
              bankName: bank.accountName ?? "N/A",
              displayName: bank.accountDisplayName ?? "N/A",
              accountNumber: bank.accountNo ?? "N/A",
              branchName: bank.branchName ?? "N/A",
              isPrimary: true,
            ),
            isLastItem: index == paymentController.bankAccountList.length - 1,
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.groceryPrimary,
      onPressed: () => Get.toNamed(BaseRoute.addNewBankAccount),
      child: const Icon(
        Icons.add_outlined,
        color: AppColors.groceryWhite,
        size: 30,
      ),
    );
  }
}

class BankAccountCard extends StatelessWidget {
  final BankAccount account;
  final bool isLastItem;

  const BankAccountCard({
    super.key,
    required this.account,
    required this.isLastItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: _buildCardDecoration(),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Card(
            elevation: 2,
            shape: _buildCardShape(),
            child: Padding(
              padding: EdgeInsets.all(12.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAccountInfo(),
                  SizedBox(width: 16.w),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          if (!isLastItem) _buildDivider(),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: AppColors.groceryWhite,
      border: Border(
        left: BorderSide(color: AppColors.groceryPrimary.withOpacity(0.3)),
        right: BorderSide(color: AppColors.groceryPrimary.withOpacity(0.3)),
        bottom: isLastItem
            ? BorderSide(color: AppColors.groceryPrimary.withOpacity(0.3))
            : BorderSide.none,
      ),
    );
  }

  ShapeBorder _buildCardShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.r),
      side: BorderSide(
        color: AppColors.groceryRatingGray.withOpacity(0.05),
        width: 1,
      ),
    );
  }

  Widget _buildAccountInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "${account.bankName} ",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.groceryTitle,
              ),
              children: [
                if (account.isPrimary)
                  TextSpan(
                    text: "(Primary Account)",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.groceryPrimary,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow("A/C Display Name", account.displayName),
          SizedBox(height: 8.h),
          _buildInfoRow("Account Number", account.accountNumber),
          SizedBox(height: 8.h),
          _buildInfoRow("Branch Name", account.branchName),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildIconButton(
          icon: Icons.edit_note,
          color: AppColors.groceryPrimary,
          tooltip: 'Edit Account',
          onPressed: () {
            Get.to(EditBankAccountScreen(
              bankAccountData: account.bankAccountData,
            ));
          },
        ),
        SizedBox(height: 8.h),
        _buildIconButton(
          icon: Icons.delete_outline,
          color: AppColors.grocerySecondary,
          tooltip: 'Delete Account',
          onPressed: () {
            account.paymentController.deleteBankAccount(
                bankId: account.bankAccountData.id.toString());
          },
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 20.r, color: color.withOpacity(0.5)),
      style: IconButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        padding: EdgeInsets.all(8.r),
      ),
      tooltip: tooltip,
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppColors.groceryPrimary.withOpacity(0.2),
      height: 0,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        text: "$label: ",
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.grocerySubTitle,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.groceryTitle,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

class CustomScrollbar extends StatelessWidget {
  final Widget child;

  const CustomScrollbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: AppColors.groceryPrimary.withOpacity(0.2),
      interactive: true,
      radius: Radius.circular(20.r),
      thickness: 15,
      trackVisibility: true,
      child: child,
    );
  }
}

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color backgroundColor;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
        child: Row(
          children: [
            Icon(icon, color: AppColors.groceryWhite, size: 18.w),
            SizedBox(width: 5.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.groceryWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BankAccount {
  final BankAccountsController paymentController;
  final String bankName;
  final String displayName;
  final String accountNumber;
  final String branchName;
  final bool isPrimary;
  final BankAccountData bankAccountData;

  BankAccount({
    required this.paymentController,
    required this.bankAccountData,
    required this.bankName,
    required this.displayName,
    required this.accountNumber,
    required this.branchName,
    this.isPrimary = false,
  });
}

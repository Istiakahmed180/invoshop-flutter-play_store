import 'package:ai_store/common/controller/bottom_navigation_controller.dart';
import 'package:ai_store/common/widgets/alert_dialog/custom_exit_confirmation_dialog.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/authentication/sign_in/controller/sign_in_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController _controller = Get.put(SignInController());
  final BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());
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
            SingleChildScrollView(
              padding: REdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  _buildHeader(),
                  SizedBox(height: 10.h),
                  _buildSignInForm(),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: _buildForgotPasswordLink(),
                  ),
                  _buildSignInButton(),
                  SizedBox(height: 10.h),
                  _buildDividerWithOr(),
                  SizedBox(height: 10.h),
                  _buildSignUpLink(),
                ],
              ),
            ),
            Obx(
              () => Visibility(
                visible: _controller.isLoading.value,
                child: const CustomLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/images/sign_up/sign_in.png',
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 15.h),
        Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.groceryTitle,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          "Sign in to continue",
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.grocerySubTitle,
          ),
        ),
      ],
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _controller.userNameController,
            hintText: "User Name",
            icon: Icons.person_outline,
            validator: _controller.requiredFieldValidator("User Name"),
          ),
          SizedBox(height: 10.h),
          Obx(
            () => _buildPasswordField(),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _controller.passwordController,
      validator: _controller.requiredFieldValidator("Password"),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: _controller.isPasswordVisible.value,
      style: TextStyle(fontSize: 12.sp),
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: const Icon(Icons.lock_outline, size: 20),
        suffixIcon: _buildPasswordVisibilityToggle(
          isVisible: _controller.isPasswordVisible.value,
          onPressed: () => _controller.isPasswordVisible.toggle(),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      style: TextStyle(fontSize: 12.sp),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, size: 20),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return TextButton(
      onPressed: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("supplier_key");
        Get.offNamed(BaseRoute.findSupplier);
      },
      child: Text(
        "Find Supplier?",
        style: TextStyle(
          color: AppColors.grocerySubTitle,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: CustomElevatedButton(
        buttonName: "Sign In",
        onPressed: _handleSignIn,
        buttonTextSize: 14,
        buttonColor: AppColors.groceryPrimary,
      ),
    );
  }

  Widget _buildDividerWithOr() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.groceryBorder,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "or",
            style: TextStyle(
              color: AppColors.grocerySubTitle,
              fontSize: 14.sp,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.groceryBorder,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(
            color: AppColors.grocerySubTitle,
            fontSize: 14.sp,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Sign up here',
              style: TextStyle(
                color: AppColors.groceryPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Get.toNamed(BaseRoute.signUp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordVisibilityToggle({
    required bool isVisible,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: AppColors.grocerySubTitle,
        size: 20,
      ),
    );
  }

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      _controller.submitSignIn();
      bottomNavigationController.onItemTapped(0);
    }
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const CustomExitConfirmationDialog(),
    ).then((value) => value ?? false);
  }
}

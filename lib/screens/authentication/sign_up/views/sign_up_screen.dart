import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/authentication/sign_up/controller/sign_up_controller.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _controller = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  _buildHeader(),
                  SizedBox(height: 10.h),
                  _buildSignUpForm(),
                  SizedBox(height: 10.h),
                  _buildDivider(),
                  SizedBox(height: 10.h),
                  _buildSignInLink(),
                  SizedBox(height: 20.h),
                ],
              ),
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
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: 50.h),
        Image.asset(
          'assets/images/sign_up/sign_up.png',
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 15.h),
        Text(
          "Let's Get Started!",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.groceryTitle,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          "Create an account to get all features",
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.grocerySubTitle,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _controller.firstNameController,
            hintText: "First Name",
            icon: Icons.person_outline,
            validator: _controller.requiredFieldValidator("First Name"),
          ),
          _buildSpacing(),
          _buildTextField(
            controller: _controller.lastNameController,
            hintText: "Last Name",
            icon: Icons.person_outline,
            validator: _controller.requiredFieldValidator("Last Name"),
          ),
          _buildSpacing(),
          _buildTextField(
            controller: _controller.emailController,
            hintText: "Email",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: _controller.emailValidator,
          ),
          _buildSpacing(),
          _buildTextField(
            controller: _controller.phoneController,
            hintText: "Phone",
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: _controller.requiredFieldValidator("Phone"),
          ),
          _buildSpacing(),
          _buildTextField(
            controller: _controller.userNameController,
            hintText: "User Name",
            icon: Icons.person_outline,
            validator: _controller.requiredFieldValidator("User Name"),
          ),
          _buildSpacing(),
          _buildGenderDropdown(),
          _buildSpacing(),
          _buildPasswordField(),
          _buildSpacing(),
          _buildConfirmPasswordField(),
          _buildSpacing(),
          _buildSignUpButton(),
        ],
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

  Widget _buildGenderDropdown() {
    return CustomDropdown(
      closedHeaderPadding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      expandedHeaderPadding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      validateOnChange: true,
      validator: _controller.requiredFieldValidator("Gender"),
      decoration: _dropdownDecoration(),
      hintText: "Gender",
      items: const ["Male", "Female", "Others"],
      onChanged: (value) => _controller.selectedGender.value = value ?? '',
    );
  }

  Widget _buildPasswordField() {
    return Obx(
      () => TextFormField(
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
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Obx(
      () => TextFormField(
        controller: _controller.confirmPasswordController,
        validator: _controller.passwordMatchValidator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: _controller.isConfirmPasswordVisible.value,
        style: TextStyle(fontSize: 12.sp),
        decoration: InputDecoration(
          hintText: "Confirm Password",
          prefixIcon: const Icon(Icons.lock_outline, size: 20),
          suffixIcon: _buildPasswordVisibilityToggle(
            isVisible: _controller.isConfirmPasswordVisible.value,
            onPressed: () => _controller.isConfirmPasswordVisible.toggle(),
          ),
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

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: CustomElevatedButton(
        buttonName: "Sign Up",
        onPressed: _handleSignUp,
        buttonTextSize: 14,
        buttonColor: AppColors.groceryPrimary,
      ),
    );
  }

  Widget _buildSignInLink() {
    return RichText(
      text: TextSpan(
        text: "Already have an account? ",
        style: TextStyle(
          color: AppColors.grocerySubTitle,
          fontSize: 14.sp,
        ),
        children: [
          TextSpan(
            text: 'Sign In',
            style: TextStyle(
              color: AppColors.groceryPrimary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.offAllNamed(BaseRoute.signIn),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.groceryBorder, thickness: 1),
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
          child: Divider(color: AppColors.groceryBorder, thickness: 1),
        ),
      ],
    );
  }

  CustomDropdownDecoration _dropdownDecoration() {
    return CustomDropdownDecoration(
      closedErrorBorderRadius: BorderRadius.circular(4),
      closedErrorBorder: Border.all(color: AppColors.errorColor),
      errorStyle: const TextStyle(
        color: AppColors.errorColor,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      expandedSuffixIcon: const Icon(
        Icons.keyboard_arrow_up_outlined,
        color: AppColors.grocerySubTitle,
        size: 20,
      ),
      closedSuffixIcon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.grocerySubTitle,
        size: 20,
      ),
      prefixIcon: const Icon(
        Icons.person_outline,
        size: 20,
        color: AppColors.grocerySubTitle,
      ),
      headerStyle: TextStyle(fontSize: 12.sp),
      listItemStyle: TextStyle(fontSize: 12.sp),
      closedFillColor: AppColors.groceryWhite,
      hintStyle: const TextStyle(
        color: AppColors.grocerySubTitle,
        fontSize: 14,
      ),
      closedBorderRadius: BorderRadius.circular(4),
      expandedBorderRadius: BorderRadius.circular(4),
      closedBorder: Border.all(color: AppColors.groceryBorder),
      expandedBorder: Border.all(color: AppColors.groceryBorder),
      expandedFillColor: AppColors.groceryWhite,
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      _controller.submitSignUp();
    }
  }

  Widget _buildSpacing() => SizedBox(height: 10.h);
}

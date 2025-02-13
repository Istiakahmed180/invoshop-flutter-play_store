import 'package:ai_store/common/controller/camara_controller.dart';
import 'package:ai_store/common/controller/gallery_controller.dart';
import 'package:ai_store/common/controller/user_role_controller.dart';
import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/custom_label_text.dart';
import 'package:ai_store/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/screens/user_management/controller/edit_user_controller.dart';
import 'package:ai_store/screens/user_management/model/users_model.dart'
    as model;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditUserScreen extends StatefulWidget {
  final model.UsersData user;

  const EditUserScreen({super.key, required this.user});

  @override
  State<EditUserScreen> createState() => EditUserScreenState();
}

class EditUserScreenState extends State<EditUserScreen> {
  final EditUserController editUserController = Get.put(EditUserController());
  final CameraAccessController cameraAccessController =
      Get.put(CameraAccessController());
  final GalleryAccessController galleryAccessController =
      Get.put(GalleryAccessController());
  final UserRoleController userRoleController = Get.put(UserRoleController());

  @override
  void initState() {
    super.initState();
    userRoleController.getRoles();
    _initializeUserData();
  }

  void _initializeUserData() {
    editUserController.firstNameController.text = widget.user.firstName ?? "";
    editUserController.lastNameController.text = widget.user.lastName ?? "";
    editUserController.phoneController.text = widget.user.phone ?? "";
    editUserController.emailController.text = widget.user.email ?? "";
    editUserController.gender.value = widget.user.gender ?? "";
    editUserController.roleId.value = widget.user.roles?.isNotEmpty == true
        ? widget.user.roles![0].id ?? 0
        : 0;
    editUserController.status.value = widget.user.status ?? "";
    editUserController.userNameController.text = widget.user.username ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Edit User"),
      body: Obx(
        () => userRoleController.isLoading.value
            ? const CustomLoading(withOpacity: 0.0)
            : Stack(
                children: [
                  Padding(
                    padding: REdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildImageSection(),
                          SizedBox(height: 10.h),
                          _buildFormFields(),
                          SizedBox(height: 10.h),
                          _buildUpdateButton(),
                        ],
                      ),
                    ),
                  ),
                  _buildLoadingIndicator(),
                ],
              ),
      ),
    );
  }

  Widget _buildImageSection() {
    return GestureDetector(
      onTap: () => buildBottomSheetWidget(
          cameraAccessController, galleryAccessController),
      child: Stack(
        children: [
          widget.user.image == null
              ? _buildDefaultImage()
              : FutureBuilder<String>(
                  future: ApiPath.getImageUrl(widget.user.image?.path ?? ''),
                  builder: (context, snapshot) {
                    return Obx(
                      () => CircleAvatar(
                        radius: 40.r,
                        child: ClipOval(
                          child: _buildProfileImage(snapshot),
                        ),
                      ),
                    );
                  },
                ),
          _buildCameraIcon(),
        ],
      ),
    );
  }

  Widget _buildCameraIcon() {
    return Obx(
      () => Visibility(
        visible: _shouldShowCameraIcon(),
        child: const Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 12.0,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.camera_alt,
              size: 16.0,
              color: AppColors.groceryPrimary,
            ),
          ),
        ),
      ),
    );
  }

  bool _shouldShowCameraIcon() {
    return cameraAccessController.selectedFilePath.value == null &&
        galleryAccessController.selectedFilePath.value == null &&
        (widget.user.image?.path == null || widget.user.image!.path!.isEmpty);
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildTextField(
          "First Name",
          "Joseps",
          editUserController.firstNameController,
          TextInputType.name,
        ),
        SizedBox(height: 10.h),
        _buildTextField(
          "Last Name",
          "Taylor",
          editUserController.lastNameController,
          TextInputType.name,
        ),
        SizedBox(height: 10.h),
        _buildTextField(
          "Phone",
          "00 000 000 000",
          editUserController.phoneController,
          TextInputType.phone,
        ),
        SizedBox(height: 10.h),
        _buildTextField(
          "Email",
          "josephtaylor@gmail.com",
          editUserController.emailController,
          TextInputType.emailAddress,
        ),
        SizedBox(height: 10.h),
        _buildGenderDropdown(),
        SizedBox(height: 10.h),
        _buildRoleDropdown(),
        SizedBox(height: 10.h),
        _buildStatusDropdown(),
        SizedBox(height: 10.h),
        _buildTextField(
          "User Name",
          "MY1515_2_ADMIN",
          editUserController.userNameController,
          TextInputType.text,
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabelText(text: label),
        SizedBox(height: 5.h),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabelText(text: "Gender"),
        SizedBox(height: 5.h),
        CustomDropdownField(
          hintText: "Select Gender",
          dropdownItems: const ["Male", "Female", "Other"],
          onChanged: (String? value) {
            editUserController.gender.value = value ?? "";
          },
        ),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabelText(text: "Role"),
        SizedBox(height: 5.h),
        CustomDropdownField(
          hintText: "Select Role",
          dropdownItems: userRoleController.rolesList.isEmpty
              ? ["Not Found"]
              : userRoleController.rolesList
                  .map((item) => item.title as String)
                  .toList(),
          onChanged: (String? value) {
            if (value != null && value != "Not Found") {
              editUserController.roleId.value = userRoleController.rolesList
                      .firstWhere((item) => item.title == value)
                      .id ??
                  0;
            }
          },
        ),
      ],
    );
  }

  Widget _buildStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabelText(text: "Status"),
        SizedBox(height: 5.h),
        CustomDropdownField(
          hintText: "Select Status",
          dropdownItems: const ["Active", "Pending", "Inactive", "Deleted"],
          onChanged: (String? value) {
            editUserController.status.value = value ?? "";
          },
        ),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomElevatedButton(
        buttonName: "Update",
        onPressed: () {
          editUserController.postEditUser(userId: widget.user.id.toString());
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Obx(
      () => Visibility(
        visible: editUserController.isUserEditLoading.value,
        child: const CustomLoading(),
      ),
    );
  }

  Widget _buildProfileImage(AsyncSnapshot<String> snapshot) {
    if (cameraAccessController.selectedFilePath.value != null) {
      return Image.file(
        cameraAccessController.selectedFilePath.value!,
        fit: BoxFit.cover,
        width: 80.r,
        height: 80.r,
      );
    }

    if (galleryAccessController.selectedFilePath.value != null) {
      return Image.file(
        galleryAccessController.selectedFilePath.value!,
        fit: BoxFit.cover,
        width: 80.r,
        height: 80.r,
      );
    }

    if (widget.user.image?.path != null &&
        widget.user.image!.path!.isNotEmpty &&
        snapshot.hasData) {
      return Image(
        image: NetworkImage(snapshot.data!),
        fit: BoxFit.cover,
        width: 80.r,
        height: 80.r,
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultImage();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.groceryPrimary,
              strokeWidth: 3,
              backgroundColor: AppColors.grocerySecondary,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }
    return _buildDefaultImage();
  }

  Widget _buildDefaultImage() {
    return Image(
      image: const AssetImage(
        'assets/images/drawer_image/profile-img.png',
      ),
      fit: BoxFit.cover,
      width: 80.r,
      height: 80.r,
    );
  }

  void buildBottomSheetWidget(
    CameraAccessController cameraController,
    GalleryAccessController galleryController,
  ) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: AppColors.groceryBodyTwo,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: REdgeInsets.all(12),
                child: Text(
                  "Profile Photo",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildImagePickerOption(
                    "Camera",
                    "assets/icons/profile/camera_icon.svg",
                    () async {
                      Get.back();
                      galleryController.clearFile();
                      await cameraController.pickFile();
                    },
                  ),
                  _buildImagePickerOption(
                    "Gallery",
                    "assets/icons/profile/gallery_icon.svg",
                    () async {
                      Get.back();
                      cameraController.clearFile();
                      await galleryController.pickFile();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerOption(
      String label, String iconPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border:
                  Border.all(color: AppColors.grocerySubTitle.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(50),
            ),
            child: SvgPicture.asset(
              iconPath,
              width: 30,
              colorFilter: const ColorFilter.mode(
                  AppColors.groceryPrimary, BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

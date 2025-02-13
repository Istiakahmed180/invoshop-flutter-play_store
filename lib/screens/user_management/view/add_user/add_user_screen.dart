import 'package:ai_store/common/controller/camara_controller.dart';
import 'package:ai_store/common/controller/gallery_controller.dart';
import 'package:ai_store/common/controller/user_role_controller.dart';
import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:ai_store/common/widgets/common_outline_button.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/custom_label_text.dart';
import 'package:ai_store/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/user_management/controller/add_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final AddUserController addUserController = Get.put(AddUserController());
  final CameraAccessController cameraAccessController =
      Get.put(CameraAccessController());
  final GalleryAccessController galleryAccessController =
      Get.put(GalleryAccessController());
  final UserRoleController userRoleController = Get.put(UserRoleController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userRoleController.getRoles();
    addUserController.passwordController.text = "password";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Add User"),
      body: Obx(
        () => userRoleController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : Stack(
                children: [
                  Padding(
                    padding: REdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                buildBottomSheetWidget(cameraAccessController,
                                    galleryAccessController);
                              },
                              child: Stack(
                                children: [
                                  Obx(
                                    () => CircleAvatar(
                                      radius: 40.r,
                                      child: ClipOval(
                                        child: cameraAccessController
                                                    .selectedFilePath.value !=
                                                null
                                            ? Image.file(
                                                cameraAccessController
                                                    .selectedFilePath.value!,
                                                fit: BoxFit.cover,
                                                width: 80.r,
                                                height: 80.r,
                                              )
                                            : galleryAccessController
                                                        .selectedFilePath
                                                        .value !=
                                                    null
                                                ? Image.file(
                                                    galleryAccessController
                                                        .selectedFilePath
                                                        .value!,
                                                    fit: BoxFit.cover,
                                                    width: 80.r,
                                                    height: 80.r,
                                                  )
                                                : Image(
                                                    image: const AssetImage(
                                                      'assets/images/drawer_image/profile-img.png',
                                                    ),
                                                    fit: BoxFit.cover,
                                                    width: 80.r,
                                                    height: 80.r,
                                                  ),
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Visibility(
                                      visible: cameraAccessController
                                                  .selectedFilePath.value ==
                                              null &&
                                          galleryAccessController
                                                  .selectedFilePath.value ==
                                              null,
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
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "First Name",
                                  isRequired: true,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "First name is required";
                                    }
                                    return null;
                                  },
                                  controller:
                                      addUserController.firstNameController,
                                  decoration:
                                      const InputDecoration(hintText: "Joseps"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "Last Name",
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller:
                                      addUserController.lastNameController,
                                  decoration:
                                      const InputDecoration(hintText: "Taylor"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "Phone",
                                  isRequired: true,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Phone is required";
                                    }
                                    return null;
                                  },
                                  controller: addUserController.phoneController,
                                  decoration: const InputDecoration(
                                      hintText: "00 000 000 000"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "Email",
                                  isRequired: true,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Email is required";
                                    }
                                    return null;
                                  },
                                  controller: addUserController.emailController,
                                  decoration: const InputDecoration(
                                      hintText: "josephtaylor@gmail.com"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "Gender",
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                CustomDropdownField(
                                  hintText: "Select Gender",
                                  dropdownItems: const [
                                    "Male",
                                    "Female",
                                    "Other"
                                  ],
                                  onChanged: (String? value) {
                                    addUserController.gender.value =
                                        value ?? "";
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "Role",
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                CustomDropdownField(
                                  hintText: "Select Role",
                                  dropdownItems: userRoleController
                                          .rolesList.isEmpty
                                      ? ["Not Found"]
                                      : userRoleController.rolesList
                                          .map((item) => item.title as String)
                                          .toList(),
                                  onChanged: (String? value) {
                                    addUserController.roleId
                                        .value = userRoleController.rolesList
                                            .firstWhere(
                                                (item) => item.title == value)
                                            .id ??
                                        0;
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "Status",
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                CustomDropdownField(
                                  hintText: "Select Status",
                                  dropdownItems: const [
                                    "Active",
                                    "Pending",
                                    "Inactive",
                                    "Deleted"
                                  ],
                                  onChanged: (String? value) {
                                    addUserController.status.value =
                                        value ?? "";
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "User Name",
                                  isRequired: true,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Username is required";
                                    }
                                    return null;
                                  },
                                  controller:
                                      addUserController.userNameController,
                                  decoration: const InputDecoration(
                                      hintText: "MY1515_2_ADMIN"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "Password",
                                  isRequired: true,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Obx(
                                  () => TextFormField(
                                    obscureText: addUserController
                                        .isPasswordVisible.value,
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Password is required";
                                      }
                                      return null;
                                    },
                                    controller:
                                        addUserController.passwordController,
                                    decoration: InputDecoration(
                                        suffix: GestureDetector(
                                      onTap: () {
                                        addUserController
                                                .isPasswordVisible.value =
                                            !addUserController
                                                .isPasswordVisible.value;
                                      },
                                      child: Icon(
                                        addUserController
                                                .isPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.groceryRatingGray,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomOutlinedButton(
                                    buttonText: "Reset",
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CustomAlertDialog(
                                                title: "Reset",
                                                subTitle:
                                                    "Are you sure your want to reset all fields!",
                                                pressedOk: () {
                                                  addUserController
                                                      .resetFields();
                                                  Get.back();
                                                },
                                                okButtonName: "Yes",
                                                pressedNo: () {
                                                  Get.back();
                                                },
                                                noButtonName: "No",
                                              ));
                                    }),
                                CustomElevatedButton(
                                  buttonName: "Create",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      addUserController.postCreateUser();
                                    }
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                        visible: addUserController.isUserCreateLoading.value,
                        child: const CustomLoading()),
                  )
                ],
              ),
      ),
    );
  }

  void buildBottomSheetWidget(CameraAccessController cameraController,
      GalleryAccessController galleryController) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: AppColors.groceryBodyTwo,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                  GestureDetector(
                    onTap: () async {
                      Get.back();
                      galleryController.clearFile();
                      await cameraController.pickFile();
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    AppColors.grocerySubTitle.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/profile/camera_icon.svg",
                            width: 30,
                            colorFilter: const ColorFilter.mode(
                                AppColors.groceryPrimary, BlendMode.srcIn),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Camera",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Get.back();
                      cameraController.clearFile();
                      await galleryController.pickFile();
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    AppColors.grocerySubTitle.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/profile/gallery_icon.svg",
                            width: 30,
                            colorFilter: const ColorFilter.mode(
                                AppColors.groceryPrimary, BlendMode.srcIn),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Gallery",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

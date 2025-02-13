import 'package:ai_store/common/controller/bottom_navigation_controller.dart';
import 'package:ai_store/common/controller/camara_controller.dart';
import 'package:ai_store/common/controller/gallery_controller.dart';
import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/custom_label_text.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/screens/profile/controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditUserProfile extends StatefulWidget {
  final String name;
  final String userName;
  final String email;
  final String phone;
  final String image;

  const EditUserProfile(
      {super.key,
      required this.name,
      required this.userName,
      required this.email,
      required this.phone,
      required this.image});

  @override
  EditUserProfileState createState() => EditUserProfileState();
}

class EditUserProfileState extends State<EditUserProfile> {
  final EditProfileController profileController =
      Get.put(EditProfileController());
  final CameraAccessController cameraAccessController =
      Get.put(CameraAccessController());
  final GalleryAccessController galleryAccessController =
      Get.put(GalleryAccessController());
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    profileController.firstNameController.text = widget.name;
    profileController.userNameController.text = widget.userName;
    profileController.emailController.text = widget.email;
    profileController.phoneController.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigationController());

    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Edit Profile"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      buildBottomSheetWidget(
                          cameraAccessController, galleryAccessController);
                    },
                    child: Stack(
                      children: [
                        FutureBuilder<String>(
                          future: ApiPath.getImageUrl(widget.image),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox();
                            }
                            if (snapshot.hasError) {
                              return const Icon(
                                Icons.broken_image,
                                size: 50,
                                color: AppColors.groceryBorder,
                              );
                            }
                            return Obx(
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
                                                  .selectedFilePath.value !=
                                              null
                                          ? Image.file(
                                              galleryAccessController
                                                  .selectedFilePath.value!,
                                              fit: BoxFit.cover,
                                              width: 80.r,
                                              height: 80.r,
                                            )
                                          : widget.image.isNotEmpty
                                              ? Image(
                                                  image: NetworkImage(
                                                      snapshot.data!),
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
                            );
                          },
                        ),
                        if (widget.image.isEmpty)
                          const Positioned(
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
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomLabelText(
                                text: "First Name",
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Required Field";
                                  }
                                  return null;
                                },
                                controller:
                                    profileController.firstNameController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  hintText: "Name",
                                ),
                              )
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
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Required Field";
                                  }
                                  return null;
                                },
                                controller:
                                    profileController.userNameController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  hintText: "Username",
                                ),
                              )
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
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Required Field";
                                  }
                                  return null;
                                },
                                controller: profileController.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                ),
                              )
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
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Required Field";
                                  }
                                  return null;
                                },
                                controller: profileController.phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  hintText: "Phone",
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomElevatedButton(
                              buttonName: "Update Profile",
                              onPressed: () {
                                if (_globalKey.currentState!.validate()) {
                                  profileController.postUpdateProfile();
                                }
                              },
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
          Obx(
            () => Visibility(
                visible: profileController.isLoading.value,
                child: const CustomLoading()),
          )
        ],
      ),
    );
  }
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
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
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

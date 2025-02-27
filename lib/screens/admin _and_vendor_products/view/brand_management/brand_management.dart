import 'package:invoshop/common/controller/camara_controller.dart';
import 'package:invoshop/common/controller/gallery_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_outline_button.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/controller/brand_management_controller.dart';
import 'package:invoshop/screens/brand/models/brands_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BrandManagement extends StatefulWidget {
  const BrandManagement({super.key});

  @override
  State<BrandManagement> createState() => _BrandManagement();
}

class _BrandManagement extends State<BrandManagement> {
  final BrandManagementController brandManagementController =
      Get.put(BrandManagementController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    brandManagementController.getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Brands"),
        body: Obx(
          () => brandManagementController.isLoading.value
              ? const CustomLoading(
                  withOpacity: 0.0,
                )
              : Stack(
                  children: [
                    Padding(
                      padding: REdgeInsets.all(12),
                      child: Column(
                        children: [
                          _buildDataTable(),
                        ],
                      ),
                    ),
                    Obx(
                      () => Visibility(
                          visible:
                              brandManagementController.isBrandsLoading.value,
                          child: const CustomLoading()),
                    )
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.groceryPrimary,
          onPressed: () {
            _buildBottomSheetWidget();
          },
          child: Icon(
            Icons.add,
            size: 30.w,
            color: AppColors.groceryWhite,
          ),
        ));
  }

  Widget _buildDataTable() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: DataTable(
            showCheckboxColumn: false,
            border: TableBorder(
              borderRadius: BorderRadius.circular(4.r),
              horizontalInside: BorderSide(
                color: AppColors.groceryPrimary.withOpacity(0.2),
                width: 0.5,
              ),
              verticalInside: BorderSide(
                color: AppColors.groceryPrimary.withOpacity(0.2),
                width: 0.5,
              ),
            ),
            headingRowColor: WidgetStateProperty.all(
              AppColors.groceryPrimary.withOpacity(0.1),
            ),
            dataRowColor: WidgetStateProperty.resolveWith(
              (states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.groceryPrimary.withOpacity(0.2);
                }
                return AppColors.groceryPrimary.withOpacity(0.05);
              },
            ),
            horizontalMargin: 15,
            columnSpacing: 40,
            headingRowHeight: 60,
            dataRowMaxHeight: 60,
            dividerThickness: 0.5,
            columns: _buildTableColumns(),
            rows: _buildTableRows(),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    return [
      _buildTableHeader("SL"),
      _buildTableHeader("Image"),
      _buildTableHeader("Brand Name"),
      _buildTableHeader("Action"),
    ];
  }

  DataColumn _buildTableHeader(String label) {
    return DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.groceryPrimary,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  List<DataRow> _buildTableRows() {
    return brandManagementController.brandList.asMap().entries.map((entry) {
      final index = entry.key;
      final brand = entry.value;
      final actionButtonKey = GlobalKey(debugLabel: 'action_button_$index');
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          DataCell(Center(
            child: brand.image == null
                ? Container(
                    padding: REdgeInsets.all(5),
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                        color: AppColors.groceryBorder,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: const Icon(
                      Icons.broken_image,
                      color: AppColors.groceryRatingGray,
                    ),
                  )
                : FutureBuilder<String>(
                    future: ApiPath.getImageUrl(brand.image!.path!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      if (snapshot.hasError) {
                        return const Icon(
                          Icons.broken_image,
                          size: 50,
                          color: AppColors.groceryBorder,
                        );
                      }
                      return Container(
                        padding: REdgeInsets.all(5),
                        width: 45.w,
                        height: 45.w,
                        decoration: BoxDecoration(
                            color: AppColors.groceryPrimary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30.r)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            imageUrl: snapshot.data ?? "",
                            placeholder: (context, url) =>
                                Image.asset("assets/gif/loading.gif"),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.broken_image,
                              color: AppColors.groceryRatingGray,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )),
          _buildDataCell(
            (brand.title != null ? brand.title ?? "N/A" : "N/A"),
          ),
          DataCell(
            Center(
              child: OutlinedButton(
                key: actionButtonKey,
                style: OutlinedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                  side: BorderSide(
                    color: AppColors.groceryPrimary.withOpacity(0.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                onPressed: () async {
                  final RenderBox renderBox = actionButtonKey.currentContext!
                      .findRenderObject() as RenderBox;
                  final buttonPosition = renderBox.localToGlobal(Offset.zero);
                  final buttonSize = renderBox.size;
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      buttonPosition.dx,
                      buttonPosition.dy + buttonSize.height,
                      buttonPosition.dx + buttonSize.width,
                      buttonPosition.dy + buttonSize.height + 100,
                    ),
                    items: [
                      PopupMenuItem<String>(
                        onTap: () {
                          brandManagementController
                              .editBrandNameController.text = brand.title ?? "";
                          _buildEditBottomSheetWidget(brand: brand);
                        },
                        value: 'Edit',
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: AppColors.groceryPrimary,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        onTap: () {
                          brandManagementController.deleteBrand(
                              brandId: brand.id.toString());
                        },
                        value: 'Delete',
                        child: const Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: AppColors.grocerySecondary,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                child: const Text(
                  "Action",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.groceryPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  DataCell _buildDataCell(String value) {
    return DataCell(
      Center(
        child: Text(
          value,
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }

  void _buildBottomSheetWidget() {
    final CameraAccessController cameraAccessController =
        Get.put(CameraAccessController());
    final GalleryAccessController galleryAccessController =
        Get.put(GalleryAccessController());

    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: AppColors.groceryBodyTwo,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: REdgeInsets.all(12),
                child: Text(
                  "Create Brand",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        buildBottomSheetWidget(
                            cameraAccessController, galleryAccessController);
                      },
                      child: Stack(
                        children: [
                          Obx(
                            () => CircleAvatar(
                              radius: 40.r,
                              backgroundColor: AppColors.groceryPrimary
                                  .withValues(alpha: 0.1),
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
                                        : Image(
                                            image: const AssetImage(
                                              'assets/images/products/watermelon.png',
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
                              visible: galleryAccessController
                                          .selectedFilePath.value ==
                                      null &&
                                  cameraAccessController
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
                          text: "Brand Name",
                          isRequired: true,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Brand name is required";
                            }
                            return null;
                          },
                          controller:
                              brandManagementController.addBrandNameController,
                          decoration: const InputDecoration(hintText: "HP"),
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
                              brandManagementController.createResetFields();
                            }),
                        CustomElevatedButton(
                          buttonName: "Create",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              brandManagementController.postCreateBrand();
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _buildEditBottomSheetWidget({required BrandsData brand}) {
    final CameraAccessController cameraAccessController =
        Get.put(CameraAccessController());
    final GalleryAccessController galleryAccessController =
        Get.put(GalleryAccessController());
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: AppColors.groceryBodyTwo,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: REdgeInsets.all(12),
                child: Text(
                  "Update Brand",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      buildBottomSheetWidget(
                          cameraAccessController, galleryAccessController);
                    },
                    child: Stack(
                      children: [
                        FutureBuilder<String>(
                          future: ApiPath.getImageUrl(brand.image!.path!),
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
                                          : brand.image != null
                                              ? Image(
                                                  image: NetworkImage(
                                                      snapshot.data!),
                                                  fit: BoxFit.cover,
                                                  width: 80.r,
                                                  height: 80.r,
                                                )
                                              : Image(
                                                  image: const AssetImage(
                                                    'assets/images/products/watermelon.png',
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
                        if (brand.image == null)
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLabelText(
                        text: "Brand Name",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller:
                            brandManagementController.editBrandNameController,
                        decoration: InputDecoration(hintText: "HP"),
                      )
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
                            brandManagementController.editResetFields();
                          }),
                      CustomElevatedButton(
                        buttonName: "Update",
                        onPressed: () {
                          brandManagementController.postUpdateBrand(
                              brandId: brand.id.toString());
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
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

import 'package:invoshop/common/controller/camara_controller.dart';
import 'package:invoshop/common/controller/gallery_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_outline_button.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/controller/category_management_controller.dart';
import 'package:invoshop/screens/home/model/categories_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CategoryManagement extends StatefulWidget {
  const CategoryManagement({super.key});

  @override
  State<CategoryManagement> createState() => _CategoryManagement();
}

class _CategoryManagement extends State<CategoryManagement> {
  final CategoryManagementController categoryManagementController =
      Get.put(CategoryManagementController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    categoryManagementController.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Categories"),
        body: Obx(
          () => categoryManagementController.isLoading.value
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
                          visible: categoryManagementController
                              .isCategoriesLoading.value,
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
    return Expanded(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          scrollDirection: Axis.horizontal,
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
      ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    return [
      _buildTableHeader("SL"),
      _buildTableHeader("Image"),
      _buildTableHeader("Category Name"),
      _buildTableHeader("Parent Category"),
      _buildTableHeader("Category Type"),
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
    return categoryManagementController.categoriesList
        .asMap()
        .entries
        .map((entry) {
      final index = entry.key;
      final category = entry.value;
      final actionButtonKey = GlobalKey(debugLabel: 'action_button_$index');
      return DataRow(
        cells: [
          DataCell(Center(child: Text('${index + 1}'))),
          DataCell(Center(
            child: category.image == null
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
                    future: ApiPath.getImageUrl(category.image!.path!),
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
            (category.title != null && category.title!.isNotEmpty
                ? category.title ?? "N/A"
                : "N/A"),
          ),
          _buildDataCell(
            (category.parent != null && category.parent!.title!.isNotEmpty
                ? category.parent!.title ?? "N/A"
                : "N/A"),
          ),
          _buildDataCell(
            (category.type != null && category.type!.isNotEmpty
                ? category.type ?? "N/A"
                : "N/A"),
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
                          categoryManagementController.parentCategoryId.value =
                              category.parentId?.toInt() ?? 0;
                          categoryManagementController.categoryType.value =
                              category.type?.toString() ?? '';
                          categoryManagementController
                              .editCategoryNameController
                              .text = category.title?.toString() ?? '';
                          _buildEditBottomSheetWidget(category: category);
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
                          categoryManagementController.deleteCategory(
                              categoryId: category.id.toString());
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: REdgeInsets.all(12),
                  child: Text(
                    "Create Category",
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
                            text: "Category Type",
                            isRequired: true,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomDropdownField(
                            hintText: "Select Type",
                            validatorText: "Category type",
                            dropdownItems: ["Product", "Expense", "Customer"],
                            onChanged: (value) {
                              categoryManagementController.categoryType.value =
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
                            text: "Parent Category",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomDropdownField(
                            hintText: "Select Category",
                            dropdownItems: categoryManagementController
                                .categoriesList
                                .map((item) => item.title as String)
                                .toList(),
                            onChanged: (value) {
                              categoryManagementController.parentCategoryId
                                  .value = categoryManagementController
                                      .categoriesList
                                      .firstWhere((item) => item.title == value)
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
                            text: "Category Name",
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
                                return "Category name is required";
                              }
                              return null;
                            },
                            controller: categoryManagementController
                                .addCategoryNameController,
                            decoration: const InputDecoration(
                                hintText: "HP Ellitebook"),
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
                                categoryManagementController
                                    .createResetFields();
                              }),
                          CustomElevatedButton(
                            buttonName: "Create",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                categoryManagementController
                                    .postCreateCategory();
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
      ),
    );
  }

  void _buildEditBottomSheetWidget({required CategoriesData category}) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: REdgeInsets.all(12),
                  child: Text(
                    "Update Category",
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
                            future: ApiPath.getImageUrl(category.image!.path!),
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
                                  backgroundColor: AppColors.groceryPrimary
                                      .withValues(alpha: 0.1),
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
                                            : category.image != null
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
                          if (category.image == null)
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
                          text: "Category Type",
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomDropdownField(
                          hintText: "Select Type",
                          dropdownItems: ["Product", "Expense", "Customer"],
                          onChanged: (value) {
                            categoryManagementController.categoryType.value =
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
                          text: "Parent Category",
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomDropdownField(
                          hintText: "Select Category",
                          dropdownItems: categoryManagementController
                              .categoriesList
                              .map((item) => item.title as String)
                              .toList(),
                          onChanged: (value) {
                            categoryManagementController.parentCategoryId
                                .value = categoryManagementController
                                    .categoriesList
                                    .firstWhere((item) => item.title == value)
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
                          text: "Category Name",
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: categoryManagementController
                              .editCategoryNameController,
                          decoration:
                              const InputDecoration(hintText: "HP Ellitebook"),
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
                              categoryManagementController.editResetFields();
                            }),
                        CustomElevatedButton(
                          buttonName: "Update",
                          onPressed: () {
                            categoryManagementController.postUpdateBrand(
                                categoryId: category.id.toString());
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

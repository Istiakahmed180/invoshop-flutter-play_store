import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/camara_controller.dart';
import 'package:invoshop/common/controller/gallery_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/common_outline_button.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/date_picker/custom_date_picker.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/admin%20_and_vendor_products/controller/create_product_controller.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final CreateProductController createProductController =
      Get.put(CreateProductController());
  final CameraAccessController cameraAccessController =
      Get.put(CameraAccessController());
  final GalleryAccessController galleryAccessController =
      Get.put(GalleryAccessController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarName: "Create Product"),
      body: Obx(
        () => createProductController.isLoading.value
            ? CustomLoading(
                withOpacity: 0.0,
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomLabelText(
                              text: "Product Name",
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
                                  return "Product name is required";
                                }
                                return null;
                              },
                              controller:
                                  createProductController.nameController,
                              decoration: const InputDecoration(
                                  hintText: "HP Ellitebook"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomLabelText(
                              text: "Product Code",
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TextFormField(
                              controller:
                                  createProductController.codeController,
                              readOnly: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Product Price",
                                    isRequired: true,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Product price is required";
                                      }
                                      return null;
                                    },
                                    controller:
                                        createProductController.priceController,
                                    decoration:
                                        const InputDecoration(hintText: "0"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "Product Quantity",
                                  isRequired: true,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Product quantity is required";
                                    }
                                    return null;
                                  },
                                  controller: createProductController
                                      .quantityController,
                                  decoration:
                                      const InputDecoration(hintText: "0"),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Discount Type",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    hintText: "Select Type",
                                    dropdownItems: ["Fixed", "Percentage"],
                                    onChanged: (String? value) {
                                      createProductController.discountType
                                          .value = value.toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomLabelText(
                                  text: "Discount",
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: createProductController
                                      .discountController,
                                  decoration:
                                      const InputDecoration(hintText: "0"),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Tax Type",
                                    isRequired: true,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    hintText: "Select Type",
                                    validatorText: "Tax type",
                                    dropdownItems: ["Fixed", "Percentage"],
                                    onChanged: (String? value) {
                                      createProductController.taxType.value =
                                          value.toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: Obx(
                              () => Visibility(
                                visible: createProductController
                                            .taxType.value ==
                                        "Fixed" ||
                                    createProductController.taxType.value == "",
                                replacement: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomLabelText(
                                      text: "Tax Percent",
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    CustomDropdownField(
                                      hintText: "Select Tax",
                                      dropdownItems: createProductController
                                              .taxList.isEmpty
                                          ? ["Not Empty"]
                                          : createProductController.taxList
                                              .map((item) =>
                                                  item.title as String)
                                              .toList(),
                                      onChanged: (value) {
                                        createProductController.taxId.value =
                                            createProductController.taxList
                                                    .firstWhere((item) =>
                                                        item.title == value)
                                                    .id ??
                                                0;
                                      },
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomLabelText(
                                      text: "Tax Amount",
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: createProductController
                                          .taxAmountController,
                                      decoration:
                                          const InputDecoration(hintText: "0"),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Color Variant",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    hintText: "Select Variant",
                                    dropdownItems: createProductController
                                            .colorVariantList.isEmpty
                                        ? ["Not Found"]
                                        : createProductController
                                            .colorVariantList
                                            .map((item) => item.name as String)
                                            .toList(),
                                    onChanged: (String? value) {
                                      createProductController.colorVariantId
                                          .value = createProductController
                                              .colorVariantList
                                              .firstWhere(
                                                  (item) => item.name == value)
                                              .id ??
                                          0;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Size Variant",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    hintText: "Select Variant",
                                    dropdownItems: createProductController
                                            .sizeVariantList.isEmpty
                                        ? ["Not Found"]
                                        : createProductController
                                            .sizeVariantList
                                            .map((item) => item.name as String)
                                            .toList(),
                                    onChanged: (String? value) {
                                      createProductController.sizeVariantId
                                          .value = createProductController
                                              .sizeVariantList
                                              .firstWhere(
                                                  (item) => item.name == value)
                                              .id ??
                                          0;
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Category",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    hintText: "Select Category",
                                    dropdownItems: createProductController
                                            .categoriesList.isEmpty
                                        ? ["Not Found"]
                                        : createProductController.categoriesList
                                            .map((item) => item.title as String)
                                            .toList(),
                                    onChanged: (String? value) {
                                      createProductController.categoryId.value =
                                          createProductController.categoriesList
                                                  .firstWhere((item) =>
                                                      item.title == value)
                                                  .id ??
                                              0;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Brand",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    hintText: "Select Brand",
                                    dropdownItems: createProductController
                                            .brandList.isEmpty
                                        ? ["Not Found"]
                                        : createProductController.brandList
                                            .map((item) => item.title as String)
                                            .toList(),
                                    onChanged: (String? value) {
                                      createProductController.brandId.value =
                                          createProductController.brandList
                                                  .firstWhere((item) =>
                                                      item.title == value)
                                                  .id ??
                                              0;
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Supplier",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    hintText: "Select Supplier",
                                    dropdownItems: createProductController
                                            .supplierList.isEmpty
                                        ? ["Not Found"]
                                        : createProductController.supplierList
                                            .map((item) => [
                                                  item.firstName ?? "",
                                                  item.lastName ?? ""
                                                ].join(" ").trim())
                                            .toList(),
                                    onChanged: (String? value) {
                                      createProductController.supplierId.value =
                                          createProductController.supplierList
                                                  .firstWhere((item) =>
                                                      [
                                                        item.firstName ?? "",
                                                        item.lastName ?? ""
                                                      ].join(" ").trim() ==
                                                      value)
                                                  .id ??
                                              0;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Tax Method",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    hintText: "Select Method",
                                    dropdownItems: ["Excluded", "Included"],
                                    onChanged: (String? value) {
                                      createProductController.taxMethod.value =
                                          value.toString();
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Product Type",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    hintText: "Select Type",
                                    dropdownItems: createProductController
                                            .productTypeList.isEmpty
                                        ? ["Not Found"]
                                        : createProductController
                                            .productTypeList
                                            .map((item) => item.title as String)
                                            .toList(),
                                    onChanged: (String? value) {
                                      createProductController.productTypeId
                                          .value = createProductController
                                              .productTypeList
                                              .firstWhere(
                                                  (item) => item.title == value)
                                              .id ??
                                          0;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Product Unit",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    hintText: "Select Unit",
                                    dropdownItems: createProductController
                                            .unitList.isEmpty
                                        ? ["Not Found"]
                                        : createProductController.unitList
                                            .map((item) => item.name as String)
                                            .toList(),
                                    onChanged: (String? value) {
                                      createProductController.unitId.value =
                                          createProductController.unitList
                                                  .firstWhere((item) =>
                                                      item.name == value)
                                                  .id ??
                                              0;
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          createProductController.isFeatured.value =
                              !createProductController.isFeatured.value;
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: AppColors.groceryWhite,
                              activeColor: AppColors.groceryPrimary,
                              value: createProductController.isFeatured.value,
                              side:
                                  MaterialStateBorderSide.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return const BorderSide(
                                      color: AppColors.groceryPrimary,
                                      width: 1);
                                }
                                return const BorderSide(
                                    color: AppColors.groceryBorder, width: 1);
                              }),
                              onChanged: (value) {
                                createProductController.isFeatured.value =
                                    value!;
                              },
                            ),
                            Text(
                              "Add Featured",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          createProductController.isPromotionalSale.value =
                              !createProductController.isPromotionalSale.value;
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: AppColors.groceryWhite,
                              activeColor: AppColors.groceryPrimary,
                              value: createProductController
                                  .isPromotionalSale.value,
                              side:
                                  MaterialStateBorderSide.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return const BorderSide(
                                      color: AppColors.groceryPrimary,
                                      width: 1);
                                }
                                return const BorderSide(
                                    color: AppColors.groceryBorder, width: 1);
                              }),
                              onChanged: (value) {
                                createProductController
                                    .isPromotionalSale.value = value!;
                              },
                            ),
                            Text(
                              "Add Promotional Sale",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible:
                              createProductController.isPromotionalSale.value,
                          child: SizedBox(
                            height: 10.h,
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible:
                              createProductController.isPromotionalSale.value,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomLabelText(
                                        text: "Start Date",
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      CustomDatePicker(
                                        hintText: "Select Date",
                                        initialDate: createProductController
                                            .startDate.value,
                                        onDateSelected: (DateTime date) {
                                          createProductController
                                              .startDate.value = date;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomLabelText(
                                        text: "End Date",
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      CustomDatePicker(
                                        hintText: "Select Date",
                                        initialDate: createProductController
                                            .endDate.value,
                                        onDateSelected: (DateTime date) {
                                          createProductController
                                              .endDate.value = date;
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible:
                              createProductController.isPromotionalSale.value,
                          child: SizedBox(
                            height: 10.h,
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                            visible:
                                createProductController.isPromotionalSale.value,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Promotional Price",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: createProductController
                                        .promotionalPriceController,
                                    decoration: const InputDecoration(
                                        hintText: "Price"),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomOutlinedButton(
                                buttonText: "Reset",
                                onPressed: () {
                                  createProductController.resetFields();
                                }),
                            CustomElevatedButton(
                              buttonName: "Create",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  createProductController.postCreateProduct();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
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
                            colorFilter: ColorFilter.mode(
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

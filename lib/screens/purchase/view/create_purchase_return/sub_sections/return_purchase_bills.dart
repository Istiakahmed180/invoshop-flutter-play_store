import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/custom_label_text.dart';
import 'package:invoshop/common/widgets/date_picker/custom_date_picker.dart';
import 'package:invoshop/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/home/model/products_model.dart';
import 'package:invoshop/screens/pos/controller/pos_controller.dart';
import 'package:invoshop/screens/purchase/controller/create_purchase_return_controller.dart';

class ReturnPurchaseBill extends StatefulWidget {
  const ReturnPurchaseBill({super.key});

  @override
  State<ReturnPurchaseBill> createState() => _ReturnPurchaseBill();
}

class _ReturnPurchaseBill extends State<ReturnPurchaseBill> {
  final CreatePurchaseReturnController createPurchaseReturnController =
      Get.put(CreatePurchaseReturnController());
  final CurrencyController currencyController = Get.put(CurrencyController());
  final PosController posController = Get.put(PosController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    createPurchaseReturnController
        .initializeProductArrays(posController.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Return Purchase Bill"),
      body: Obx(() => createPurchaseReturnController.isLoading.value
          ? const CustomLoading(
              withOpacity: 0.0,
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Date",
                                    isRequired: true,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDatePicker(
                                    hintText: "Select Date",
                                    initialDate: createPurchaseReturnController
                                        .selectedDate.value,
                                    onDateSelected: (DateTime date) {
                                      createPurchaseReturnController
                                          .selectedDate.value = date;
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
                                    text: "WareHouse",
                                    isRequired: true,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                      validatorText: "Warehouse",
                                      hintText: "Select Warehouse",
                                      dropdownItems:
                                          createPurchaseReturnController
                                                  .warehouseList.isEmpty
                                              ? ["Not Empty"]
                                              : createPurchaseReturnController
                                                  .warehouseList
                                                  .map((item) =>
                                                      item.name as String)
                                                  .toList(),
                                      onChanged: (value) {
                                        createPurchaseReturnController
                                                .warehouseId.value =
                                            createPurchaseReturnController
                                                    .warehouseList
                                                    .firstWhere((item) =>
                                                        item.name == value)
                                                    .id ??
                                                0;
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Supplier",
                                    isRequired: true,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                    validatorText: "Supplier",
                                    hintText: "Select Supplier",
                                    dropdownItems:
                                        createPurchaseReturnController
                                                .supplierList.isEmpty
                                            ? ["Not Found"]
                                            : createPurchaseReturnController
                                                .supplierList
                                                .map((item) => [
                                                      item.firstName ?? "",
                                                      item.lastName ?? ""
                                                    ].join(" ").trim())
                                                .toList(),
                                    onChanged: (value) {
                                      final selectedCustomer =
                                          createPurchaseReturnController
                                              .supplierList
                                              .firstWhere(
                                        (item) =>
                                            [
                                              item.firstName ?? "",
                                              item.lastName ?? ""
                                            ].join(" ").trim() ==
                                            value,
                                      );
                                      createPurchaseReturnController.supplierId
                                          .value = selectedCustomer.id ?? 0;
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
                                    text: "Return Status",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                      hintText: "Select Status",
                                      dropdownItems: [
                                        "Complete",
                                        "Incomplete",
                                        "Drafts"
                                      ],
                                      onChanged: (value) {
                                        createPurchaseReturnController
                                            .returnStatus.value = value ?? "";
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Remark",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomDropdownField(
                                      hintText: "Select Remark",
                                      dropdownItems: [
                                        "Date Expired",
                                        "Duplicate",
                                        "Not Good"
                                            "Package Broken"
                                      ],
                                      onChanged: (value) {
                                        createPurchaseReturnController
                                            .remarkStatus.value = value ?? "";
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomLabelText(
                                    text: "Return Note",
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  TextFormField(
                                    maxLines: 3,
                                    controller: createPurchaseReturnController
                                        .returnNoteController,
                                    decoration: InputDecoration(
                                        hintText: "Type here..."),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Visibility(
                          visible: posController.selectedItems.isNotEmpty,
                          child: Text(
                            "Sale Products",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.sp),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Visibility(
                            visible: posController.selectedItems.isEmpty,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Add at least one product',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.groceryPrimary
                                            .withOpacity(0.7)),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  CustomElevatedButton(
                                      buttonName: "Go Return Sale",
                                      onPressed: () {
                                        Get.back();
                                      }),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            )),
                        Visibility(
                            visible: posController.selectedItems.isNotEmpty,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: DataTable(
                                  showCheckboxColumn: false,
                                  border: TableBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                    horizontalInside: BorderSide(
                                      color: AppColors.groceryPrimary
                                          .withOpacity(0.2),
                                      width: 0.5,
                                    ),
                                    verticalInside: BorderSide(
                                      color: AppColors.groceryPrimary
                                          .withOpacity(0.2),
                                      width: 0.5,
                                    ),
                                  ),
                                  headingRowColor: WidgetStateProperty.all(
                                    AppColors.groceryPrimary.withOpacity(0.1),
                                  ),
                                  dataRowColor: WidgetStateProperty.resolveWith(
                                    (states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return AppColors.groceryPrimary
                                            .withOpacity(0.2);
                                      }
                                      return AppColors.groceryPrimary
                                          .withOpacity(0.05);
                                    },
                                  ),
                                  horizontalMargin: 15,
                                  columnSpacing: 40,
                                  headingRowHeight: 60,
                                  dataRowMaxHeight: 60,
                                  dividerThickness: 0.5,
                                  columns: const [
                                    DataColumn(
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      label: Text(
                                        'Products',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      label: Text(
                                        'Image',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      label: Text(
                                        'Tax',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      label: Text(
                                        'Discount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      label: Text(
                                        'Price',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      label: Text(
                                        'Quantity',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      label: Text(
                                        'Sub Total',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      label: Text(
                                        'Action',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      numeric: true,
                                    ),
                                  ],
                                  rows: List.generate(
                                    posController.selectedItems.length,
                                    (index) {
                                      final ProductsData product =
                                          posController.selectedItems[index];
                                      return DataRow(
                                        cells: [
                                          DataCell(Center(
                                            child: Text(product.title!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          )),
                                          DataCell(Center(
                                            child: FutureBuilder<String>(
                                              future: ApiPath.getImageUrl(
                                                  product.image!.path!),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const SizedBox();
                                                }
                                                if (snapshot.hasError) {
                                                  return const Icon(
                                                    Icons.broken_image,
                                                    size: 50,
                                                    color:
                                                        AppColors.groceryBorder,
                                                  );
                                                }
                                                return CircleAvatar(
                                                  backgroundColor: AppColors
                                                      .groceryPrimary
                                                      .withOpacity(0.05),
                                                  radius: 25,
                                                  child: Padding(
                                                    padding: REdgeInsets.all(4),
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          "assets/gif/loading.gif",
                                                      image: snapshot.data!,
                                                      imageErrorBuilder:
                                                          (context, error,
                                                                  stackTrace) =>
                                                              const Icon(
                                                        Icons.broken_image,
                                                        color: AppColors
                                                            .groceryRatingGray,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                          DataCell(
                                            Center(
                                              child: Text(
                                                "${product.tax} ${product.taxType == "Percent" ? "%" : "${currencyController.currencySymbol}"}",
                                              ),
                                            ),
                                          ),
                                          DataCell(Center(
                                            child: Text(
                                              "${product.discount} ${product.discountType == "Percent" ? "%" : "${currencyController.currencySymbol}"}",
                                            ),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              "${currencyController.currencySymbol}${product.price}",
                                            ),
                                          )),
                                          DataCell(Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (createPurchaseReturnController
                                                          .quantities[index] >
                                                      1) {
                                                    createPurchaseReturnController
                                                        .updateQuantity(
                                                            index,
                                                            createPurchaseReturnController
                                                                        .quantities[
                                                                    index] -
                                                                1,
                                                            posController
                                                                .selectedItems);
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .groceryPrimary,
                                                          width: 2)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: SvgPicture.asset(
                                                      "assets/icons/minus_button.svg",
                                                      width: 12,
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              AppColors
                                                                  .groceryPrimary,
                                                              BlendMode.srcIn),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${createPurchaseReturnController.quantities[index]}",
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  createPurchaseReturnController
                                                      .updateQuantity(
                                                          index,
                                                          createPurchaseReturnController
                                                                      .quantities[
                                                                  index] +
                                                              1,
                                                          posController
                                                              .selectedItems);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .groceryPrimary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .groceryPrimary,
                                                          width: 2)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: SvgPicture.asset(
                                                      "assets/icons/plus_button.svg",
                                                      width: 12,
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              AppColors
                                                                  .groceryWhite,
                                                              BlendMode.srcIn),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              "${currencyController.currencySymbol}${createPurchaseReturnController.subtotals[index].toStringAsFixed(2)}",
                                            ),
                                          )),
                                          DataCell(
                                            GestureDetector(
                                              onTap: () {
                                                showConfirmationDialog(context,
                                                    () {
                                                  posController.selectedItems
                                                      .removeAt(index);
                                                }, "Are you sure you want to remove this item?");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .grocerySecondary,
                                                        width: 1)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/close_icon.svg",
                                                    width: 12,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            AppColors
                                                                .grocerySecondary,
                                                            BlendMode.srcIn),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )),
                        Visibility(
                            visible: posController.selectedItems.isNotEmpty,
                            child: Divider(
                              height: 20.h,
                              color: AppColors.groceryPrimary,
                            )),
                        buildTotalSection(),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomElevatedButton(
                          buttonName: "Reset",
                          buttonColor: AppColors.grocerySecondary,
                          onPressed: () {
                            posController.selectedItems.clear();
                            createPurchaseReturnController.calculateSubtotals(
                                product: posController.selectedItems);
                          },
                        ),
                        CustomElevatedButton(
                          buttonName: "Create Return Purchase",
                          buttonColor: AppColors.groceryPrimary,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              createPurchaseReturnController
                                  .postReturnPurchaseCreate(
                                      product: posController.selectedItems);
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                  ],
                ),
              ),
            )),
    );
  }

  Widget buildTotalSection() {
    double totalBasePrice = posController.selectedItems.fold(
        0.0,
        (sum, product) =>
            sum +
            (double.parse(product.price!) *
                createPurchaseReturnController
                    .quantities[posController.selectedItems.indexOf(product)]));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
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
              columns: const [
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text("Item",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text("Price",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text("Tax",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text("Discount",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text("Total",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Center(
                    child: Text(
                      "${posController.selectedItems.length}",
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      "${currencyController.currencySymbol}${totalBasePrice.toStringAsFixed(2)}",
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      "${currencyController.currencySymbol}${createPurchaseReturnController.totalTax.toStringAsFixed(2)}",
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      "${currencyController.currencySymbol}${createPurchaseReturnController.totalDiscount.toStringAsFixed(2)}",
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      "${currencyController.currencySymbol}${createPurchaseReturnController.totalSubtotals.toStringAsFixed(2)}",
                    ),
                  )),
                ])
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomLabelText(text: "Shipping"),
            SizedBox(
              height: 5.h,
            ),
            TextField(
              controller: createPurchaseReturnController.shippingAmount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "0",
              ),
              onChanged: (value) {
                createPurchaseReturnController.calculateSubtotals(
                    product: posController.selectedItems);
              },
            ),
          ],
        ),
        SizedBox(height: 10.h),
        buildGrandTotalSection()
      ],
    );
  }

  Widget buildGrandTotalSection() {
    return Container(
      padding: REdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.groceryPrimary.withAlpha(10),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: AppColors.groceryPrimary.withAlpha(50), width: 1)),
      child: Text(
        "Grand Total : ${currencyController.currencySymbol}${createPurchaseReturnController.totalSubtotals.toStringAsFixed(2)}",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
      ),
    );
  }

  void showConfirmationDialog(
      BuildContext context, Function onYesPressed, subText) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: AppColors.groceryWhite,
        title: Text(
          "Confirmation",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        content: Text(
          subText,
          style: TextStyle(
            fontSize: 11.sp,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              onYesPressed();
              createPurchaseReturnController.calculateSubtotals(
                  product: posController.selectedItems);
              Navigator.of(context).pop();
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}

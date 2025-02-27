import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/orders/controller/customer_orders_controller.dart';
import 'package:invoshop/screens/orders/view/sub_sections/customer_product_details.dart';

class CustomerOrdersScreen extends StatefulWidget {
  const CustomerOrdersScreen({super.key});

  @override
  State<CustomerOrdersScreen> createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
  final CustomerOrdersController customerOrdersController =
      Get.put(CustomerOrdersController());
  final CurrencyController currencyController = Get.put(CurrencyController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Orders"),
      body: Obx(() {
        if (customerOrdersController.isLoading.value) {
          return const CustomLoading(withOpacity: 0.0);
        }

        if (customerOrdersController.customerOrdersList.isEmpty) {
          return _buildNoOrdersMessage();
        }

        if (customerOrdersController.selectedRows.length !=
            customerOrdersController.customerOrdersList.length) {
          customerOrdersController.selectedRows.assignAll(
            List<bool>.filled(
                customerOrdersController.customerOrdersList.length, false),
          );
        }

        return RefreshIndicator(
          backgroundColor: AppColors.groceryBody,
          color: AppColors.groceryPrimary,
          onRefresh: customerOrdersController.getCustomerOrders,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 12.h),
                  _buildAcceptAllButton(),
                  SizedBox(height: 10.h),
                  _buildDataTable(),
                  SizedBox(height: 12.h),
                ],
              ),
              Obx(
                () => Visibility(
                  visible: customerOrdersController.isStatusUpdateLoading.value,
                  child: const CustomLoading(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildNoOrdersMessage() {
    return Center(
      child: Text(
        'No customer orders available',
        style: TextStyle(
          fontSize: 13.sp,
          color: AppColors.groceryPrimary.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _buildAcceptAllButton() {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: CustomElevatedButton(
          buttonName: "Accept All",
          onPressed: () async {
            if (customerOrdersController.selectedRows.contains(true)) {
              showDialog(
                context: context,
                builder: (context) => _buildAcceptAlertDialog(
                  acceptType: "Update All",
                  onTap: () async {
                    Get.back();
                    _buildBottomSheetWidget();
                  },
                ),
              );
            } else {
              Fluttertoast.showToast(
                msg: "No orders selected",
                backgroundColor: AppColors.grocerySecondary,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
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
              headingRowColor: MaterialStateProperty.all(
                  AppColors.groceryPrimary.withOpacity(0.1)),
              dataRowColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.groceryPrimary.withOpacity(0.2);
                }
                return AppColors.groceryPrimary.withOpacity(0.05);
              }),
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
      DataColumn(
        label: Checkbox(
          value: customerOrdersController.isHeaderChecked.value,
          onChanged: (bool? value) {
            customerOrdersController.toggleAllCheckboxes();
          },
          activeColor: AppColors.groceryPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: BorderSide(
            color: AppColors.groceryPrimary.withOpacity(0.4),
            width: 1.0,
          ),
        ),
      ),
      _buildTableHeader("SL"),
      _buildTableHeader("Order Date"),
      _buildTableHeader("Delivery Area"),
      _buildTableHeader("Delivery Type"),
      _buildTableHeader("Shipping Method"),
      _buildTableHeader("Amount"),
      _buildTableHeader("Tax Amount"),
      _buildTableHeader("Discount"),
      _buildTableHeader("Shipping Amount"),
      _buildTableHeader("Order Status"),
      _buildTableHeader("Total Amount"),
      _buildTableHeader("Action"),
    ];
  }

  DataColumn _buildTableHeader(String label) {
    return DataColumn(
      label: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.groceryPrimary,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildTableRows() {
    return customerOrdersController.customerOrdersList
        .asMap()
        .entries
        .map((entry) {
      final int index = entry.key;
      final order = entry.value;
      final actionButtonKey = GlobalKey(debugLabel: 'action_button_$index');

      return DataRow(
        selected: customerOrdersController.selectedRows[index],
        onSelectChanged: (bool? value) {
          customerOrdersController.toggleProductSelection(index, value);
        },
        cells: [
          DataCell(
            Checkbox(
              value: customerOrdersController.selectedRows[index],
              onChanged: (bool? value) {
                customerOrdersController.toggleProductSelection(index, value);
              },
              activeColor: AppColors.groceryPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                color: AppColors.groceryPrimary.withOpacity(0.4),
                width: 1.0,
              ),
            ),
          ),
          DataCell(Center(child: Text('${index + 1}'))),
          _buildDataCell(DateFormat("dd-MM-yyyy")
              .format(DateTime.parse(order.createdAt!))),
          _buildDataCell(order.deliveryAreaName ?? 'N/A'),
          _buildDataCell(order.deliveryType ?? 'N/A'),
          _buildDataCell(order.shippingMethod ?? 'N/A'),
          _buildDataCell(
              '${currencyController.currencySymbol}${order.amount ?? '0.00'}'),
          _buildDataCell(
              '${currencyController.currencySymbol}${order.taxAmount ?? '0.00'}'),
          _buildDataCell(order.discount ?? '0.00'),
          _buildDataCell(
              '${currencyController.currencySymbol}${order.shippingAmount ?? '0.00'}'),
          _buildDataCell(order.status ?? 'N/A'),
          _buildDataCell(
              '${currencyController.currencySymbol}${order.totalAmount ?? '0.00'}'),
          DataCell(
            OutlinedButton(
              key: actionButtonKey,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                side: BorderSide(
                  color: AppColors.groceryPrimary.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              onPressed: () {
                if (customerOrdersController.selectedRows.contains(true)) {
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
                          showDialog(
                            context: context,
                            builder: (context) => _buildAcceptAlertDialog(
                              acceptType: "Update",
                              onTap: () async {
                                Get.back();
                                _buildBottomSheetWidget();
                              },
                            ),
                          );
                        },
                        value: 'Receive',
                        child: const Row(
                          children: [
                            Icon(
                              Icons.update,
                              color: AppColors.groceryPrimary,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text('Receive'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        onTap: () {
                          Get.to(CustomerProductDetails(order: order));
                        },
                        value: 'View',
                        child: const Row(
                          children: [
                            Icon(
                              Icons.view_agenda,
                              color: AppColors.groceryPrimary,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text('View'),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "No orders selected",
                    backgroundColor: AppColors.grocerySecondary,
                  );
                }
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

  Widget _buildAcceptAlertDialog({
    required String acceptType,
    required VoidCallback onTap,
  }) {
    return AlertDialog(
      elevation: 0.5,
      backgroundColor: AppColors.groceryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      content: SizedBox(
        height: 120.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.groceryWarning,
              size: 80,
            ),
            SizedBox(height: 5.h),
            Text(
              textAlign: TextAlign.center,
              acceptType == "Update"
                  ? "Did you receive this product?"
                  : "Did you receive selected products?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomElevatedButton(
          buttonName: "Confirm",
          onPressed: onTap,
        ),
        CustomElevatedButton(
          buttonColor: AppColors.groceryRatingGray,
          buttonName: "Cancel",
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  void _buildBottomSheetWidget() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: AppColors.groceryBodyTwo,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Section
                Text(
                  "Review",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.groceryPrimary,
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.groceryRatingGray.withOpacity(0.5),
                  indent: 8,
                  endIndent: 8,
                ),

                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Rate Your Experience",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.groceryRatingGray,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => GestureDetector(
                            onTap: () {
                              customerOrdersController.selectedRating.value =
                                  index + 1;
                            },
                            child: Obx(
                              () => Icon(
                                Icons.star,
                                size: 35.sp,
                                color: (index + 1) <=
                                        customerOrdersController
                                            .selectedRating.value
                                    ? AppColors.groceryRating
                                    : AppColors.groceryRatingGray,
                              ),
                            ),
                          ),
                        ).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: TextFormField(
                    maxLines: 4,
                    maxLength: 200,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Review is required field";
                      }
                      return null;
                    },
                    controller:
                        customerOrdersController.reviewContentController,
                    decoration: InputDecoration(
                      hintText: "Write your review here...",
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                CustomElevatedButton(
                  buttonName: "Submit Review",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (customerOrdersController.selectedRating.value > 0) {
                        Get.back();
                        await customerOrdersController.postProductReviewSave();
                        customerOrdersController.selectedProductIds.clear();
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please select a rating",
                          backgroundColor: AppColors.grocerySecondary,
                        );
                      }
                    }
                  },
                  buttonColor: AppColors.groceryPrimary,
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

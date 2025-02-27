import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/orders/controller/customer_orders_controller.dart';
import 'package:invoshop/screens/orders/model/customer_order_model.dart';

class CustomerProductDetails extends StatefulWidget {
  final CustomerOrderData order;

  const CustomerProductDetails({super.key, required this.order});

  @override
  State<CustomerProductDetails> createState() => _CustomerProductDetailsState();
}

class _CustomerProductDetailsState extends State<CustomerProductDetails> {
  final CustomerOrdersController customerOrdersController =
      Get.put(CustomerOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarName: "Order Details",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusCard(),
                const SizedBox(height: 20),
                _buildOrderDetails(),
                const SizedBox(height: 20),
                _buildProductList(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Obx(
            () => Visibility(
              visible: customerOrdersController.isStatusUpdateLoading.value,
              child: CustomLoading(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.groceryPrimary.withOpacity(0.4),
            AppColors.groceryPrimary.withOpacity(0.8)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.groceryPrimary.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order #${widget.order.id?.toString() ?? 'N/A'}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.groceryWhite,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    widget.order.totalAmount ?? "N/A",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.groceryWhite,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.groceryWhite.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.order.deliveryType ?? "N/A",
                  style: const TextStyle(
                    color: AppColors.groceryWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Card(
      color: AppColors.groceryRatingGray.withOpacity(0.08),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.groceryBorder, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.receipt_long,
                    color: AppColors.groceryPrimary.withOpacity(0.8)),
                const SizedBox(width: 10),
                Text(
                  "Order Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.groceryPrimary.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            _buildDetailRow(
                "Amount", widget.order.amount ?? "N/A", Icons.monetization_on),
            _buildDetailRow("Tax Amount", widget.order.taxAmount ?? "N/A",
                Icons.account_balance),
            _buildDetailRow(
                "Discount", widget.order.discount ?? "N/A", Icons.local_offer),
            _buildDetailRow("Shipping Amount",
                widget.order.shippingAmount ?? "N/A", Icons.local_shipping),
            _buildDetailRow("Sale Date", widget.order.saleDateAt ?? "N/A",
                Icons.calendar_today),
            _buildDetailRow("Shipping Method",
                widget.order.shippingMethod ?? "N/A", Icons.delivery_dining),
            _buildDetailRow("Tracking ID", widget.order.trackingId ?? "N/A",
                Icons.track_changes),
            _buildDetailRow("Delivery Area",
                widget.order.deliveryAreaName ?? "N/A", Icons.location_on),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    final products = widget.order.orderProducts;
    if (products == null || products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      color: AppColors.groceryRatingGray.withOpacity(0.08),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.groceryBorder, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_bag,
                    color: AppColors.groceryPrimary.withOpacity(0.8)),
                const SizedBox(width: 10),
                Text(
                  "Products",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.groceryPrimary.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                if (product.product == null) {
                  return const SizedBox.shrink();
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.groceryWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.groceryRatingGray.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.groceryPrimary.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.inventory_2,
                              color: AppColors.groceryPrimary.withOpacity(0.8),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product.product?.title ?? "N/A",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                          visible:
                                              product.isRefundRequested == 0,
                                          child: CustomElevatedButton(
                                              verticalPadding: 0,
                                              horizontalPadding: 0,
                                              buttonName: "Refund",
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      _buildAcceptAlertDialog(
                                                    onTap: () async {
                                                      Get.back();
                                                      customerOrdersController
                                                          .postProductRefundSave(
                                                              orderProductId:
                                                                  product.id
                                                                      .toString());
                                                    },
                                                  ),
                                                );
                                              }))
                                    ]),
                                _buildProductDetailRow("Quantity",
                                    product.quantity?.toString() ?? "N/A"),
                                _buildProductDetailRow(
                                    "Amount", product.amount ?? "N/A"),
                                _buildProductDetailRow(
                                    "Tax Amount", product.taxAmount ?? "N/A"),
                                _buildProductDetailRow(
                                    "Sale Amount", product.saleAmount ?? "N/A"),
                                _buildProductDetailRow(
                                    "Sale Status", product.saleStatus ?? "N/A"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptAlertDialog({
    required VoidCallback onTap,
  }) {
    return AlertDialog(
      elevation: 0.5,
      backgroundColor: AppColors.groceryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      content: SizedBox(
        height: 150.h,
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
              "Are you sure you will be able to refund this product?",
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
}

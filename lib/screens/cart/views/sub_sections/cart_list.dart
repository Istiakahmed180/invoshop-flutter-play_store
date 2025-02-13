import 'package:ai_store/common/controller/checkout_controller.dart';
import 'package:ai_store/common/controller/wish_cart_list_controller.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/cart/views/sub_sections/order_summary.dart';
import 'package:ai_store/screens/home/model/products_model.dart' as model;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  final WishListAndCartListController wishListAndCartListController =
      Get.put(WishListAndCartListController());
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final TextEditingController couponController = TextEditingController();
  final Map<String, TextEditingController> _quantityControllers = {};
  final Map<String, FocusNode> _focusNodes = {};

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      wishListAndCartListController.fetchCartListProducts();
      checkoutController.getCourier();
      checkoutController.courierID.value = 0;
    });
  }

  @override
  void dispose() {
    _quantityControllers.forEach((key, controller) {
      controller.dispose();
    });
    _focusNodes.forEach((key, node) => node.dispose());
    super.dispose();
  }

  TextEditingController _getControllerForProduct(model.ProductsData product) {
    return _quantityControllers.putIfAbsent(
      product.id.toString(),
      () => TextEditingController(text: product.quantity.toString())
        ..selection =
            TextSelection.collapsed(offset: product.quantity.toString().length),
    );
  }

  FocusNode _getFocusNodeForProduct(model.ProductsData product) {
    return _focusNodes.putIfAbsent(
      product.id.toString(),
      () => FocusNode(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (wishListAndCartListController.isLoading.value ||
          checkoutController.isLoading.value) {
        return const CustomLoading(
          withOpacity: 0.0,
        );
      }

      if (wishListAndCartListController.cartProductsList.isEmpty) {
        return Center(
          child: Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 16.sp, color: AppColors.groceryTextTwo),
          ),
        );
      } else {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: REdgeInsets.all(12),
                itemCount:
                    wishListAndCartListController.cartProductsList.length,
                itemBuilder: (context, index) {
                  final product =
                      wishListAndCartListController.cartProductsList[index];
                  final double price =
                      double.tryParse(product.price.toString()) ?? 0;
                  final int quantity =
                      int.tryParse(product.quantity.toString()) ?? 1;
                  final double productPrice = price * quantity;
                  final imageUrl = wishListAndCartListController
                          .getImageUrl(product.image?.path) ??
                      '';
                  final bool isLastItem = index ==
                      wishListAndCartListController.cartProductsList.length - 1;
                  return _buildCartList(
                      imageUrl, product, productPrice, isLastItem);
                },
              ),
            ),
            Container(
              padding: REdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.groceryPrimary.withOpacity(0.08),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r))),
              child: Column(
                children: [
                  _summaryRow('Subtotal:',
                      wishListAndCartListController.subtotal.value),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      buttonName: "Checkout",
                      verticalPadding: 10,
                      onPressed: () {
                        Get.to(const OrderSummary());
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }
    });
  }

  Widget _buildCartList(String imageUrl, model.ProductsData product,
      double productPrice, bool isLastItem) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 90.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: AppColors.groceryBodyTwo,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                      Image.asset("assets/gif/loading.gif"),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title!,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.groceryTitle),
                            ),
                            Text(
                              "500Gm",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.groceryTextTwo,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close,
                            size: 18.sp, color: AppColors.groceryText),
                        onPressed: () {
                          wishListAndCartListController.removeFromCart(product);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$${productPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.groceryPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      _quantityControl(product),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!isLastItem)
          const Divider(
            color: AppColors.groceryBorder,
            thickness: 1,
          ),
      ],
    );
  }

  Widget _quantityControl(model.ProductsData product) {
    var quantityController = _getControllerForProduct(product);
    var focusNode = _getFocusNodeForProduct(product);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.groceryBorder),
        borderRadius: BorderRadius.circular(4),
      ),
      height: 30.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _quantityButton(Icons.remove, () {
            checkoutController.shippingCharge.value = 0.0;
            int newQuantity = (product.quantity ?? 1) - 1;
            if (newQuantity < 1) {
              newQuantity = 1;
            }
            quantityController.text = newQuantity.toString();
            wishListAndCartListController.updateQuantity(product, newQuantity);
          }),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.groceryBodyTwo,
              border: Border(
                left: BorderSide(width: 1.0, color: AppColors.groceryBorder),
                right: BorderSide(width: 1.0, color: AppColors.groceryBorder),
              ),
            ),
            width: 50.w,
            height: 30.h,
            alignment: Alignment.center,
            child: TextField(
              controller: quantityController,
              focusNode: focusNode,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.groceryText,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
              ),
              onChanged: (newQuantity) {
                if (newQuantity.isEmpty) {
                } else {
                  int quantity =
                      int.tryParse(newQuantity) ?? product.quantity ?? 1;
                  wishListAndCartListController.updateQuantity(
                      product, quantity);
                  checkoutController.shippingCharge.value = 0.0;
                }
              },
              onEditingComplete: () {
                if (quantityController.text.isEmpty) {
                  quantityController.text = '1';
                  wishListAndCartListController.updateQuantity(product, 1);
                }
                focusNode.unfocus();
              },
            ),
          ),
          _quantityButton(Icons.add, () {
            checkoutController.shippingCharge.value = 0.0;
            int newQuantity = (product.quantity ?? 1) + 1;
            quantityController.text = newQuantity.toString();
            wishListAndCartListController.updateQuantity(product, newQuantity);
          }),
        ],
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 36.w,
          height: 40.h,
          alignment: Alignment.center,
          child: Icon(icon, size: 20.sp, color: AppColors.groceryPrimary),
        ),
      ),
    );
  }

  Widget _summaryRow(String title, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.groceryPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

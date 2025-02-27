import 'dart:convert';

import 'package:invoshop/common/controller/checkout_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/home/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishListAndCartListController extends GetxController {
  final CheckoutController checkoutController = Get.put(CheckoutController());

  final RxInt wishlistItemCount = 0.obs;
  final RxBool isLoading = false.obs;
  final RxInt cartItemCount = 0.obs;
  final RxDouble subtotal = 0.0.obs;
  final RxDouble total = 0.0.obs;
  final RxDouble deliveryFee = 20.0.obs;
  final RxDouble productTax = 0.0.obs;
  final RxDouble discount = 0.0.obs;
  final RxString selectedDeliveryMethod = 'Delivery In Country'.obs;
  final RxMap<String, String> imageUrlCache = <String, String>{}.obs;

  final RxList<ProductsData> wishlistProductList = <ProductsData>[].obs;
  final RxList<ProductsData> cartProductsList = <ProductsData>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadWishlist();
    loadCartList();

    ever(checkoutController.couponAmount, (_) => calculateTotals());
    ever(checkoutController.shippingCharge, (_) => calculateTotals());
  }

  Future<void> toggleWishlistItem(ProductsData product) async {
    try {
      if (wishlistProductList.any((p) => p.id == product.id)) {
        removeFromWishlist(product);
        _showToast("Removed From Wishlist", AppColors.grocerySecondary);
      } else {
        addToWishlist(product);
        _showToast("Saved To Wishlist", AppColors.groceryPrimary);
      }
    } catch (e) {
      _showToast("Failed to update wishlist.", AppColors.grocerySecondary);
    }
  }

  Future<void> addToWishlist(ProductsData product) async {
    try {
      wishlistProductList.add(product);
      wishlistItemCount.value = wishlistProductList.length;
      if (product.image?.path != null) {
        final url = await ApiPath.getImageUrl(product.image!.path!);
        imageUrlCache[product.image!.path!] = url;
      }
      await saveWishlist();
    } catch (e) {
      _showToast(
          "Failed to add product to wishlist.", AppColors.grocerySecondary);
    }
  }

  void removeFromWishlist(ProductsData product) {
    wishlistProductList.removeWhere((p) => p.id == product.id);
    wishlistItemCount.value = wishlistProductList.length;
    saveWishlist();
  }

  Future<void> saveWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wishlistJson = jsonEncode(
        wishlistProductList.map((product) => product.toJson()).toList(),
      );
      await prefs.setString('wishlist', wishlistJson);
    } catch (e) {
      _showToast("Failed to save wishlist.", AppColors.grocerySecondary);
    }
  }

  Future<void> loadWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wishlistJson = prefs.getString('wishlist') ?? '[]';
      final List<dynamic> wishlistData = jsonDecode(wishlistJson);
      wishlistProductList.assignAll(
        wishlistData.map((data) => ProductsData.fromJson(data)).toList(),
      );
      wishlistItemCount.value = wishlistProductList.length;
    } catch (e) {
      _showToast("Failed to load wishlist.", AppColors.grocerySecondary);
    }
  }

  Future<void> fetchWishlistProducts() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      await Future.wait(wishlistProductList.map((product) async {
        if (product.image?.path != null) {
          try {
            final url = await ApiPath.getImageUrl(product.image!.path!);
            imageUrlCache[product.image!.path!] = url;
          } catch (e) {
            _showToast("Failed to load image for product ${product.id}",
                AppColors.grocerySecondary);
          }
        }
      }));
    } catch (e) {
      _showToast(
          "Error fetching wishlist products", AppColors.grocerySecondary);
    } finally {
      isLoading.value = false;
    }
  }

  String? getImageUrl(String? imagePath) {
    if (imagePath == null) return null;
    if (!imageUrlCache.containsKey(imagePath)) {
      ApiPath.getImageUrl(imagePath).then((url) {
        imageUrlCache[imagePath] = url;
      });
      return null;
    }
    return imageUrlCache[imagePath];
  }

  Future<void> addToCart(ProductsData product) async {
    try {
      final existingProductIndex =
          cartProductsList.indexWhere((p) => p.id == product.id);

      if (existingProductIndex != -1) {
        final existingProduct = cartProductsList[existingProductIndex];
        existingProduct.quantity = (existingProduct.quantity ?? 1) + 1;
        cartProductsList[existingProductIndex] = existingProduct;
        _showToast("Increased Quantity", AppColors.groceryPrimary);
      } else {
        product.quantity = 1;
        cartProductsList.add(product);
        _showToast("Added to Cart", AppColors.groceryPrimary);
      }
      cartItemCount.value = cartProductsList.length;
      if (product.image?.path != null) {
        final url = await ApiPath.getImageUrl(product.image!.path!);
        imageUrlCache[product.image!.path!] = url;
      }
      await saveCartList();
      calculateTotals();
    } catch (e) {
      _showToast("Failed to add product to cart.", AppColors.grocerySecondary);
    }
  }

  Future<void> saveCartList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = jsonEncode(
        cartProductsList.map((product) => product.toJson()).toList(),
      );
      await prefs.setString('cart', cartJson);
    } catch (e) {
      _showToast("Failed to save cart list.", AppColors.grocerySecondary);
    }
  }

  Future<void> loadCartList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString('cart');
      if (cartJson != null) {
        final List<dynamic> cartList = jsonDecode(cartJson);
        cartProductsList.value =
            cartList.map((json) => ProductsData.fromJson(json)).toList();
        cartItemCount.value = cartProductsList.length;
      }
      calculateTotals();
    } catch (e) {
      _showToast("Failed to load cart.", AppColors.grocerySecondary);
    }
  }

  Future<void> removeFromCart(ProductsData product) async {
    try {
      cartProductsList.remove(product);
      cartItemCount.value = cartProductsList.length;
      await saveCartList();
      calculateTotals();
    } catch (e) {
      _showToast(
          "Failed to remove product from cart.", AppColors.grocerySecondary);
    }
  }

  Future<void> fetchCartListProducts() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      await Future.wait(cartProductsList.map((product) async {
        if (product.image?.path != null) {
          try {
            final url = await ApiPath.getImageUrl(product.image!.path!);
            imageUrlCache[product.image!.path!] = url;
          } catch (e) {
            _showToast("Failed to load image for product ${product.id}",
                AppColors.grocerySecondary);
          }
        }
      }));
    } catch (e) {
      _showToast(
          "Error fetching wishlist products", AppColors.grocerySecondary);
    } finally {
      isLoading.value = false;
    }
  }

  void calculateTotals() {
    subtotal.value = cartProductsList.fold(0.0, (sum, product) {
      final double price = double.tryParse(product.price.toString()) ?? 0.0;
      final int quantity = product.quantity ?? 1;
      return sum + (price * quantity);
    });
    productTax.value = cartProductsList.fold(0.0, (sum, product) {
      final double tax = double.tryParse(product.tax.toString()) ?? 0.0;
      final int quantity = product.quantity ?? 1;
      return sum + (tax * quantity);
    });
    if (checkoutController.couponAmount.value > 0) {
      if (checkoutController.couponType.value == "Fixed") {
        discount.value = checkoutController.couponAmount.value;
      } else if (checkoutController.couponType.value == "Percentage") {
        discount.value =
            (subtotal.value * checkoutController.couponAmount.value) / 100;
      } else {
        discount.value = 0.0;
      }
    } else {
      discount.value = 0.0;
    }
    total.value = subtotal.value +
        productTax.value +
        checkoutController.shippingCharge.value -
        discount.value;
    total.value = total.value < 0 ? 0 : total.value;
  }

  void updateQuantity(ProductsData product, int newQuantity) {
    if (newQuantity == 0) {
      return;
    }
    int index = cartProductsList.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      ProductsData updatedProduct = cartProductsList[index];
      updatedProduct.quantity = newQuantity;
      cartProductsList[index] = updatedProduct;
      update();
      calculateTotals();
    }
  }

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: backgroundColor,
    );
  }
}

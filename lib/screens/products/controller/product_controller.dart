import 'dart:convert';

import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/category/models/category_data.dart';
import 'package:invoshop/screens/products/models/product_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxInt cartItemCount = 0.obs;
  final RxString productId = ''.obs;
  final RxInt currentStep = 0.obs;
  final RxString selectedCategory = ''.obs;
  final RxString selectedDeliveryMethod = 'Delivery In Country'.obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxList<Product> allProducts = <Product>[].obs;
  final RxList<Product> cartProducts = <Product>[].obs;
  final RxList<Product> detailsProduct = <Product>[].obs;
  final RxList<Product> wishlistProducts = <Product>[].obs;
  final RxInt wishlistItemCount = 0.obs;

  final RxDouble subtotal = 0.0.obs;
  final RxDouble deliveryFee = 20.0.obs;
  final RxDouble discount = 0.0.obs;
  final RxDouble total = 0.0.obs;
  final RxString promoCode = ''.obs;
  final RxBool promoApplied = false.obs;

  @override
  void onInit() {
    super.onInit();
    allProducts.addAll(productList);
    filterProducts();
    loadCart();
    loadWishlist();
    calculateTotals();
  }

  Future<void> clearCart() async {
    cartProducts.clear();
    cartItemCount.value = 0;
    subtotal.value = 0.0;
    total.value = 0.0;
    await saveCart();
  }

  void calculateTotals() {
    subtotal.value = cartProducts.fold(
        0.0, (sum, product) => sum + (product.price * (product.quantity ?? 1)));

    total.value = subtotal.value + deliveryFee.value - discount.value;

    if (cartProducts.isEmpty) {
      discount.value = 0.0;
      promoApplied.value = false;
    }
  }

  void setDeliveryMethod(String deliveryMethod) {
    selectedDeliveryMethod.value = deliveryMethod;
    if (deliveryMethod == 'Delivery In Country') {
      deliveryFee.value = 20.0;
    } else if (deliveryMethod == 'Delivery Out Of Country') {
      deliveryFee.value = 25.0;
    }
    calculateTotals();
  }

  int getTotalCartQuantity() {
    return cartProducts.fold(
        0, (total, product) => total + (product.quantity ?? 0));
  }

  void onCategorySelected(int index) {
    selectedIndex.value = index;
    filterProducts();
  }

  void productDetails(String id) {
    productId.value = id;
  }

  void filterProducts() {
    if (selectedIndex.value == 0) {
      filteredProducts.value = allProducts;
    } else {
      final selectedCategoryTitle = categoryData[selectedIndex.value - 1].title;
      filteredProducts.value = allProducts.where((product) {
        return product.category == selectedCategoryTitle ||
            product.parentCategory == selectedCategoryTitle;
      }).toList();
    }
  }

  void filterProductsByCategory(RxString? category) {
    filteredProducts.value = allProducts.where((product) {
      return product.category as RxString == category ||
          product.parentCategory as RxString == category;
    }).toList();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filterProducts();
    } else {
      filteredProducts.value = allProducts.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void resetFilters() {
    selectedIndex.value = 0;
    filterProducts();
  }

  void updateQuantity(Product product, int newQuantity) {
    if (newQuantity == 0) {
      return;
    }

    int index = cartProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      Product updatedProduct = cartProducts[index];
      updatedProduct.quantity = newQuantity;
      cartProducts[index] = updatedProduct;
      update();
      calculateTotals();
    }
  }

  Future<void> addToWishlist(Product product) async {
    try {
      if (!wishlistProducts.contains(product)) {
        wishlistProducts.add(product);
      }
      wishlistItemCount.value = wishlistProducts.length;
      await saveWishlist();
    } catch (e) {
      Get.snackbar("Error", "Failed to add product to wishlist.");
    }
  }

  Future<void> addToWishlistFromProductCard(Product product) async {
    try {
      if (!wishlistProducts.contains(product)) {
        wishlistProducts.add(product);
        wishlistItemCount.value = wishlistProducts.length;
        await saveWishlist();
        Fluttertoast.showToast(
            msg: "Saved To Wishlist",
            backgroundColor: AppColors.groceryPrimary,
            textColor: AppColors.groceryWhite);
      } else {
        wishlistProducts.remove(product);
        wishlistItemCount.value = wishlistProducts.length;
        await saveWishlist();
        Fluttertoast.showToast(
            msg: "Removed From Wishlist",
            backgroundColor: AppColors.grocerySecondary,
            textColor: AppColors.groceryWhite);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update wishlist.",
          backgroundColor: AppColors.groceryPrimary,
          colorText: AppColors.groceryWhite);
    }
  }

  Future<void> removeFromWishlist(Product product) async {
    try {
      wishlistProducts.remove(product);
      wishlistItemCount.value = wishlistProducts.length;
      await saveWishlist();
    } catch (e) {
      Get.snackbar("Error", "Failed to remove product from wishlist.");
    }
  }

  Future<void> saveWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wishlistJson = jsonEncode(
          wishlistProducts.map((product) => product.toJson()).toList());
      await prefs.setString('wishlist', wishlistJson);
    } catch (e) {
      Get.snackbar("Error", "Failed to save wishlist.");
    }
  }

  Future<void> loadWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wishlistJson = prefs.getString('wishlist');
      if (wishlistJson != null) {
        final List<dynamic> wishlistList = jsonDecode(wishlistJson);
        wishlistProducts.value =
            wishlistList.map((json) => Product.fromJson(json)).toList();
        wishlistItemCount.value = wishlistProducts.length;
      }
    } finally {}
  }

  Future<void> saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentCartJson =
          jsonEncode(cartProducts.map((product) => product.toJson()).toList());
      await prefs.setString('cart', currentCartJson);
    } catch (e) {
      Get.snackbar("Error", "Failed to save cart.");
    }
  }

  Future<void> addToCart(Product product) async {
    try {
      final existingProductIndex =
          cartProducts.indexWhere((p) => p.id == product.id);
      if (existingProductIndex != -1) {
        final existingProduct = cartProducts[existingProductIndex];
        existingProduct.quantity = (existingProduct.quantity ?? 1) + 1;
        cartProducts[existingProductIndex] = existingProduct;

        Fluttertoast.showToast(
            msg: "Incress Quantity",
            backgroundColor: AppColors.groceryPrimary,
            textColor: AppColors.groceryWhite);
      } else {
        Fluttertoast.showToast(
            msg: "Added to cart",
            backgroundColor: AppColors.groceryPrimary,
            textColor: AppColors.groceryWhite);
        product.quantity = 1;
        cartProducts.add(product);
      }
      cartItemCount.value = cartProducts.length;
      await saveCart();
      calculateTotals();
    } catch (e) {
      Get.snackbar("Error", "Failed to add product to cart.");
    }
  }

  Future<void> addToCartFromDetailsPage(Product product) async {
    try {
      final existingProductIndex =
          cartProducts.indexWhere((p) => p.id == product.id);
      if (existingProductIndex != -1) {
      } else {
        product.quantity = 1;
        cartProducts.add(product);
      }
      cartItemCount.value = cartProducts.length;
      await saveCart();
      calculateTotals();
    } catch (e) {
      Get.snackbar("Error", "Failed to add product to cart.");
    }
  }

  Future<void> decreaseQuantity(Product product) async {
    try {
      final existingProductIndex =
          cartProducts.indexWhere((p) => p.id == product.id);
      if (existingProductIndex != -1) {
        final existingProduct = cartProducts[existingProductIndex];
        if (existingProduct.quantity! > 0) {
          existingProduct.quantity = (existingProduct.quantity ?? 1) - 1;
          cartProducts[existingProductIndex] = existingProduct;
        } else {
          cartProducts.removeAt(existingProductIndex);
        }
        cartItemCount.value = cartProducts.length;
        await saveCart();
        calculateTotals();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to decrease product quantity.");
    }
  }

  Future<void> increaseQuantity(Product product) async {
    try {
      final existingProductIndex =
          cartProducts.indexWhere((p) => p.id == product.id);
      if (existingProductIndex != -1) {
        final existingProduct = cartProducts[existingProductIndex];
        existingProduct.quantity = (existingProduct.quantity ?? 1) + 1;
        cartProducts[existingProductIndex] = existingProduct;
        cartItemCount.value = cartProducts.length;
        await saveCart();
        calculateTotals();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to increase product quantity.");
    }
  }

  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString('cart');
      if (cartJson != null) {
        final List<dynamic> cartList = jsonDecode(cartJson);
        cartProducts.value =
            cartList.map((json) => Product.fromJson(json)).toList();
        cartItemCount.value = cartProducts.length;
      }
      calculateTotals();
    } finally {}
  }

  Future<void> removeFromCart(Product product) async {
    try {
      cartProducts.remove(product);
      cartItemCount.value = cartProducts.length;
      await saveCart();
      calculateTotals();
    } catch (e) {
      Get.snackbar("Error", "Failed to remove product from cart.");
    }
  }
}

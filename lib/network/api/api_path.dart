import 'package:shared_preferences/shared_preferences.dart';

class ApiPath {
  static const String baseUrl = 'https://inventual.app/api/v1';
  static const String webViewUrl = 'https://inventual.app/login';
  static const String baseImageUrl = 'https://inventual.app/storage/';

  static String dynamicBaseUrl({required String supplierKey}) =>
      'https://$supplierKey.inventual.app/api/v1';

  static String dynamicWebViewUrl({required String supplierKey}) =>
      'https://$supplierKey.inventual.app/login';

  static String dynamicBaseImageUrl({required String supplierKey}) =>
      'https://$supplierKey.inventual.app/storage/$supplierKey/';

  static Future<String?> _getSupplierKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("supplier_key");
  }

  static Future<String> getBaseUrl() async {
    final String? supplierKey = await _getSupplierKey();
    if (supplierKey == null || supplierKey.isEmpty) {
      return baseUrl;
    }
    return dynamicBaseUrl(supplierKey: supplierKey);
  }

  static Future<String> getWebViewUrl() async {
    final String? supplierKey = await _getSupplierKey();
    if (supplierKey == null || supplierKey.isEmpty) {
      return webViewUrl;
    }
    return dynamicWebViewUrl(supplierKey: supplierKey);
  }

  static Future<String> getBaseImageUrl() async {
    final String? supplierKey = await _getSupplierKey();
    if (supplierKey == null || supplierKey.isEmpty) {
      return baseImageUrl;
    }
    return dynamicBaseImageUrl(supplierKey: supplierKey);
  }

  static Future<String> getImageUrl(String imagePath) async {
    final String baseImageUrl = await getBaseImageUrl();
    return "$baseImageUrl$imagePath";
  }

  static Future<String> postSignUpEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/users/register';
  }

  static Future<String> postSignInEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/users/login';
  }

  static Future<String> getDistrictEndpoint({required String countryID}) async {
    final String url = await getBaseUrl();
    return '$url/district/list?country_id=$countryID';
  }

  static Future<String> getAreaEndpoint({required String districtID}) async {
    final String url = await getBaseUrl();
    return '$url/area/list?district_id=$districtID';
  }

  static Future<String> getSupplierEndpoint({required String areaID}) async {
    final String url = await getBaseUrl();
    return '$url/suppliers/stores?area_id=$areaID';
  }

  static Future<String> getPackageEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/subscriptions/packages';
  }

  static Future<String> getCouponCodeEndpoint(
      {required String couponCode}) async {
    final String url = await getBaseUrl();
    return '$url/subscriptions/coupon-code/check?code=$couponCode';
  }

  static Future<String> postSellerSaveEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/sellers/save';
  }

  static Future<String> getCategoriesEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/category/list';
  }

  static Future<String> getProductsEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/products/list';
  }

  static Future<String> getCategoryIdByProductsEndpoint(
      {required String categoryId}) async {
    final String url = await getBaseUrl();
    return '$url/products/list?categoryId=$categoryId';
  }

  static Future<String> getBrandIdByProductsEndpoint(
      {required String brandId}) async {
    final String url = await getBaseUrl();
    return '$url/products/list?brandId=$brandId';
  }

  static Future<String> getBrandsEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/brands/list';
  }

  static Future<String> getFreshProductsEndpoint(
      {required String sectionType}) async {
    final String url = await getBaseUrl();
    return '$url/products/list?sectionType=$sectionType';
  }

  static Future<String> getSpecialOffersProductsEndpoint(
      {required String sectionType}) async {
    final String url = await getBaseUrl();
    return '$url/products/list?sectionType=$sectionType';
  }

  static Future<String> getNewArrivalsProductsEndpoint(
      {required String sectionType}) async {
    final String url = await getBaseUrl();
    return '$url/products/list?sectionType=$sectionType';
  }

  static Future<String> getBestSellersProductsEndpoint(
      {required String sectionType}) async {
    final String url = await getBaseUrl();
    return '$url/products/list?sectionType=$sectionType';
  }

  static Future<String> getTrendingProductsEndpoint(
      {required String sectionType}) async {
    final String url = await getBaseUrl();
    return '$url/products/list?sectionType=$sectionType';
  }

  static Future<String> getFeaturedProductsEndpoint(
      {required String sectionType}) async {
    final String url = await getBaseUrl();
    return '$url/products/list?sectionType=$sectionType';
  }

  static Future<String> getExclusiveAppOnlyProductsEndpoint(
      {required String sectionType}) async {
    final String url = await getBaseUrl();
    return '$url/products/list?sectionType=$sectionType';
  }

  static Future<String> getNewOrderEndpoint(
      {required String statusType}) async {
    final String url = await getBaseUrl();
    return '$url/sales/orders/products?status=$statusType';
  }

  static Future<String> getMyOrderEndpoint({required String userID}) async {
    final String url = await getBaseUrl();
    return '$url/sales/my-orders/products?userId=$userID';
  }

  static Future<String> postAcceptOrderEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/suppliers/accept/new-order';
  }

  static Future<String> postOrderStatusUpdateEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/suppliers/order-product/status/update';
  }

  static Future<String> getOverviewEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/products/overview';
  }

  static Future<String> getProduceReviewsEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/products/reviews';
  }

  static Future<String> getAllBanksEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/suppliers/banks';
  }

  static Future<String> postBankAccountCreateEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/suppliers/bank-account/save';
  }

  static Future<String> postBankAccountEditEndpoint(
      {required String bankId}) async {
    final String url = await getBaseUrl();
    return '$url/suppliers/bank-account/update/$bankId';
  }

  static Future<String> getBankAccountsEndpoint(
      {required String supplierId}) async {
    final String url = await getBaseUrl();
    return '$url/suppliers/bank-accounts?supplierId=$supplierId';
  }

  static Future<String> getWebViewEndpoint({required String userId}) async {
    final String url = await getWebViewUrl();
    return '$url?applogin=true&uid=$userId';
  }

  static Future<String> getOrderReturnsEndpoint(
      {required String supplierId}) async {
    final String url = await getBaseUrl();
    return '$url/suppliers/refund-products?supplierId=$supplierId';
  }

  static Future<String> deleteBankAccountEndpoint(
      {required String bankId}) async {
    final String url = await getBaseUrl();
    return '$url/suppliers/bank-account/delete/$bankId';
  }

  static Future<String> getVendorProductsEndpoint(
      {required String supplierId}) async {
    final String url = await getBaseUrl();
    return '$url/suppliers/products?supplierId=$supplierId';
  }

  static Future<String> getAdminProductsEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/products/list';
  }

  static Future<String> getCourierEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/settings/couriers';
  }

  static Future<String> getComboOfferEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/combo-products/list';
  }

  static Future<String> postUpdateProfileEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/users/profile/update';
  }

  static Future<String> getTransactionEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/transactions/list';
  }

  static Future<String> getCouponEndpoint({required String couponCode}) async {
    final String url = await getBaseUrl();
    return '$url/coupon/apply?code=$couponCode';
  }

  static Future<String> getDeliveryAreaEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/settings/delivery-area/list';
  }

  static Future<String> getWarehousesEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/warehouses/list';
  }

  static Future<String> postExpenseEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/expenses/save';
  }

  static Future<String> getExpensesEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/expenses/list';
  }

  static Future<String> deleteExpensesEndpoint(
      {required String expenseId}) async {
    final String url = await getBaseUrl();
    return '$url/expenses/delete/$expenseId';
  }

  static Future<String> getCustomerEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/customers/list';
  }

  static Future<String> getBillersEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/billers/list';
  }

  static Future<String> getCountriesEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/country/list';
  }

  static Future<String> postCheckoutEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/checkout/save';
  }

  static Future<String> postMakePaymentEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/payments/save';
  }

  static Future<String> getUsersEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/users/list';
  }

  static Future<String> getRolesEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/roles/list';
  }

  static Future<String> postUserRegisterEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/users/register';
  }

  static Future<String> deleteUserEndpoint({required String userId}) async {
    final String url = await getBaseUrl();
    return '$url/users/delete/$userId';
  }

  static Future<String> postUserEditEndpoint({required String userId}) async {
    final String url = await getBaseUrl();
    return '$url/users/update/$userId';
  }

  static Future<String> postRoleCreateEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/roles/save';
  }

  static Future<String> deleteRoleEndpoint({required String roleId}) async {
    final String url = await getBaseUrl();
    return '$url/roles/delete/$roleId';
  }

  static Future<String> postRoleEditEndpoint({required String roleId}) async {
    final String url = await getBaseUrl();
    return '$url/roles/update/$roleId';
  }

  static Future<String> getCustomersEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/customers/list';
  }

  static Future<String> deleteCustomerEndpoint(
      {required String customerId}) async {
    final String url = await getBaseUrl();
    return '$url/customers/delete/$customerId';
  }

  static Future<String> getCouponsEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/coupon/list';
  }
}

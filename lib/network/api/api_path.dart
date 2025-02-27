import 'package:shared_preferences/shared_preferences.dart';

class ApiPath {
  static const String baseUrl = 'https://inventual.app/api/v1';
  static const String webViewUrl = 'https://inventual.app/login';
  static const String baseImageUrl = 'https://inventual.app/storage/';

  static String dynamicBaseUrl({required String domainName}) =>
      'https://$domainName/api/v1';

  static String dynamicWebViewUrl({required String domainName}) =>
      'https://$domainName/login';

  static String dynamicBaseImageUrl(
          {required String domainName, required String domainKey}) =>
      'https://$domainName/storage/$domainKey/';

  static Future<String?> _getDomainKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("domain_key");
  }

  static Future<String?> _getDomainName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("domain_name");
  }

  static Future<String> getBaseUrl() async {
    final String? domainName = await _getDomainName();
    if (domainName == null || domainName.isEmpty) {
      return baseUrl;
    }
    return dynamicBaseUrl(domainName: domainName);
  }

  static Future<String> getWebViewUrl() async {
    final String? domainName = await _getDomainName();
    if (domainName == null || domainName.isEmpty) {
      return webViewUrl;
    }
    return dynamicWebViewUrl(domainName: domainName);
  }

  static Future<String> getBaseImageUrl() async {
    final String? domainName = await _getDomainName();
    final String? domainKey = await _getDomainKey();
    if (domainName == null || domainName.isEmpty) {
      return baseImageUrl;
    }
    if (domainKey == null || domainKey.isEmpty) {
      return baseImageUrl;
    }
    return dynamicBaseImageUrl(domainName: domainName, domainKey: domainKey);
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

  static Future<String> getSupplierEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/suppliers/stores';
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

  static Future<String> getMyOrderEndpoint(
      {required String userID, required String role}) async {
    final String url = await getBaseUrl();
    return '$url/sales/my-orders/products?userId=$userID&role=$role';
  }

  static Future<String> getVendorOrderEndpoint(
      {required String userID, required String role}) async {
    final String url = await getBaseUrl();
    return '$url/sales/my-orders/products?userId=$userID&role=$role';
  }

  static Future<String> getCustomerOrderEndpoint(
      {required String userID, required String role}) async {
    final String url = await getBaseUrl();
    return '$url/sales/my-orders/products?userId=$userID&role=$role';
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

  static Future<String> getProduceReviewsEndpoint(
      {required String userId}) async {
    final String url = await getBaseUrl();
    return '$url/products/reviews/user/$userId';
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

  static Future<String> getVendorOrderReturnsEndpoint(
      {required String supplierId}) async {
    final String url = await getBaseUrl();
    return '$url/suppliers/refund-products?supplierId=$supplierId';
  }

  static Future<String> getCustomerOrderReturnsEndpoint(
      {required String customerId}) async {
    final String url = await getBaseUrl();
    return '$url/suppliers/refund-products?customerId=$customerId';
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

  static Future<String> getCategoriesByTypeEndpoint(
      {required String categoryType}) async {
    final String url = await getBaseUrl();
    return '$url/category/list?type=$categoryType';
  }

  static Future<String> postCustomerCreateEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/customers/save';
  }

  static Future<String> postCustomerEditEndpoint(
      {required String customerId}) async {
    final String url = await getBaseUrl();
    return '$url/customers/update/$customerId';
  }

  static Future<String> getSuppliersEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/suppliers/list';
  }

  static Future<String> deleteSupplierEndpoint(
      {required String supplierId}) async {
    final String url = await getBaseUrl();
    return '$url/suppliers/delete/$supplierId';
  }

  static Future<String> getCompaniesEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/company/list';
  }

  static Future<String> postSupplierCreateEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/suppliers/save';
  }

  static Future<String> postSupplierUpdateEndpoint(
      {required String supplierId}) async {
    final String url = await getBaseUrl();
    return '$url/suppliers/update/$supplierId';
  }

  static Future<String> deleteBillerEndpoint({required String billerId}) async {
    final String url = await getBaseUrl();
    return '$url/billers/delete/$billerId';
  }

  static Future<String> postBillerCreateEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/billers/save';
  }

  static Future<String> postBillerUpdateEndpoint(
      {required String billerId}) async {
    final String url = await getBaseUrl();
    return '$url/billers/update/$billerId';
  }

  static Future<String> postWarehouseEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/warehouses/save';
  }

  static Future<String> deleteWarehouseEndpoint(
      {required String warehouseId}) async {
    final String url = await getBaseUrl();
    return '$url/warehouses/delete/$warehouseId';
  }

  static Future<String> postUpdateWarehouseEndpoint(
      {required String warehouseId}) async {
    final String url = await getBaseUrl();
    return '$url/warehouses/update/$warehouseId';
  }

  static Future<String> postCreateCategoryEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/category/save';
  }

  static Future<String> getSalesReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/sale';
  }

  static Future<String> getPurchaseReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/purchase';
  }

  static Future<String> getPaymentReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/payment';
  }

  static Future<String> getProductReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/product';
  }

  static Future<String> getStockReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/stock/list';
  }

  static Future<String> getExpenseReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/expense';
  }

  static Future<String> getUserReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/user';
  }

  static Future<String> getCustomerReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/customer';
  }

  static Future<String> getWarehouseReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/warehouse';
  }

  static Future<String> getSupplierReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/supplier';
  }

  static Future<String> getDiscountReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/discount';
  }

  static Future<String> getTaxReportEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/report/tax';
  }

  static Future<String> getSalesReturnEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/sales/return/list';
  }

  static Future<String> deleteSalesReturnEndpoint(
      {required String saleId}) async {
    final String url = await getBaseUrl();
    return '$url/sales/return/delete/$saleId';
  }

  static Future<String> getPurchaseEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/purchases/list';
  }

  static Future<String> getPurchaseReturnEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/purchases/return/list';
  }

  static Future<String> deletePurchaseReturnEndpoint(
      {required String purchaseId}) async {
    final String url = await getBaseUrl();
    return '$url/purchases/return/delete/$purchaseId';
  }

  static Future<String> postSaleCreateEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/sales/save';
  }

  static Future<String> postPurchaseCreateEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/purchases/save';
  }

  static Future<String> postReturnSaleCreateEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/sales/return/save';
  }

  static Future<String> postReturnPurchaseCreateEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/purchases/return/save';
  }

  static Future<String> getUnitsEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/units/list';
  }

  static Future<String> postCreateUnitEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/units/save';
  }

  static Future<String> deleteUnitEndpoint({required String unitId}) async {
    final String url = await getBaseUrl();
    return '$url/units/delete/$unitId';
  }

  static Future<String> postUpdateUnitEndpoint({required String unitId}) async {
    final String url = await getBaseUrl();
    return '$url/units/update/$unitId';
  }

  static Future<String> postCreateBrandEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/brands/save';
  }

  static Future<String> deleteBrandEndpoint({required String brandId}) async {
    final String url = await getBaseUrl();
    return '$url/brands/delete/$brandId';
  }

  static Future<String> postBrandUpdateEndpoint(
      {required String brandId}) async {
    final String url = await getBaseUrl();
    return '$url/brands/update/$brandId';
  }

  static Future<String> deleteCategoryEndpoint(
      {required String categoryId}) async {
    final String url = await getBaseUrl();
    return '$url/category/delete/$categoryId';
  }

  static Future<String> postUpdateCategoryEndpoint(
      {required String categoryId}) async {
    final String url = await getBaseUrl();
    return '$url/category/update/$categoryId';
  }

  static Future<String> postCreateProductEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/products/save';
  }

  static Future<String> getColorVariantsEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/variants/list?type=Color';
  }

  static Future<String> getSizeVariantsEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/variants/list?type=Size';
  }

  static Future<String> getProductTypesEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/types/list';
  }

  static Future<String> getTaxesEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/taxes/list';
  }

  static Future<String> getSettingsEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/settings/all';
  }

  static Future<String> postProductReviewEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/products/reviews/save';
  }

  static Future<String> postProductRefundEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/sales/my-orders/request-refund';
  }

  static Future<String> getAboutUsContentEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/pages/About Us';
  }

  static Future<String> postContactEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/pages/contact';
  }

  static Future<String> getRefundPolicyEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/pages/Refund Policy';
  }

  static Future<String> getPrivacyPolicyEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/pages/Privacy Policy';
  }

  static Future<String> getTermsAndConditionEndpoint() async {
    final String url = await getBaseUrl();
    return '$url/pages/Terms and Condition';
  }
}

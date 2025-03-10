import 'package:get/get.dart';
import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/config/routes/routes_config.dart';

List<GetPage> routesHandler = [
  GetPage(name: BaseRoute.pageNotFound, page: () => RoutesConfig.pageNotFound),
  GetPage(name: BaseRoute.splash, page: () => RoutesConfig.splash),
  GetPage(name: BaseRoute.onBoarding, page: () => RoutesConfig.onBoarding),
  GetPage(name: BaseRoute.signIn, page: () => RoutesConfig.signIn),
  GetPage(name: BaseRoute.signUp, page: () => RoutesConfig.signUp),
  GetPage(name: BaseRoute.forgotPass, page: () => RoutesConfig.forgotPass),
  GetPage(
      name: BaseRoute.changePassword, page: () => RoutesConfig.changePassword),
  GetPage(name: BaseRoute.category, page: () => RoutesConfig.category),
  GetPage(name: BaseRoute.brand, page: () => RoutesConfig.brand),
  GetPage(name: BaseRoute.comboOffer, page: () => RoutesConfig.comboOffer),
  GetPage(name: BaseRoute.about, page: () => RoutesConfig.about),
  GetPage(name: BaseRoute.contact, page: () => RoutesConfig.contact),
  GetPage(name: BaseRoute.cart, page: () => RoutesConfig.cart),
  GetPage(name: BaseRoute.myWishlist, page: () => RoutesConfig.wishlist),
  GetPage(
      name: BaseRoute.termsCondition, page: () => RoutesConfig.termsCondition),
  GetPage(name: BaseRoute.refundPolicy, page: () => RoutesConfig.refundPolicy),
  GetPage(name: BaseRoute.home, page: () => RoutesConfig.home),
  GetPage(name: BaseRoute.products, page: () => RoutesConfig.products),
  GetPage(
      name: BaseRoute.termsCondition, page: () => RoutesConfig.termsCondition),
  GetPage(name: BaseRoute.profile, page: () => RoutesConfig.profile),
  GetPage(name: BaseRoute.orderHistory, page: () => RoutesConfig.orderHistory),
  GetPage(name: BaseRoute.reviews, page: () => RoutesConfig.reviews),
  GetPage(name: BaseRoute.myCoupon, page: () => RoutesConfig.myCoupon),
  GetPage(name: BaseRoute.trackOrder, page: () => RoutesConfig.trackOrder),
  GetPage(name: BaseRoute.transactions, page: () => RoutesConfig.transactions),
  GetPage(name: BaseRoute.findDomain, page: () => RoutesConfig.findDomain),
  GetPage(
      name: BaseRoute.becomeASeller, page: () => RoutesConfig.becomeASeller),
  GetPage(name: BaseRoute.newOrder, page: () => RoutesConfig.newOrder),
  GetPage(name: BaseRoute.orders, page: () => RoutesConfig.orders),
  GetPage(name: BaseRoute.overView, page: () => RoutesConfig.overView),
  GetPage(name: BaseRoute.userReviews, page: () => RoutesConfig.userReviews),
  GetPage(name: BaseRoute.orderReturn, page: () => RoutesConfig.orderReturn),
  GetPage(name: BaseRoute.bankAccount, page: () => RoutesConfig.bankAccount),
  GetPage(
      name: BaseRoute.addNewBankAccount,
      page: () => RoutesConfig.addNewBankAccount),
  GetPage(
      name: BaseRoute.adminAndVendorProducts,
      page: () => RoutesConfig.adminAndVendorProducts),
  GetPage(name: BaseRoute.expense, page: () => RoutesConfig.expense),
  GetPage(name: BaseRoute.pos, page: () => RoutesConfig.pos),
  GetPage(
      name: BaseRoute.userManagement, page: () => RoutesConfig.userManagement),
  GetPage(name: BaseRoute.customer, page: () => RoutesConfig.customer),
  GetPage(name: BaseRoute.supplier, page: () => RoutesConfig.supplier),
  GetPage(name: BaseRoute.billers, page: () => RoutesConfig.billers),
  GetPage(name: BaseRoute.warehouse, page: () => RoutesConfig.warehouse),
  GetPage(name: BaseRoute.reports, page: () => RoutesConfig.reports),
  GetPage(name: BaseRoute.sale, page: () => RoutesConfig.sale),
  GetPage(
      name: BaseRoute.unitManagement, page: () => RoutesConfig.unitManagement),
  GetPage(
      name: BaseRoute.brandManagement,
      page: () => RoutesConfig.brandManagement),
  GetPage(
      name: BaseRoute.categoryManagement,
      page: () => RoutesConfig.categoryManagement),
  GetPage(name: BaseRoute.addProduct, page: () => RoutesConfig.addProduct),
  GetPage(
      name: BaseRoute.customerOrders, page: () => RoutesConfig.customerOrders),
];

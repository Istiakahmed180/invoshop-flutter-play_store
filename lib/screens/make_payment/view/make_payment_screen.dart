import 'package:ai_store/common/controller/checkout_controller.dart';
import 'package:ai_store/common/controller/wish_cart_list_controller.dart';
import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/custom_common_title.dart';
import 'package:ai_store/common/widgets/custom_elevated_button.dart';
import 'package:ai_store/common/widgets/custom_label_text.dart';
import 'package:ai_store/common/widgets/dropdown/custom_dropdown_field.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/screens/home/model/products_model.dart' as model;
import 'package:ai_store/screens/make_payment/controller/make_payment_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MakePaymentScreen extends StatefulWidget {
  final List<model.ProductsData> products;
  final double totalAmount;

  const MakePaymentScreen(
      {super.key, required this.products, required this.totalAmount});

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  final MakePaymentController makePaymentController =
      Get.put(MakePaymentController());
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final WishListAndCartListController wishListAndCartListController =
      Get.put(WishListAndCartListController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarName: "Make Payment"),
      body: Obx(
        () => makePaymentController.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: makePaymentController.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildBillingSection(),
                              _buildShippingSection(),
                              _buildConfirmSection(),
                            ],
                          ),
                        ),
                        _buildBottomButtons(),
                      ],
                    ),
                  ),
                  Obx(
                    () => Visibility(
                        visible: makePaymentController.isCheckoutLoading.value,
                        child: const CustomLoading()),
                  )
                ],
              ),
      ),
    );
  }

  Widget _buildBillingSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.h,
          ),
          _buildSectionTitle("Billing Details"),
          _buildTextField(
            label: "First Name",
            controller: makePaymentController.billerFirstName,
            hintText: "First Name",
            keyboardType: TextInputType.name,
          ),
          _buildTextField(
            label: "Last Name",
            controller: makePaymentController.billerLastName,
            hintText: "Last Name",
            keyboardType: TextInputType.name,
          ),
          _buildTextField(
            label: "Email",
            controller: makePaymentController.billerEmail,
            hintText: "customer@gmail.com",
            keyboardType: TextInputType.emailAddress,
          ),
          _buildTextField(
            label: "Phone",
            controller: makePaymentController.billerPhone,
            hintText: "Phone",
            keyboardType: TextInputType.phone,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomLabelText(
                  text: "Country",
                  isRequired: true,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Obx(() => CustomDropdownField(
                      dropdownItems: makePaymentController.countriesList.isEmpty
                          ? ["Not Found"]
                          : makePaymentController.countriesList
                              .map((item) => item.title as String)
                              .toList(),
                      validatorText: "Country",
                      hintText: "Select Country",
                      onChanged: (String? value) {
                        makePaymentController.billerCountryId.value =
                            makePaymentController.countriesList
                                    .firstWhere((item) => item.title == value)
                                    .id ??
                                0;
                      },
                    )),
              ],
            ),
          ),
          _buildTextField(
            label: "City",
            controller: makePaymentController.billerCity,
            hintText: "Town / City",
            keyboardType: TextInputType.text,
          ),
          _buildTextField(
            label: "Zip Code",
            controller: makePaymentController.billerZipCode,
            hintText: "Postcode / Zip",
            keyboardType: TextInputType.text,
          ),
          _buildTextField(
            label: "Address",
            controller: makePaymentController.billerAddress,
            hintText: "Street Address",
            keyboardType: TextInputType.streetAddress,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildShippingSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          _buildCheckboxSection(),
          _buildSectionTitle("Shipping Details"),
          _buildTextField(
            label: "First Name",
            controller: makePaymentController.shippingFirstName,
            hintText: "First Name",
            keyboardType: TextInputType.name,
          ),
          _buildTextField(
            label: "Last Name",
            controller: makePaymentController.shippingLastName,
            hintText: "Last Name",
            keyboardType: TextInputType.name,
          ),
          _buildTextField(
            label: "Email",
            controller: makePaymentController.shippingEmail,
            hintText: "Phone",
            keyboardType: TextInputType.emailAddress,
          ),
          _buildTextField(
            label: "Phone",
            controller: makePaymentController.shippingPhone,
            hintText: "Phone",
            keyboardType: TextInputType.phone,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomLabelText(
                  text: "Country",
                  isRequired: true,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Obx(() => CustomDropdownField(
                      dropdownItems: makePaymentController.countriesList.isEmpty
                          ? ["Not Found"]
                          : makePaymentController.countriesList
                              .map((item) => item.title as String)
                              .toList(),
                      validatorText: "Country",
                      hintText: "Select Country",
                      onChanged: (String? value) {
                        makePaymentController.shippingCountryId.value =
                            makePaymentController.countriesList
                                    .firstWhere((item) => item.title == value)
                                    .id ??
                                0;
                      },
                    )),
              ],
            ),
          ),
          _buildTextField(
            label: "City",
            controller: makePaymentController.shippingCity,
            hintText: "Town / City",
            keyboardType: TextInputType.text,
          ),
          _buildTextField(
            label: "Zip Code",
            controller: makePaymentController.shippingZipCode,
            hintText: "Postcode / Zip",
            keyboardType: TextInputType.text,
          ),
          _buildTextField(
            label: "Address",
            controller: makePaymentController.shippingAddress,
            hintText: "Street Address",
            keyboardType: TextInputType.streetAddress,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxSection() {
    return Obx(
      () => Row(
        children: [
          GestureDetector(
            onTap: () {
              makePaymentController.isSameAsBillingAddress.value =
                  !makePaymentController.isSameAsBillingAddress.value;
              makePaymentController.sameAsBillingAddress();
            },
            child: Row(
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  side: const BorderSide(
                    color: AppColors.groceryPrimary,
                    width: 1.5,
                  ),
                  activeColor: AppColors.groceryPrimary,
                  value: makePaymentController.isSameAsBillingAddress.value,
                  onChanged: (bool? value) {
                    if (value != null) {
                      makePaymentController.isSameAsBillingAddress.value =
                          value;
                      makePaymentController.sameAsBillingAddress();
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    makePaymentController.isSameAsBillingAddress.value =
                        !makePaymentController.isSameAsBillingAddress.value;
                    makePaymentController.sameAsBillingAddress();
                  },
                  child: Text(
                    "Same As Billing Address",
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, bottom: 10.h, right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelText(text: label, isRequired: true),
          SizedBox(height: 5.h),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) =>
                (value == null || value.isEmpty) ? "Required field" : null,
            keyboardType: keyboardType,
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(hintText: hintText),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (makePaymentController.currentPage.value > 0)
              CustomElevatedButton(
                buttonName: "Back",
                onPressed: makePaymentController.previousPage,
              ),
            const Spacer(),
            if (makePaymentController.currentPage.value == 0 ||
                makePaymentController.currentPage.value == 1)
              CustomElevatedButton(
                buttonName: "Next",
                onPressed: makePaymentController.currentPage.value == 0
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          makePaymentController.nextPage();
                        }
                      }
                    : () {
                        if (_formKey.currentState!.validate()) {
                          makePaymentController.sameAsBillingAddress();
                          makePaymentController.nextPageTwo();
                        }
                      },
              ),
            if (makePaymentController.currentPage.value == 2)
              CustomElevatedButton(
                buttonName: "Confirm",
                onPressed: () {
                  makePaymentController.checkoutSave(
                      products: widget.products,
                      taxAmount:
                          wishListAndCartListController.productTax.toString(),
                      discount:
                          wishListAndCartListController.discount.toString(),
                      amount: wishListAndCartListController.subtotal.toString(),
                      totalAmount:
                          wishListAndCartListController.total.toString());
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, bottom: 10.h),
      child: Text(
        title,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildConfirmSection() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              final product = widget.products[index];
              final bool isLastItem = index == widget.products.length - 1;
              return _buildCartItem(product: product, isLastItem: isLastItem);
            },
          ),
          Padding(
            padding: REdgeInsets.all(12),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shipping Address",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(() => _buildInfoRow(
                          "Name",
                          "${makePaymentController.shippingFirstNameValue} ${makePaymentController.shippingLastNameValue}"
                              .trim(),
                        )),
                    Obx(() => _buildInfoRow("Email",
                        makePaymentController.shippingEmailValue.value)),
                    Obx(() => _buildInfoRow("Phone",
                        makePaymentController.shippingPhoneValue.value)),
                    Obx(() => _buildInfoRow("Address",
                        makePaymentController.shippingAddressValue.value)),
                    Obx(() => _buildInfoRow(
                        "City", makePaymentController.shippingCityValue.value)),
                    Obx(() => _buildInfoRow("Zip",
                        makePaymentController.shippingZipCodeValue.value)),
                    const Divider(color: AppColors.groceryPrimary),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payable Amount",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${widget.totalAmount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.groceryPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label\t\t:",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(
      {required model.ProductsData product, required bool isLastItem}) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              FutureBuilder<String>(
                future: _getValidImageUrl(product),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 62.h,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: const BoxDecoration(
                        color: AppColors.groceryBodyTwo,
                      ),
                      child: Image.asset("assets/gif/loading.gif"),
                    );
                  }

                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return Container(
                      height: 62.h,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: AppColors.groceryRatingGray.withAlpha(25),
                      ),
                      child: const Icon(
                        Icons.broken_image,
                        color: AppColors.groceryRatingGray,
                      ),
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: AppColors.groceryBodyTwo,
                    ),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width * 0.2,
                      imageUrl: snapshot.data!,
                      placeholder: (context, url) =>
                          Image.asset("assets/gif/loading.gif"),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image),
                    ),
                  );
                },
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitleText(title: product.title!),
                    const SizedBox(height: 4.0),
                    Text(
                      (product.quantity ?? 1) > 1
                          ? '${product.quantity} pieces'
                          : '${product.quantity ?? 1} piece',
                      style: TextStyle(
                          fontSize: 12.sp, color: AppColors.groceryTextTwo),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '\$${(double.parse(product.price.toString()) * double.parse(product.quantity.toString())).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.groceryPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isLastItem)
            const Divider(color: AppColors.groceryBorder, thickness: 1),
        ],
      ),
    );
  }

  Future<String> _getValidImageUrl(model.ProductsData product) async {
    if (product.image?.path == null || product.image!.path!.isEmpty) {
      return '';
    }
    try {
      final url = await ApiPath.getImageUrl(product.image!.path!);
      if (url.isEmpty || !Uri.parse(url).hasAuthority) {
        return '';
      }
      return url;
    } catch (e) {
      return '';
    }
  }
}

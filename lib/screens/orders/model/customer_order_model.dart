class CustomerOrderModel {
  bool? success;
  List<CustomerOrderData>? data;
  Customer? customer;

  CustomerOrderModel({this.success, this.data, this.customer});

  CustomerOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CustomerOrderData>[];
      json['data'].forEach((v) {
        data!.add(CustomerOrderData.fromJson(v));
      });
    }
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }
}

class CustomerOrderData {
  int? id;
  int? userId;
  int? customerId;
  int? warehouseId;
  int? billerId;
  String? referenceNo;
  String? amount;
  String? taxAmount;
  String? discount;
  String? shippingAmount;
  String? totalAmount;
  String? saleDateAt;
  String? saleTimeAt;
  String? paymentStatus;
  String? saleStatus;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? supplierId;
  String? shippingMethod;
  String? trackingId;
  int? isAssignedCourier;
  String? deliveryType;
  String? deliveryAreaId;
  String? deliveryAreaName;
  int? couponId;
  Customer? customer;
  String? payment;
  List<OrderProducts>? orderProducts;

  CustomerOrderData(
      {this.id,
      this.userId,
      this.customerId,
      this.warehouseId,
      this.billerId,
      this.referenceNo,
      this.amount,
      this.taxAmount,
      this.discount,
      this.shippingAmount,
      this.totalAmount,
      this.saleDateAt,
      this.saleTimeAt,
      this.paymentStatus,
      this.saleStatus,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.supplierId,
      this.shippingMethod,
      this.trackingId,
      this.isAssignedCourier,
      this.deliveryType,
      this.deliveryAreaId,
      this.deliveryAreaName,
      this.couponId,
      this.customer,
      this.payment,
      this.orderProducts});

  CustomerOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    warehouseId = json['warehouse_id'];
    billerId = json['biller_id'];
    referenceNo = json['reference_no'];
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    discount = json['discount'];
    shippingAmount = json['shipping_amount'];
    totalAmount = json['total_amount'];
    saleDateAt = json['sale_date_at'];
    saleTimeAt = json['sale_time_at'];
    paymentStatus = json['payment_status'];
    saleStatus = json['sale_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    supplierId = json['supplier_id'];
    shippingMethod = json['shipping_method'];
    trackingId = json['tracking_id'];
    isAssignedCourier = json['is_assigned_courier'];
    deliveryType = json['delivery_type'];
    deliveryAreaId = json['delivery_area_id'];
    deliveryAreaName = json['delivery_area_name'];
    couponId = json['coupon_id'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    payment = json['payment'];
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProducts.fromJson(v));
      });
    }
  }
}

class Customer {
  int? id;
  int? userId;
  int? countryId;
  int? categoryId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? city;
  String? zipCode;
  String? address;
  String? rewardPoint;
  String? status;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.userId,
      this.countryId,
      this.categoryId,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.city,
      this.zipCode,
      this.address,
      this.rewardPoint,
      this.status,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    countryId = json['country_id'];
    categoryId = json['category_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    city = json['city'];
    zipCode = json['zip_code'];
    address = json['address'];
    rewardPoint = json['reward_point'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class OrderProducts {
  int? id;
  int? orderId;
  int? productId;
  String? amount;
  String? taxAmount;
  String? discount;
  String? saleAmount;
  int? quantity;
  String? saleStatus;
  int? isAccepted;
  int? isRefundRequested;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? productVariantId;
  Product? product;

  OrderProducts(
      {this.id,
      this.orderId,
      this.productId,
      this.amount,
      this.taxAmount,
      this.discount,
      this.saleAmount,
      this.quantity,
      this.saleStatus,
      this.isAccepted,
      this.isRefundRequested,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.productVariantId,
      this.product});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    discount = json['discount'];
    saleAmount = json['sale_amount'];
    quantity = json['quantity'];
    saleStatus = json['sale_status'];
    isAccepted = json['is_accepted'];
    isRefundRequested = json['is_refund_requested'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productVariantId = json['product_variant_id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  int? supplierId;
  int? brandId;
  int? typeId;
  int? unitId;
  int? taxId;
  String? taxType;
  String? taxMethod;
  String? discountType;
  String? productCode;
  String? title;
  String? slug;
  int? availableStock;
  String? price;
  String? salePrice;
  String? tax;
  String? discount;
  int? quantity;
  String? introText;
  String? description;
  int? hasVariant;
  int? isFeatured;
  int? isExpired;
  int? isPromoSale;
  String? promoPrice;
  String? promoStartAt;
  String? promoEndAt;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? isGstApplicable;
  String? gstValue;
  String? weight;
  Image? image;

  Product(
      {this.id,
      this.supplierId,
      this.brandId,
      this.typeId,
      this.unitId,
      this.taxId,
      this.taxType,
      this.taxMethod,
      this.discountType,
      this.productCode,
      this.title,
      this.slug,
      this.availableStock,
      this.price,
      this.salePrice,
      this.tax,
      this.discount,
      this.quantity,
      this.introText,
      this.description,
      this.hasVariant,
      this.isFeatured,
      this.isExpired,
      this.isPromoSale,
      this.promoPrice,
      this.promoStartAt,
      this.promoEndAt,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isGstApplicable,
      this.gstValue,
      this.weight,
      this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierId = json['supplier_id'];
    brandId = json['brand_id'];
    typeId = json['type_id'];
    unitId = json['unit_id'];
    taxId = json['tax_id'];
    taxType = json['tax_type'];
    taxMethod = json['tax_method'];
    discountType = json['discount_type'];
    productCode = json['product_code'];
    title = json['title'];
    slug = json['slug'];
    availableStock = json['available_stock'];
    price = json['price'];
    salePrice = json['sale_price'];
    tax = json['tax'];
    discount = json['discount'];
    quantity = json['quantity'];
    introText = json['intro_text'];
    description = json['description'];
    hasVariant = json['has_variant'];
    isFeatured = json['is_featured'];
    isExpired = json['is_expired'];
    isPromoSale = json['is_promo_sale'];
    promoPrice = json['promo_price'];
    promoStartAt = json['promo_start_at'];
    promoEndAt = json['promo_end_at'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isGstApplicable = json['is_gst_applicable'];
    gstValue = json['gst_value'];
    weight = json['weight'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }
}

class Image {
  int? id;
  String? imageableType;
  int? imageableId;
  String? name;
  String? path;
  String? status;
  String? createdAt;
  String? updatedAt;

  Image(
      {this.id,
      this.imageableType,
      this.imageableId,
      this.name,
      this.path,
      this.status,
      this.createdAt,
      this.updatedAt});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageableType = json['imageable_type'];
    imageableId = json['imageable_id'];
    name = json['name'];
    path = json['path'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

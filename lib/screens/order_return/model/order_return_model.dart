class OrderReturnModel {
  bool? success;
  List<OrderReturnData>? data;

  OrderReturnModel({this.success, this.data});

  OrderReturnModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <OrderReturnData>[];
      json['data'].forEach((v) {
        data!.add(OrderReturnData.fromJson(v));
      });
    }
  }
}

class OrderReturnData {
  int? id;
  int? refundId;
  int? productId;
  int? orderProductId;
  int? orderId;
  String? amount;
  String? taxAmount;
  String? discount;
  String? refundAmount;
  String? status;
  String? createdAt;
  String? updatedAt;
  Product? product;
  Refund? refund;
  OrderProduct? orderProduct;
  Order? order;

  OrderReturnData(
      {this.id,
      this.refundId,
      this.productId,
      this.orderProductId,
      this.orderId,
      this.amount,
      this.taxAmount,
      this.discount,
      this.refundAmount,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.product,
      this.refund,
      this.orderProduct,
      this.order});

  OrderReturnData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refundId = json['refund_id'];
    productId = json['product_id'];
    orderProductId = json['order_product_id'];
    orderId = json['order_id'];
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    discount = json['discount'];
    refundAmount = json['refund_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    refund = json['refund'] != null ? Refund.fromJson(json['refund']) : null;
    orderProduct = json['order_product'] != null
        ? OrderProduct.fromJson(json['order_product'])
        : null;
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
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
  int? availableStock;
  String? price;
  String? salePrice;
  String? tax;
  String? discount;
  int? quantity;
  String? introText;
  String? description;
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
      this.availableStock,
      this.price,
      this.salePrice,
      this.tax,
      this.discount,
      this.quantity,
      this.introText,
      this.description,
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
    availableStock = json['available_stock'];
    price = json['price'];
    salePrice = json['sale_price'];
    tax = json['tax'];
    discount = json['discount'];
    quantity = json['quantity'];
    introText = json['intro_text'];
    description = json['description'];
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

class Refund {
  int? id;
  int? userId;
  int? customerId;
  int? warehouseId;
  int? billerId;
  String? amount;
  String? taxAmount;
  String? discount;
  String? shippingAmount;
  String? totalAmount;
  String? refundDateAt;
  String? refundTimeAt;
  String? remark;
  String? refundNote;
  String? refundStatus;
  String? status;
  String? createdAt;
  String? updatedAt;

  Refund(
      {this.id,
      this.userId,
      this.customerId,
      this.warehouseId,
      this.billerId,
      this.amount,
      this.taxAmount,
      this.discount,
      this.shippingAmount,
      this.totalAmount,
      this.refundDateAt,
      this.refundTimeAt,
      this.remark,
      this.refundNote,
      this.refundStatus,
      this.status,
      this.createdAt,
      this.updatedAt});

  Refund.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    warehouseId = json['warehouse_id'];
    billerId = json['biller_id'];
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    discount = json['discount'];
    shippingAmount = json['shipping_amount'];
    totalAmount = json['total_amount'];
    refundDateAt = json['refund_date_at'];
    refundTimeAt = json['refund_time_at'];
    remark = json['remark'];
    refundNote = json['refund_note'];
    refundStatus = json['refund_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class OrderProduct {
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
  String? status;
  String? createdAt;
  String? updatedAt;

  OrderProduct(
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
      this.status,
      this.createdAt,
      this.updatedAt});

  OrderProduct.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Order {
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

  Order(
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
      this.supplierId});

  Order.fromJson(Map<String, dynamic> json) {
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
  }
}

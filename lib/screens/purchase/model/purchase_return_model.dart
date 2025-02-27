class PurchaseReturnModel {
  bool? success;
  List<PurchaseReturnData>? data;

  PurchaseReturnModel({this.success, this.data});

  PurchaseReturnModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PurchaseReturnData>[];
      json['data'].forEach((v) {
        data!.add(PurchaseReturnData.fromJson(v));
      });
    }
  }
}

class PurchaseReturnData {
  int? id;
  int? userId;
  int? warehouseId;
  int? supplierId;
  String? returnPurchaseDateAt;
  String? returnPurchaseTimeAt;
  String? amount;
  String? taxAmount;
  String? discountAmount;
  String? shippingAmount;
  String? totalAmount;
  String? remark;
  String? returnNote;
  String? returnStatus;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;
  Supplier? supplier;
  Warehouse? warehouse;

  PurchaseReturnData(
      {this.id,
      this.userId,
      this.warehouseId,
      this.supplierId,
      this.returnPurchaseDateAt,
      this.returnPurchaseTimeAt,
      this.amount,
      this.taxAmount,
      this.discountAmount,
      this.shippingAmount,
      this.totalAmount,
      this.remark,
      this.returnNote,
      this.returnStatus,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.products,
      this.supplier,
      this.warehouse});

  PurchaseReturnData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    warehouseId = json['warehouse_id'];
    supplierId = json['supplier_id'];
    returnPurchaseDateAt = json['return_purchase_date_at'];
    returnPurchaseTimeAt = json['return_purchase_time_at'];
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    discountAmount = json['discount_amount'];
    shippingAmount = json['shipping_amount'];
    totalAmount = json['total_amount'];
    remark = json['remark'];
    returnNote = json['return_note'];
    returnStatus = json['return_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    supplier =
        json['supplier'] != null ? Supplier.fromJson(json['supplier']) : null;
    warehouse = json['warehouse'] != null
        ? Warehouse.fromJson(json['warehouse'])
        : null;
  }
}

class Products {
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
  String? attributes;
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
  int? laravelThroughKey;

  Products(
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
      this.attributes,
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
      this.laravelThroughKey});

  Products.fromJson(Map<String, dynamic> json) {
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
    attributes = json['attributes'];
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
    laravelThroughKey = json['laravel_through_key'];
  }
}

class Supplier {
  int? id;
  String? firstName;

  Supplier({this.id, this.firstName});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
  }
}

class Warehouse {
  int? id;
  String? name;

  Warehouse({this.id, this.name});

  Warehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

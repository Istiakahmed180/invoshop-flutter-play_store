class ComboOfferModel {
  bool? success;
  List<ComboOfferData>? data;

  ComboOfferModel({this.success, this.data});

  ComboOfferModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ComboOfferData>[];
      json['data'].forEach((v) {
        data!.add(ComboOfferData.fromJson(v));
      });
    }
  }
}

class ComboOfferData {
  int? id;
  String? name;
  String? image;
  String? totalPrice;
  String? comboPrice;
  int? isActive;
  String? startDate;
  String? endDate;
  int? displayOrder;
  CreatedBy? createdBy;
  String? createdAt;
  String? updatedAt;
  List<ComboOfferProducts>? comboOfferProducts;

  ComboOfferData(
      {this.id,
      this.name,
      this.image,
      this.totalPrice,
      this.comboPrice,
      this.isActive,
      this.startDate,
      this.endDate,
      this.displayOrder,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.comboOfferProducts});

  ComboOfferData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    totalPrice = json['total_price'];
    comboPrice = json['combo_price'];
    isActive = json['is_active'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    displayOrder = json['display_order'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['combo_offer_products'] != null) {
      comboOfferProducts = <ComboOfferProducts>[];
      json['combo_offer_products'].forEach((v) {
        comboOfferProducts!.add(ComboOfferProducts.fromJson(v));
      });
    }
  }
}

class CreatedBy {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  String? gender;
  String? status;
  String? createdAt;
  String? updatedAt;

  CreatedBy(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.emailVerifiedAt,
      this.gender,
      this.status,
      this.createdAt,
      this.updatedAt});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['gender'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class ComboOfferProducts {
  int? id;
  int? comboOfferId;
  int? productId;
  int? quantity;
  String? unitPrice;
  String? createdAt;
  String? updatedAt;
  Product? product;

  ComboOfferProducts(
      {this.id,
      this.comboOfferId,
      this.productId,
      this.quantity,
      this.unitPrice,
      this.createdAt,
      this.updatedAt,
      this.product});

  ComboOfferProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comboOfferId = json['combo_offer_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
  List<Images>? images;
  Images? image;

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
      this.images,
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
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    image = json['image'] != null ? Images.fromJson(json['image']) : null;
  }
}

class Images {
  int? id;
  String? imageableType;
  int? imageableId;
  String? name;
  String? path;
  String? status;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
      this.imageableType,
      this.imageableId,
      this.name,
      this.path,
      this.status,
      this.createdAt,
      this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
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

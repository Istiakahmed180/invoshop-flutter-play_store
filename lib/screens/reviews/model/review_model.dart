class ReviewModel {
  bool? success;
  List<ReviewData>? data;

  ReviewModel({this.success, this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ReviewData>[];
      json['data'].forEach((v) {
        data!.add(ReviewData.fromJson(v));
      });
    }
  }
}

class ReviewData {
  int? id;
  int? userId;
  int? productId;
  String? content;
  int? rating;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? parentId;
  int? repliesCount;
  User? user;
  Product? product;

  ReviewData(
      {this.id,
      this.userId,
      this.productId,
      this.content,
      this.rating,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.parentId,
      this.repliesCount,
      this.user,
      this.product});

  ReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    content = json['content'];
    rating = json['rating'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parentId = json['parent_id'];
    repliesCount = json['replies_count'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
      this.weight});

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
  }
}

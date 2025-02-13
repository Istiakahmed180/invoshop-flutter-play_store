class VendorReviewModel {
  bool? success;
  List<VendorReviewData>? data;

  VendorReviewModel({this.success, this.data});

  VendorReviewModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <VendorReviewData>[];
      json['data'].forEach((v) {
        data!.add(VendorReviewData.fromJson(v));
      });
    }
  }
}

class VendorReviewData {
  int? id;
  int? userId;
  int? productId;
  String? content;
  int? rating;
  String? status;
  String? createdAt;
  String? updatedAt;
  Product? product;

  VendorReviewData(
      {this.id,
      this.userId,
      this.productId,
      this.content,
      this.rating,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.product});

  VendorReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    content = json['content'];
    rating = json['rating'];
    status = json['status'];
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
  Brand? brand;
  Unit? unit;
  List<Categories>? categories;
  List<Null>? colorVariant;
  List<Null>? sizeVariant;
  List<Null>? weightVariant;
  List<Null>? litreVariant;
  List<Null>? pieceVariant;
  List<Images>? images;
  List<Null>? galleryImages;
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
      this.brand,
      this.unit,
      this.categories,
      this.colorVariant,
      this.sizeVariant,
      this.weightVariant,
      this.litreVariant,
      this.pieceVariant,
      this.images,
      this.galleryImages,
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
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    image = json['image'] != null ? Images.fromJson(json['image']) : null;
  }
}

class Brand {
  int? id;
  String? title;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  Brand(
      {this.id,
      this.title,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Unit {
  int? id;
  String? name;
  String? unitType;
  String? status;
  String? createdAt;
  String? updatedAt;

  Unit(
      {this.id,
      this.name,
      this.unitType,
      this.status,
      this.createdAt,
      this.updatedAt});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    unitType = json['unit_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Categories {
  int? id;
  int? parentId;
  String? type;
  String? title;
  String? description;
  int? isMenuEnabled;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? laravelThroughKey;

  Categories(
      {this.id,
      this.parentId,
      this.type,
      this.title,
      this.description,
      this.isMenuEnabled,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.laravelThroughKey});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    isMenuEnabled = json['is_menu_enabled'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
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

class ProductsModel {
  bool? success;
  List<ProductsData>? data;

  ProductsModel({this.success, this.data});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProductsData>[];
      json['data'].forEach((v) {
        data!.add(ProductsData.fromJson(v));
      });
    }
  }
}

class ProductsData {
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
  Image? image;
  List<Categories>? categories;
  Unit? unit;
  List<ColorVariant>? colorVariant;
  List<SizeVariant>? sizeVariant;
  List<Images>? images;
  Brand? brand;

  ProductsData({
    this.id,
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
    this.image,
    this.categories,
    this.unit,
    this.colorVariant,
    this.sizeVariant,
    this.images,
    this.brand,
  });

  ProductsData.fromJson(Map<String, dynamic> json) {
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
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    if (json['color_variant'] != null) {
      colorVariant = <ColorVariant>[];
      json['color_variant'].forEach((v) {
        colorVariant!.add(ColorVariant.fromJson(v));
      });
    }
    if (json['size_variant'] != null) {
      sizeVariant = <SizeVariant>[];
      json['size_variant'].forEach((v) {
        sizeVariant!.add(SizeVariant.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'supplier_id': supplierId,
      'brand_id': brandId,
      'type_id': typeId,
      'unit_id': unitId,
      'tax_id': taxId,
      'tax_type': taxType,
      'tax_method': taxMethod,
      'discount_type': discountType,
      'product_code': productCode,
      'title': title,
      'available_stock': availableStock,
      'price': price,
      'sale_price': salePrice,
      'tax': tax,
      'discount': discount,
      'quantity': quantity,
      'intro_text': introText,
      'description': description,
      'is_featured': isFeatured,
      'is_expired': isExpired,
      'is_promo_sale': isPromoSale,
      'promo_price': promoPrice,
      'promo_start_at': promoStartAt,
      'promo_end_at': promoEndAt,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image': image?.toJson(),
      'categories': categories?.map((v) => v.toJson()).toList(),
      'unit': unit?.toJson(),
      'color_variant': colorVariant?.map((v) => v.toJson()).toList(),
      'size_variant': sizeVariant?.map((v) => v.toJson()).toList(),
      'images': images?.map((v) => v.toJson()).toList(),
      'brand': brand?.toJson()
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageable_type': imageableType,
      'imageable_id': imageableId,
      'name': name,
      'path': path,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'type': type,
      'title': title,
      'description': description,
      'is_menu_enabled': isMenuEnabled,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'laravel_through_key': laravelThroughKey,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unit_type': unitType,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class ColorVariant {
  int? id;
  String? name;
  String? variantType;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? laravelThroughKey;

  ColorVariant(
      {this.id,
      this.name,
      this.variantType,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.laravelThroughKey});

  ColorVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    variantType = json['variant_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'variant_type': variantType,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'laravel_through_key': laravelThroughKey,
    };
  }
}

class SizeVariant {
  int? id;
  String? name;
  String? variantType;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? laravelThroughKey;

  SizeVariant(
      {this.id,
      this.name,
      this.variantType,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.laravelThroughKey});

  SizeVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    variantType = json['variant_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'variant_type': variantType,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'laravel_through_key': laravelThroughKey,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageable_type': imageableType,
      'imageable_id': imageableId,
      'name': name,
      'path': path,
      'status': status,
      'createdAt': createdAt,
      'updated_at': updatedAt,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class OrdersModel {
  bool? success;
  List<OrdersData>? data;
  Supplier? vendor;

  OrdersModel({this.success, this.data, this.vendor});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <OrdersData>[];
      json['data'].forEach((v) {
        data!.add(OrdersData.fromJson(v));
      });
    }
    vendor = json['vendor'] != null ? Supplier.fromJson(json['vendor']) : null;
  }
}

class OrdersData {
  int? id;
  int? supplierId;
  int? orderProductId;
  String? amount;
  String? paidAt;
  int? loyalityPoints;
  String? status;
  String? createdAt;
  String? updatedAt;
  OrderProduct? orderProduct;

  OrdersData(
      {this.id,
      this.supplierId,
      this.orderProductId,
      this.amount,
      this.paidAt,
      this.loyalityPoints,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.orderProduct});

  OrdersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierId = json['supplier_id'];
    orderProductId = json['order_product_id'];
    amount = json['amount'];
    paidAt = json['paid_at'];
    loyalityPoints = json['loyality_points'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderProduct = json['order_product'] != null
        ? OrderProduct.fromJson(json['order_product'])
        : null;
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
  Product? product;

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
      this.updatedAt,
      this.product});

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
  List<Warehouses>? warehouses;
  Supplier? supplier;
  TaxObj? taxObj;
  Type? type;
  Brand? brand;
  Unit? unit;
  List<Categories>? categories;
  List<ColorVariant>? colorVariant;
  List<SizeVariant>? sizeVariant;
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
      this.warehouses,
      this.supplier,
      this.taxObj,
      this.type,
      this.brand,
      this.unit,
      this.categories,
      this.colorVariant,
      this.sizeVariant,
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
    if (json['warehouses'] != null) {
      warehouses = <Warehouses>[];
      json['warehouses'].forEach((v) {
        warehouses!.add(Warehouses.fromJson(v));
      });
    }
    supplier =
        json['supplier'] != null ? Supplier.fromJson(json['supplier']) : null;
    taxObj = json['tax_obj'] != null ? TaxObj.fromJson(json['tax_obj']) : null;
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
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

    image = json['image'] != null ? Images.fromJson(json['image']) : null;
  }
}

class Warehouses {
  int? id;
  int? countryId;
  String? name;
  String? phone;
  String? email;
  String? city;
  String? zipCode;
  String? address;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? laravelThroughKey;

  Warehouses(
      {this.id,
      this.countryId,
      this.name,
      this.phone,
      this.email,
      this.city,
      this.zipCode,
      this.address,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.laravelThroughKey});

  Warehouses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    city = json['city'];
    zipCode = json['zip_code'];
    address = json['address'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
  }
}

class Supplier {
  int? id;
  int? userId;
  int? companyId;
  int? countryId;
  int? districtId;
  int? areaId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? zipCode;
  String? address;
  String? supplierCode;
  String? supplierKey;
  String? storeName;
  String? description;
  String? status;
  int? isGeneratedSite;
  String? createdAt;
  String? updatedAt;
  String? city;
  String? storeEmail;
  String? storePhone;
  String? password;

  Supplier(
      {this.id,
      this.userId,
      this.companyId,
      this.countryId,
      this.districtId,
      this.areaId,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.zipCode,
      this.address,
      this.supplierCode,
      this.supplierKey,
      this.storeName,
      this.description,
      this.status,
      this.isGeneratedSite,
      this.createdAt,
      this.updatedAt,
      this.city,
      this.storeEmail,
      this.storePhone,
      this.password});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyId = json['company_id'];
    countryId = json['country_id'];
    districtId = json['district_id'];
    areaId = json['area_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    zipCode = json['zip_code'];
    address = json['address'];
    supplierCode = json['supplier_code'];
    supplierKey = json['supplier_key'];
    storeName = json['store_name'];
    description = json['description'];
    status = json['status'];
    isGeneratedSite = json['is_generated_site'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    city = json['city'];
    storeEmail = json['store_email'];
    storePhone = json['store_phone'];
    password = json['password'];
  }
}

class TaxObj {
  int? id;
  String? title;
  int? amount;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  TaxObj(
      {this.id,
      this.title,
      this.amount,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  TaxObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Type {
  int? id;
  int? parentId;
  String? type;
  String? title;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  Type(
      {this.id,
      this.parentId,
      this.type,
      this.title,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
}

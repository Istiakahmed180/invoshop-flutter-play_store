class SuppliersModel {
  bool? success;
  List<SuppliersData>? data;

  SuppliersModel({this.success, this.data});

  SuppliersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SuppliersData>[];
      json['data'].forEach((v) {
        data!.add(SuppliersData.fromJson(v));
      });
    }
  }
}

class SuppliersData {
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
  Company? company;
  Country? country;
  List<Images>? images;
  Image? image;

  SuppliersData(
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
      this.password,
      this.company,
      this.country,
      this.images,
      this.image});

  SuppliersData.fromJson(Map<String, dynamic> json) {
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
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }
}

class Company {
  int? id;
  String? companyName;
  String? status;
  String? createdAt;
  String? updatedAt;
  Image? image;

  Company(
      {this.id,
      this.companyName,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.image});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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

class Country {
  int? id;
  String? countryName;
  String? status;
  String? createdAt;
  String? updatedAt;

  Country(
      {this.id, this.countryName, this.status, this.createdAt, this.updatedAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['country_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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

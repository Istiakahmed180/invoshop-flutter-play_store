class DistrictModel {
  bool? success;
  List<DistrictData>? data;

  DistrictModel({this.success, this.data});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DistrictData>[];
      json['data'].forEach((v) {
        data!.add(DistrictData.fromJson(v));
      });
    }
  }
}

class DistrictData {
  int? id;
  String? title;

  DistrictData({this.id, this.title});

  DistrictData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}

class AreaModel {
  bool? success;
  List<AreaData>? data;

  AreaModel({this.success, this.data});

  AreaModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AreaData>[];
      json['data'].forEach((v) {
        data!.add(AreaData.fromJson(v));
      });
    }
  }
}

class AreaData {
  int? id;
  String? title;

  AreaData({this.id, this.title});

  AreaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}

class DomainModel {
  bool? success;
  List<DomainData>? data;

  DomainModel({this.success, this.data});

  DomainModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DomainData>[];
      json['data'].forEach((v) {
        data!.add(DomainData.fromJson(v));
      });
    }
  }
}

class DomainData {
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
  String? storeName;
  String? description;
  String? zipCode;
  String? address;
  String? supplierCode;
  String? supplierKey;
  String? status;
  int? isGeneratedSite;
  String? domainName;
  String? createdAt;
  String? updatedAt;
  String? city;
  String? storeEmail;
  String? storePhone;
  String? password;
  Company? company;
  Country? country;
  Area? area;

  DomainData(
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
      this.storeName,
      this.description,
      this.zipCode,
      this.address,
      this.supplierCode,
      this.supplierKey,
      this.status,
      this.isGeneratedSite,
      this.domainName,
      this.createdAt,
      this.updatedAt,
      this.city,
      this.storeEmail,
      this.storePhone,
      this.password,
      this.company,
      this.country,
      this.area});

  DomainData.fromJson(Map<String, dynamic> json) {
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
    storeName = json['store_name'];
    description = json['description'];
    zipCode = json['zip_code'];
    address = json['address'];
    supplierCode = json['supplier_code'];
    supplierKey = json['supplier_key'];
    status = json['status'];
    isGeneratedSite = json['is_generated_site'];
    domainName = json['domain_name'];
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
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
  }
}

class Company {
  int? id;
  String? companyName;
  String? status;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id, this.companyName, this.status, this.createdAt, this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
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

class Area {
  int? id;
  int? districtId;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  Area(
      {this.id,
      this.districtId,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

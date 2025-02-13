class BillerModel {
  bool? success;
  List<BillerData>? data;

  BillerModel({this.success, this.data});

  BillerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BillerData>[];
      json['data'].forEach((v) {
        data!.add(BillerData.fromJson(v));
      });
    }
  }
}

class BillerData {
  int? id;
  int? userId;
  int? warehouseId;
  int? countryId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? city;
  String? zipCode;
  String? billerCode;
  String? nidPassportNumber;
  String? address;
  String? dateOfJoin;
  String? status;
  String? createdAt;
  String? updatedAt;
  Warehouse? warehouse;
  Country? country;

  BillerData(
      {this.id,
      this.userId,
      this.warehouseId,
      this.countryId,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.city,
      this.zipCode,
      this.billerCode,
      this.nidPassportNumber,
      this.address,
      this.dateOfJoin,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.warehouse,
      this.country});

  BillerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    warehouseId = json['warehouse_id'];
    countryId = json['country_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    city = json['city'];
    zipCode = json['zip_code'];
    billerCode = json['biller_code'];
    nidPassportNumber = json['nid_passport_number'];
    address = json['address'];
    dateOfJoin = json['date_of_join'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    warehouse = json['warehouse'] != null
        ? Warehouse.fromJson(json['warehouse'])
        : null;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }
}

class Warehouse {
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

  Warehouse(
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
      this.updatedAt});

  Warehouse.fromJson(Map<String, dynamic> json) {
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

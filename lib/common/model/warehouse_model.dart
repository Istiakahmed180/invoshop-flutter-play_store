class WarehouseModel {
  bool? success;
  List<WarehouseData>? data;

  WarehouseModel({this.success, this.data});

  WarehouseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <WarehouseData>[];
      json['data'].forEach((v) {
        data!.add(WarehouseData.fromJson(v));
      });
    }
  }
}

class WarehouseData {
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
  Country? country;

  WarehouseData(
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
      this.country});

  WarehouseData.fromJson(Map<String, dynamic> json) {
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
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
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

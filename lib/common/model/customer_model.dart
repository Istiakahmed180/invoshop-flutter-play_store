class CustomerModel {
  bool? success;
  List<CustomerData>? data;

  CustomerModel({this.success, this.data});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CustomerData>[];
      json['data'].forEach((v) {
        data!.add(CustomerData.fromJson(v));
      });
    }
  }
}

class CustomerData {
  int? id;
  int? userId;
  int? countryId;
  int? categoryId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? city;
  String? zipCode;
  String? address;
  String? rewardPoint;
  String? status;
  String? createdAt;
  String? updatedAt;
  Category? category;
  Country? country;

  CustomerData(
      {this.id,
      this.userId,
      this.countryId,
      this.categoryId,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.city,
      this.zipCode,
      this.address,
      this.rewardPoint,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.country});

  CustomerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    countryId = json['country_id'];
    categoryId = json['category_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    city = json['city'];
    zipCode = json['zip_code'];
    address = json['address'];
    rewardPoint = json['reward_point'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }
}

class Category {
  int? id;
  int? parentId;
  String? type;
  String? title;
  String? description;
  int? isMenuEnabled;
  String? status;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.parentId,
      this.type,
      this.title,
      this.description,
      this.isMenuEnabled,
      this.status,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    isMenuEnabled = json['is_menu_enabled'];
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

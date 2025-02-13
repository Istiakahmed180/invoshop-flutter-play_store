class UsersModes {
  bool? success;
  List<UsersData>? data;

  UsersModes({this.success, this.data});

  UsersModes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <UsersData>[];
      json['data'].forEach((v) {
        data!.add(UsersData.fromJson(v));
      });
    }
  }
}

class UsersData {
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
  Image? image;
  List<Roles>? roles;

  UsersData(
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
      this.updatedAt,
      this.image,
      this.roles});

  UsersData.fromJson(Map<String, dynamic> json) {
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
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
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

class Roles {
  int? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Roles(
      {this.id,
      this.name,
      this.guardName,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
}

class Pivot {
  String? modelType;
  int? modelId;
  int? roleId;

  Pivot({this.modelType, this.modelId, this.roleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelType = json['model_type'];
    modelId = json['model_id'];
    roleId = json['role_id'];
  }
}

class CompanyModel {
  bool? success;
  List<CompanyData>? data;

  CompanyModel({this.success, this.data});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CompanyData>[];
      json['data'].forEach((v) {
        data!.add(CompanyData.fromJson(v));
      });
    }
  }
}

class CompanyData {
  int? id;
  String? title;
  Image? image;

  CompanyData({this.id, this.title, this.image});

  CompanyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
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

class BrandsModel {
  bool? success;
  List<BrandsData>? data;

  BrandsModel({this.success, this.data});

  BrandsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BrandsData>[];
      json['data'].forEach((v) {
        data!.add(BrandsData.fromJson(v));
      });
    }
  }
}

class BrandsData {
  int? id;
  String? title;
  List<Images>? images;
  Images? image;

  BrandsData({this.id, this.title, this.images, this.image});

  BrandsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    image = json['image'] != null ? Images.fromJson(json['image']) : null;
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

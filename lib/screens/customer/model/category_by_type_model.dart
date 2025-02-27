class CategoryByTypeModel {
  bool? success;
  List<CategoryByTypeData>? data;

  CategoryByTypeModel({this.success, this.data});

  CategoryByTypeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CategoryByTypeData>[];
      json['data'].forEach((v) {
        data!.add(CategoryByTypeData.fromJson(v));
      });
    }
  }
}

class CategoryByTypeData {
  int? id;
  String? title;
  int? parentId;
  String? type;
  String? parent;
  List<Images>? images;
  Images? image;

  CategoryByTypeData({
    this.id,
    this.title,
    this.parentId,
    this.type,
    this.parent,
    this.images,
    this.image,
  });

  CategoryByTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parent_id'];
    type = json['type'];
    parent = json['parent'];
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

  Images({
    this.id,
    this.imageableType,
    this.imageableId,
    this.name,
    this.path,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

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

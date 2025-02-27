class ProductTypeModel {
  bool? success;
  List<ProductTypeData>? data;

  ProductTypeModel({this.success, this.data});

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProductTypeData>[];
      json['data'].forEach((v) {
        data!.add(ProductTypeData.fromJson(v));
      });
    }
  }
}

class ProductTypeData {
  int? id;
  String? title;
  int? parentId;
  String? type;
  String? parent;

  ProductTypeData({this.id, this.title, this.parentId, this.type, this.parent});

  ProductTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parent_id'];
    type = json['type'];
    parent = json['parent'];
  }
}

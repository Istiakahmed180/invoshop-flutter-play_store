class ColorVariantsModel {
  bool? success;
  List<ColorVariantsData>? data;

  ColorVariantsModel({this.success, this.data});

  ColorVariantsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ColorVariantsData>[];
      json['data'].forEach((v) {
        data!.add(ColorVariantsData.fromJson(v));
      });
    }
  }
}

class ColorVariantsData {
  int? id;
  String? name;
  String? variantType;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? variant;

  ColorVariantsData(
      {this.id,
      this.name,
      this.variantType,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.variant});

  ColorVariantsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    variantType = json['variant_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    variant = json['variant'];
  }
}

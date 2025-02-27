class SizeVariantsModel {
  bool? success;
  List<SizeVariantsData>? data;

  SizeVariantsModel({this.success, this.data});

  SizeVariantsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SizeVariantsData>[];
      json['data'].forEach((v) {
        data!.add(SizeVariantsData.fromJson(v));
      });
    }
  }
}

class SizeVariantsData {
  int? id;
  String? name;
  String? variantType;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? variant;

  SizeVariantsData(
      {this.id,
      this.name,
      this.variantType,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.variant});

  SizeVariantsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    variantType = json['variant_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    variant = json['variant'];
  }
}

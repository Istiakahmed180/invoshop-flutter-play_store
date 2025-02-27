class UnitModel {
  bool? success;
  List<UnitData>? data;

  UnitModel({this.success, this.data});

  UnitModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <UnitData>[];
      json['data'].forEach((v) {
        data!.add(UnitData.fromJson(v));
      });
    }
  }
}

class UnitData {
  int? id;
  String? name;
  String? unitType;
  String? status;
  String? createdAt;
  String? updatedAt;

  UnitData(
      {this.id,
      this.name,
      this.unitType,
      this.status,
      this.createdAt,
      this.updatedAt});

  UnitData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    unitType = json['unit_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class AllBankModel {
  bool? success;
  List<AllBankData>? data;

  AllBankModel({this.success, this.data});

  AllBankModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AllBankData>[];
      json['data'].forEach((v) {
        data!.add(AllBankData.fromJson(v));
      });
    }
  }
}

class AllBankData {
  int? id;
  String? name;
  String? details;
  String? status;
  String? createdAt;
  String? updatedAt;

  AllBankData(
      {this.id,
      this.name,
      this.details,
      this.status,
      this.createdAt,
      this.updatedAt});

  AllBankData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

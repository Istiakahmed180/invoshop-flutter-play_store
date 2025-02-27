class TaxModel {
  bool? success;
  List<TaxData>? data;

  TaxModel({this.success, this.data});

  TaxModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TaxData>[];
      json['data'].forEach((v) {
        data!.add(TaxData.fromJson(v));
      });
    }
  }
}

class TaxData {
  int? id;
  String? title;
  int? amount;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  TaxData(
      {this.id,
      this.title,
      this.amount,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  TaxData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

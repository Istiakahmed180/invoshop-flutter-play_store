class CouponsModel {
  bool? success;
  List<CouponsData>? data;

  CouponsModel({this.success, this.data});

  CouponsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CouponsData>[];
      json['data'].forEach((v) {
        data!.add(CouponsData.fromJson(v));
      });
    }
  }
}

class CouponsData {
  int? id;
  String? title;
  String? code;
  String? type;
  String? amount;
  String? startDate;
  String? expireDate;
  int? limit;
  int? isPublished;
  String? details;
  String? status;
  String? createdAt;

  CouponsData(
      {this.id,
      this.title,
      this.code,
      this.type,
      this.amount,
      this.startDate,
      this.expireDate,
      this.limit,
      this.isPublished,
      this.details,
      this.status,
      this.createdAt});

  CouponsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    type = json['type'];
    amount = json['amount'];
    startDate = json['start_date'];
    expireDate = json['expire_date'];
    limit = json['limit'];
    isPublished = json['is_published'];
    details = json['details'];
    status = json['status'];
    createdAt = json['created_at'];
  }
}

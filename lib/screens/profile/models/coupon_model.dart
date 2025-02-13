class CouponModel {
  bool? success;
  String? message;
  CouponData? data;

  CouponModel({this.success, this.message, this.data});

  CouponModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CouponData.fromJson(json['data']) : null;
  }
}

class CouponData {
  int? id;
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
  String? updatedAt;
  int? createdBy;
  String? title;

  CouponData(
      {this.id,
      this.code,
      this.type,
      this.amount,
      this.startDate,
      this.expireDate,
      this.limit,
      this.isPublished,
      this.details,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.title});

  CouponData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    title = json['title'];
  }
}

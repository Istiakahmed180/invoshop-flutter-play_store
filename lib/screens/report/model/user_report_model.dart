class UserReportModel {
  bool? success;
  List<UserReportData>? data;

  UserReportModel({this.success, this.data});

  UserReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <UserReportData>[];
      json['data'].forEach((v) {
        data!.add(UserReportData.fromJson(v));
      });
    }
  }
}

class UserReportData {
  String? name;
  String? phone;
  String? email;

  UserReportData({this.name, this.phone, this.email});

  UserReportData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }
}

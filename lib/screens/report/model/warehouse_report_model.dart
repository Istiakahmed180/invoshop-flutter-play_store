class WarehouseReportModel {
  bool? success;
  List<WarehouseReportData>? data;

  WarehouseReportModel({this.success, this.data});

  WarehouseReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <WarehouseReportData>[];
      json['data'].forEach((v) {
        data!.add(WarehouseReportData.fromJson(v));
      });
    }
  }
}

class WarehouseReportData {
  String? name;
  String? phone;
  String? email;
  String? address;

  WarehouseReportData({this.name, this.phone, this.email, this.address});

  WarehouseReportData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
  }
}

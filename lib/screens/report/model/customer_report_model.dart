class CustomerReportModel {
  bool? success;
  List<CustomerReportData>? data;

  CustomerReportModel({this.success, this.data});

  CustomerReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CustomerReportData>[];
      json['data'].forEach((v) {
        data!.add(CustomerReportData.fromJson(v));
      });
    }
  }
}

class CustomerReportData {
  String? saleDate;
  String? customerName;
  String? customerPhone;
  String? warehouseName;
  String? products;
  String? totalAmount;

  CustomerReportData(
      {this.saleDate,
      this.customerName,
      this.customerPhone,
      this.warehouseName,
      this.products,
      this.totalAmount});

  CustomerReportData.fromJson(Map<String, dynamic> json) {
    saleDate = json['sale_date'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    warehouseName = json['warehouse_name'];
    products = json['products'];
    totalAmount = json['total_amount'];
  }
}

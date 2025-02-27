class SalesReportModel {
  bool? success;
  List<SalesReportData>? data;

  SalesReportModel({this.success, this.data});

  SalesReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SalesReportData>[];
      json['data'].forEach((v) {
        data!.add(SalesReportData.fromJson(v));
      });
    }
  }
}

class SalesReportData {
  String? saleDate;
  String? warehouseName;
  String? productName;
  String? productCode;
  String? unit;
  int? productStock;
  int? quantity;
  String? saleAmount;

  SalesReportData(
      {this.saleDate,
      this.warehouseName,
      this.productName,
      this.productCode,
      this.unit,
      this.productStock,
      this.quantity,
      this.saleAmount});

  SalesReportData.fromJson(Map<String, dynamic> json) {
    saleDate = json['sale_date'];
    warehouseName = json['warehouse_name'];
    productName = json['product_name'];
    productCode = json['product_code'];
    unit = json['unit'];
    productStock = json['product_stock'];
    quantity = json['quantity'];
    if (json['sale_amount'] != null) {
      if (json['sale_amount'] is double) {
        saleAmount = json['sale_amount'].toString();
      } else if (json['sale_amount'] is String) {
        saleAmount = json['sale_amount'];
      } else {
        saleAmount = "N/A";
      }
    } else {
      saleAmount = "N/A";
    }
  }
}

class SupplierReportModel {
  bool? success;
  List<SupplierReportData>? data;

  SupplierReportModel({this.success, this.data});

  SupplierReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SupplierReportData>[];
      json['data'].forEach((v) {
        data!.add(SupplierReportData.fromJson(v));
      });
    }
  }
}

class SupplierReportData {
  String? purchaseDate;
  String? supplierName;
  String? supplierCode;
  String? warehouseName;
  String? products;
  String? totalAmount;

  SupplierReportData(
      {this.purchaseDate,
      this.supplierName,
      this.supplierCode,
      this.warehouseName,
      this.products,
      this.totalAmount});

  SupplierReportData.fromJson(Map<String, dynamic> json) {
    purchaseDate = json['purchase_date'];
    supplierName = json['supplier_name'];
    supplierCode = json['supplier_code'];
    warehouseName = json['warehouse_name'];
    products = json['products'];
    totalAmount = json['total_amount'];
  }
}

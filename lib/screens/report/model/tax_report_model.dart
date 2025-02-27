class TaxReportModel {
  bool? success;
  List<TaxReportData>? data;

  TaxReportModel({this.success, this.data});

  TaxReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TaxReportData>[];
      json['data'].forEach((v) {
        data!.add(TaxReportData.fromJson(v));
      });
    }
  }
}

class TaxReportData {
  String? saleDate;
  String? warehouseName;
  String? productName;
  int? invoiceNo;
  String? taxType;
  String? tax;

  TaxReportData(
      {this.saleDate,
      this.warehouseName,
      this.productName,
      this.invoiceNo,
      this.taxType,
      this.tax});

  TaxReportData.fromJson(Map<String, dynamic> json) {
    saleDate = json['sale_date'];
    warehouseName = json['warehouse_name'];
    productName = json['product_name'];
    invoiceNo = json['invoice_no'];
    taxType = json['tax_type'];
    tax = json['tax'];
  }
}

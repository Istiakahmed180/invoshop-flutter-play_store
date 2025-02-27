class DiscountReportModel {
  bool? success;
  List<DiscountReportData>? data;

  DiscountReportModel({this.success, this.data});

  DiscountReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DiscountReportData>[];
      json['data'].forEach((v) {
        data!.add(DiscountReportData.fromJson(v));
      });
    }
  }
}

class DiscountReportData {
  String? saleDate;
  String? warehouseName;
  String? productName;
  int? invoiceNo;
  String? discountType;
  String? discount;

  DiscountReportData(
      {this.saleDate,
      this.warehouseName,
      this.productName,
      this.invoiceNo,
      this.discountType,
      this.discount});

  DiscountReportData.fromJson(Map<String, dynamic> json) {
    saleDate = json['sale_date'];
    warehouseName = json['warehouse_name'];
    productName = json['product_name'];
    invoiceNo = json['invoice_no'];
    discountType = json['discount_type'];
    discount = json['discount'];
  }
}

class PurchaseReportModel {
  bool? success;
  List<PurchaseReportData>? data;

  PurchaseReportModel({this.success, this.data});

  PurchaseReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PurchaseReportData>[];
      json['data'].forEach((v) {
        data!.add(PurchaseReportData.fromJson(v));
      });
    }
  }
}

class PurchaseReportData {
  String? purchaseDate;
  String? companyName;
  String? productName;
  String? unit;
  int? quantity;
  int? purchaseAmount;

  PurchaseReportData(
      {this.purchaseDate,
      this.companyName,
      this.productName,
      this.unit,
      this.quantity,
      this.purchaseAmount});

  PurchaseReportData.fromJson(Map<String, dynamic> json) {
    purchaseDate = json['purchase_date'];
    companyName = json['company_name'];
    productName = json['product_name'];
    unit = json['unit'];
    quantity = json['quantity'];
    purchaseAmount = json['purchase_amount'];
  }
}

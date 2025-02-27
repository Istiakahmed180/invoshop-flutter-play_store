class StockReportModel {
  bool? success;
  List<StockReportData>? data;

  StockReportModel({this.success, this.data});

  StockReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <StockReportData>[];
      json['data'].forEach((v) {
        data!.add(StockReportData.fromJson(v));
      });
    }
  }
}

class StockReportData {
  String? date;
  String? warehouseName;
  String? productName;
  int? availableStock;
  int? stock;
  String? unit;

  StockReportData(
      {this.date,
      this.warehouseName,
      this.productName,
      this.availableStock,
      this.stock,
      this.unit});

  StockReportData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    warehouseName = json['warehouse_name'];
    productName = json['product_name'];
    availableStock = json['available_stock'];
    stock = json['stock'];
    unit = json['unit'];
  }
}

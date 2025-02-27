class ProductReportModel {
  bool? success;
  List<ProductReportData>? data;

  ProductReportModel({this.success, this.data});

  ProductReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProductReportData>[];
      json['data'].forEach((v) {
        data!.add(ProductReportData.fromJson(v));
      });
    }
  }
}

class ProductReportData {
  String? date;
  String? warehouseName;
  String? productName;
  int? availableStock;
  String? price;
  int? saleQuantity;
  double? saleAmount;
  int? purchaseQuantity;
  int? purchaseAmount;

  ProductReportData(
      {this.date,
      this.warehouseName,
      this.productName,
      this.availableStock,
      this.price,
      this.saleQuantity,
      this.saleAmount,
      this.purchaseQuantity,
      this.purchaseAmount});

  ProductReportData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    warehouseName = json['warehouse_name'];
    productName = json['product_name'];
    availableStock = json['available_stock'];
    price = json['price'];
    saleQuantity = json['sale_quantity'];
    if (json['sale_amount'] != null) {
      if (json['sale_amount'] is int) {
        saleAmount = (json['sale_amount'] as int).toDouble();
      } else if (json['sale_amount'] is double) {
        saleAmount = json['sale_amount'];
      } else {
        saleAmount = null;
      }
    } else {
      saleAmount = null;
    }
    purchaseQuantity = json['purchase_quantity'];
    purchaseAmount = json['purchase_amount'];
  }
}

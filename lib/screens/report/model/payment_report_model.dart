class PaymentReportModel {
  bool? success;
  List<PaymentReportData>? data;

  PaymentReportModel({this.success, this.data});

  PaymentReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PaymentReportData>[];
      json['data'].forEach((v) {
        data!.add(PaymentReportData.fromJson(v));
      });
    }
  }
}

class PaymentReportData {
  String? paymentDate;
  String? warehouseName;
  String? referenceNo;
  int? invoiceNo;
  String? paymentType;
  String? paymentStatus;
  String? payableAmount;
  String? customerEmail;

  PaymentReportData(
      {this.paymentDate,
      this.warehouseName,
      this.referenceNo,
      this.invoiceNo,
      this.paymentType,
      this.paymentStatus,
      this.payableAmount,
      this.customerEmail});

  PaymentReportData.fromJson(Map<String, dynamic> json) {
    paymentDate = json['payment_date'];
    warehouseName = json['warehouse_name'];
    referenceNo = json['reference_no'];
    invoiceNo = json['invoice_no'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    payableAmount = json['payable_amount'];
    customerEmail = json['customer_email'];
  }
}

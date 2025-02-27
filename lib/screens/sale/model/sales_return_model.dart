class SalesReturnModel {
  bool? success;
  List<SalesReturnData>? data;

  SalesReturnModel({this.success, this.data});

  SalesReturnModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SalesReturnData>[];
      json['data'].forEach((v) {
        data!.add(SalesReturnData.fromJson(v));
      });
    }
  }
}

class SalesReturnData {
  int? id;
  int? userId;
  int? customerId;
  int? warehouseId;
  int? billerId;
  String? amount;
  String? taxAmount;
  String? discount;
  String? shippingAmount;
  String? totalAmount;
  String? refundDateAt;
  String? refundTimeAt;
  String? remark;
  String? refundNote;
  String? refundStatus;
  String? status;
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  Warehouse? warehouse;
  Customer? biller;

  SalesReturnData(
      {this.id,
      this.userId,
      this.customerId,
      this.warehouseId,
      this.billerId,
      this.amount,
      this.taxAmount,
      this.discount,
      this.shippingAmount,
      this.totalAmount,
      this.refundDateAt,
      this.refundTimeAt,
      this.remark,
      this.refundNote,
      this.refundStatus,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.customer,
      this.warehouse,
      this.biller});

  SalesReturnData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    warehouseId = json['warehouse_id'];
    billerId = json['biller_id'];
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    discount = json['discount'];
    shippingAmount = json['shipping_amount'];
    totalAmount = json['total_amount'];
    refundDateAt = json['refund_date_at'];
    refundTimeAt = json['refund_time_at'];
    remark = json['remark'];
    refundNote = json['refund_note'];
    refundStatus = json['refund_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    warehouse = json['warehouse'] != null
        ? Warehouse.fromJson(json['warehouse'])
        : null;
    biller = json['biller'] != null ? Customer.fromJson(json['biller']) : null;
  }
}

class Customer {
  int? id;
  String? firstName;
  String? lastName;

  Customer({this.id, this.firstName, this.lastName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }
}

class Warehouse {
  int? id;
  String? name;

  Warehouse({this.id, this.name});

  Warehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

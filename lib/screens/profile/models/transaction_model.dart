class TransactionModel {
  bool? success;
  List<TransactionData>? data;

  TransactionModel({this.success, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TransactionData>[];
      json['data'].forEach((v) {
        data!.add(TransactionData.fromJson(v));
      });
    }
  }
}

class TransactionData {
  Customer? customer;
  List<OrderProducts>? orderProducts;
  String? totalAmount;
  int? totalOrders;
  String? status;
  String? paidAt;

  TransactionData(
      {this.customer,
      this.orderProducts,
      this.totalAmount,
      this.totalOrders,
      this.status,
      this.paidAt});

  TransactionData.fromJson(Map<String, dynamic> json) {
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProducts.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    totalOrders = json['total_orders'];
    status = json['status'];
    paidAt = json['paid_at'];
  }
}

class Customer {
  int? id;
  int? userId;
  int? countryId;
  int? categoryId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? city;
  String? zipCode;
  String? address;
  String? rewardPoint;
  String? status;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.userId,
      this.countryId,
      this.categoryId,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.city,
      this.zipCode,
      this.address,
      this.rewardPoint,
      this.status,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    countryId = json['country_id'];
    categoryId = json['category_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    city = json['city'];
    zipCode = json['zip_code'];
    address = json['address'];
    rewardPoint = json['reward_point'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class OrderProducts {
  int? id;
  int? orderId;
  int? productId;
  String? amount;
  String? taxAmount;
  String? discount;
  String? saleAmount;
  int? quantity;
  String? saleStatus;
  int? isAccepted;
  String? status;
  String? createdAt;
  String? updatedAt;
  Product? product;

  OrderProducts(
      {this.id,
      this.orderId,
      this.productId,
      this.amount,
      this.taxAmount,
      this.discount,
      this.saleAmount,
      this.quantity,
      this.saleStatus,
      this.isAccepted,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.product});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    discount = json['discount'];
    saleAmount = json['sale_amount'];
    quantity = json['quantity'];
    saleStatus = json['sale_status'];
    isAccepted = json['is_accepted'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  String? title;

  Product({this.id, this.title});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}

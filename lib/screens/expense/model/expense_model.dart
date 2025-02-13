class ExpenseModel {
  bool? success;
  List<ExpenseData>? data;

  ExpenseModel({this.success, this.data});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ExpenseData>[];
      json['data'].forEach((v) {
        data!.add(ExpenseData.fromJson(v));
      });
    }
  }
}

class ExpenseData {
  int? id;
  int? userId;
  int? warehouseId;
  int? supplierId;
  int? categoryId;
  String? amount;
  String? expenseDateAt;
  String? voucherNo;
  String? expenseType;
  String? comment;
  String? status;
  String? createdAt;
  String? updatedAt;
  Warehouse? warehouse;
  Category? category;

  ExpenseData(
      {this.id,
      this.userId,
      this.warehouseId,
      this.supplierId,
      this.categoryId,
      this.amount,
      this.expenseDateAt,
      this.voucherNo,
      this.expenseType,
      this.comment,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.warehouse,
      this.category});

  ExpenseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    warehouseId = json['warehouse_id'];
    supplierId = json['supplier_id'];
    categoryId = json['category_id'];
    amount = json['amount'];
    expenseDateAt = json['expense_date_at'];
    voucherNo = json['voucher_no'];
    expenseType = json['expense_type'];
    comment = json['comment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    warehouse = json['warehouse'] != null
        ? Warehouse.fromJson(json['warehouse'])
        : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }
}

class Warehouse {
  int? id;
  int? countryId;
  String? name;
  String? phone;
  String? email;
  String? city;
  String? zipCode;
  String? address;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  Warehouse(
      {this.id,
      this.countryId,
      this.name,
      this.phone,
      this.email,
      this.city,
      this.zipCode,
      this.address,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Warehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    city = json['city'];
    zipCode = json['zip_code'];
    address = json['address'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Category {
  int? id;
  int? parentId;
  String? type;
  String? title;
  String? description;
  int? isMenuEnabled;
  String? status;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.parentId,
      this.type,
      this.title,
      this.description,
      this.isMenuEnabled,
      this.status,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    isMenuEnabled = json['is_menu_enabled'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

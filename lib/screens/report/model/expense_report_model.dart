class ExpenseReportModel {
  bool? success;
  List<ExpenseReportData>? data;

  ExpenseReportModel({this.success, this.data});

  ExpenseReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ExpenseReportData>[];
      json['data'].forEach((v) {
        data!.add(ExpenseReportData.fromJson(v));
      });
    }
  }
}

class ExpenseReportData {
  String? expenseDate;
  String? warhouseName;
  String? categoryName;
  String? expenseType;
  String? amount;

  ExpenseReportData(
      {this.expenseDate,
      this.warhouseName,
      this.categoryName,
      this.expenseType,
      this.amount});

  ExpenseReportData.fromJson(Map<String, dynamic> json) {
    expenseDate = json['expense_date'];
    warhouseName = json['warhouse_name'];
    categoryName = json['category_name'];
    expenseType = json['expense_type'];
    amount = json['amount'];
  }
}

class BankAccountModel {
  bool? success;
  List<BankAccountData>? data;

  BankAccountModel({this.success, this.data});

  BankAccountModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BankAccountData>[];
      json['data'].forEach((v) {
        data!.add(BankAccountData.fromJson(v));
      });
    }
  }
}

class BankAccountData {
  int? id;
  int? bankId;
  int? supplierId;
  String? accountName;
  String? accountDisplayName;
  String? accountNo;
  String? accountType;
  String? roundNo;
  String? branchName;
  String? branchAddress;
  String? status;
  String? createdAt;
  String? updatedAt;

  BankAccountData(
      {this.id,
      this.bankId,
      this.supplierId,
      this.accountName,
      this.accountDisplayName,
      this.accountNo,
      this.accountType,
      this.roundNo,
      this.branchName,
      this.branchAddress,
      this.status,
      this.createdAt,
      this.updatedAt});

  BankAccountData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bank_id'];
    supplierId = json['supplier_id'];
    accountName = json['account_name'];
    accountDisplayName = json['account_display_name'];
    accountNo = json['account_no'];
    accountType = json['account_type'];
    roundNo = json['round_no'];
    branchName = json['branch_name'];
    branchAddress = json['branch_address'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

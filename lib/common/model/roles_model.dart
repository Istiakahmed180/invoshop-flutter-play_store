class RolesModel {
  bool? success;
  List<RolesData>? data;

  RolesModel({this.success, this.data});

  RolesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <RolesData>[];
      json['data'].forEach((v) {
        data!.add(RolesData.fromJson(v));
      });
    }
  }
}

class RolesData {
  int? id;
  String? title;
  String? guardName;

  RolesData({this.id, this.title, this.guardName});

  RolesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    guardName = json['guard_name'];
  }
}

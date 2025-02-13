class DeliveryAreaModel {
  bool? success;
  DeliveryAreaData? data;

  DeliveryAreaModel({this.success, this.data});

  DeliveryAreaModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? DeliveryAreaData.fromJson(json['data']) : null;
  }
}

class DeliveryAreaData {
  List<dynamic>? steadfast;
  List<Redx>? redx;

  DeliveryAreaData({this.steadfast, this.redx});

  DeliveryAreaData.fromJson(Map<String, dynamic> json) {
    if (json['steadfast'] != null) {
      steadfast = <dynamic>[];
      json['steadfast'].forEach((v) {
        steadfast!.add(v);
      });
    }
    if (json['redx'] != null) {
      redx = <Redx>[];
      json['redx'].forEach((v) {
        redx!.add(Redx.fromJson(v));
      });
    }
  }
}

class Redx {
  int? id;
  String? name;
  int? postCode;
  String? districtName;
  String? divisionName;
  int? zoneId;
  String? title;

  Redx({
    this.id,
    this.name,
    this.postCode,
    this.districtName,
    this.divisionName,
    this.zoneId,
    this.title,
  });

  Redx.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    postCode = json['post_code'];
    districtName = json['district_name'];
    divisionName = json['division_name'];
    zoneId = json['zone_id'];
    title = json['title'];
  }
}

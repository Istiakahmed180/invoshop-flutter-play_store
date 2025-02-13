class CourierModel {
  bool? success;
  List<CourierData>? data;

  CourierModel({this.success, this.data});

  CourierModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CourierData>[];
      json['data'].forEach((v) {
        data!.add(CourierData.fromJson(v));
      });
    }
  }
}

class CourierData {
  int? id;
  String? type;
  String? keyName;
  int? status;
  Values? values;

  CourierData({this.id, this.type, this.keyName, this.status, this.values});

  CourierData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    keyName = json['key_name'];
    status = json['status'];
    values = json['values'] != null ? Values.fromJson(json['values']) : null;
  }
}

class Values {
  String? name;
  String? mode;
  String? image;
  String? apiKey;
  String? secretKey;
  String? insideDhakaCost;
  String? outsideDhakaCost;
  String? accessToken;

  Values(
      {this.name,
      this.mode,
      this.image,
      this.apiKey,
      this.secretKey,
      this.insideDhakaCost,
      this.outsideDhakaCost,
      this.accessToken});

  Values.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mode = json['mode'];
    image = json['image'];
    apiKey = json['api_key'];
    secretKey = json['secret_key'];
    insideDhakaCost = json['inside_dhaka_cost'];
    outsideDhakaCost = json['outside_dhaka_cost'];
    accessToken = json['access_token'];
  }
}

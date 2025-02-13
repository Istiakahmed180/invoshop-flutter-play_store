class CountryModel {
  bool? success;
  List<CountryData>? data;

  CountryModel({this.success, this.data});

  CountryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CountryData>[];
      json['data'].forEach((v) {
        data!.add(CountryData.fromJson(v));
      });
    }
  }
}

class CountryData {
  int? id;
  String? title;

  CountryData({this.id, this.title});

  CountryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}

class OverviewModel {
  bool? success;
  OverviewData? data;

  OverviewModel({this.success, this.data});

  OverviewModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? OverviewData.fromJson(json['data']) : null;
  }
}

class OverviewData {
  String? totalEarnings;
  String? currentEarnings;
  String? pendingEarnings;
  String? totalOrders;
  String? currentOrders;
  String? pendingOrders;
  String? totalReviews;
  String? avgRating;
  String? maxRating;
  String? royaltyPoints;

  OverviewData(
      {this.totalEarnings,
      this.currentEarnings,
      this.pendingEarnings,
      this.totalOrders,
      this.currentOrders,
      this.pendingOrders,
      this.totalReviews,
      this.avgRating,
      this.maxRating,
      this.royaltyPoints});

  OverviewData.fromJson(Map<String, dynamic> json) {
    totalEarnings = json['total_earnings'];
    currentEarnings = json['current_earnings'];
    pendingEarnings = json['pending_earnings'];
    totalOrders = json['total_orders'];
    currentOrders = json['current_orders'];
    pendingOrders = json['pending_orders'];
    totalReviews = json['total_reviews'];
    avgRating = json['avg_rating'];
    maxRating = json['max_rating'];
    royaltyPoints = json['royalty_points'];
  }
}

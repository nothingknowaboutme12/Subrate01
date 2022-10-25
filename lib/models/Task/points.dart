class Points {
 late int? doPoints;
 late int? giftPoints;
 late int total;


  Points.fromJson(Map<String, dynamic> json) {
    doPoints = json['do_points'] ?? 0;
    giftPoints = json['gift_points'] ?? 0;
    total = json['total'];
  }
}
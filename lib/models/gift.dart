class Gift {
  late int id;
  late String points;
  late String rate;
  late String userId;
  late String adminId;
  late String createdAt;
  late String updatedAt;


  Gift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
    rate = json['rate'];
    userId = json['user_id'];
    adminId = json['admin_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
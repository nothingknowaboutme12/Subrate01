class Payout {
  int? id;
  String? approved;
  String? amount;
  String? data;
  String? createdAt;
  String? updatedAt;
  String? userId;
  String? adminId;
  String? paymentGatewayId;


  Payout.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    approved = json['approved'] ?? '';
    amount = json['amount'] ?? '';
    data = json['data'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    userId = json['user_id'] ?? '';
    adminId = json['admin_id'] ?? '';
    paymentGatewayId = json['payment_gateway_id'] ?? '';
  }


}

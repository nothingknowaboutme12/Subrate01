class PaymentGateway {
 late int id;
 late String name;
 late String? data;
 late String? image;



  PaymentGateway.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    data = json['data'];
    image = json['image'];

  }
}
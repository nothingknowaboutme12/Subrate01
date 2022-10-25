import 'User.dart';

class Data {
 late String token;
 late User user;

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = User.fromJson(json['user']);
  }
}

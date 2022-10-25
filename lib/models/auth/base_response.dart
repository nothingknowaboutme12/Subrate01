import 'Data.dart';

class BaseResponse {
  late bool success;
  late String description;
  late Data data;

  BaseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    description = json['description'];
    data = Data.fromJson(json['data']);
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../../models/authorization_header.dart';
import '../../../../../models/payment/payment_gateway.dart';
import '../../../../../models/payment/payout.dart';
import '../../../local/prefs/user_preference_controller.dart';
import '../api_settings.dart';

class PaymentGatewayApiController {
  String token = UserPreferenceController().token;

  Future<List<PaymentGateway>> getPaymentGatWays() async {
    var url = Uri.parse(ApiSettings.paymentGatWayUrl);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 200) {
      var dataJsonArray = jsonDecode(response.body);
      late PaymentGateway paymentGatWay;
      List<PaymentGateway> paymentGatWays = [];
      for (var item in dataJsonArray['data']) {
        paymentGatWay = PaymentGateway.fromJson(item);
        paymentGatWays.add(paymentGatWay);
      }
      return paymentGatWays;
    }
    return [];
  }

  Future<List<Payout>> getPayouts() async {
    var url = Uri.parse(ApiSettings.payoutsUrl);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 200) {
      var dataJsonArray = jsonDecode(response.body);
      Map<String, dynamic> jsonMap = dataJsonArray['data'];
      late Payout payout;
      List<Payout> payouts = [];
      for (var item in jsonMap['data']) {
        payout = Payout.fromJson(item);
        payouts.add(payout);
      }
      return payouts;
    }
    return [];
  }
}

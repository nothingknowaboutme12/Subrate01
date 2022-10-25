import 'package:get/get.dart';

import '../../models/payment/payment_gateway.dart';
import '../../models/payment/payout.dart';
import '../storage/network/api/controllers/payment_gateway_api_controller.dart';

class PaymentGatewayGetXController extends GetxController {
  RxList<PaymentGateway> paymentGatWays = <PaymentGateway>[].obs;
  RxList<Payout> payouts = <Payout>[].obs;
  final PaymentGatewayApiController _paymentGatWayApiController =
      PaymentGatewayApiController();

  static PaymentGatewayGetXController get to => Get.find();

  @override
  void onInit() {
    readPaymentGatWays();
    readPayouts();
    super.onInit();
  }

  Future<void> readPaymentGatWays() async {
    paymentGatWays.value = await _paymentGatWayApiController.getPaymentGatWays()
        as List<PaymentGateway>;
  }

  Future<void> readPayouts() async {
    payouts.value = await _paymentGatWayApiController.getPayouts();
  }
}

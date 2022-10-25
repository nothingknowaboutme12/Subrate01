import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionGetXController extends GetxController {
  final RxString _connectionStatus = ConnectivityResult.none.name.obs;

  static ConnectionGetXController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> changeConnection({required String status}) async {
    _connectionStatus.value = status;
    _connectionStatus.refresh();
  }

  String get connectionStatus => _connectionStatus.value;
}

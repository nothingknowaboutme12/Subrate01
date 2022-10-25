import 'package:get/get.dart';

import '../../models/gift.dart';
import '../storage/network/api/controllers/app_api_controller.dart';

class AppGetXController extends GetxController {
  final RxInt _selectedBottomBarScreen = 0.obs;
  RxInt rank = 0.obs;
  RxList<Gift> gifts = <Gift>[].obs;

  final AppApiController _appApiController = AppApiController();

  static AppGetXController get to => Get.find();

  @override
  void onInit() {
    readRank();
    readGifts();
    super.onInit();
  }

  Future<void> changeSelectedBottomBarScreen(
      {required int selectedIndex}) async {
    _selectedBottomBarScreen.value = selectedIndex;
    _selectedBottomBarScreen.refresh();
  }

  Future<void> readRank() async {
    rank.value = await _appApiController.getRank();
  }

  Future<void> readGifts() async {
    gifts.value = await _appApiController.getGifts() as List<Gift>;
  }

  String gift() {
    double result = 0;
    for (var gift in gifts) {
      double points = double.parse(gift.points);
      double rate = double.parse(gift.rate);
      double price = points / rate;
      result += price;
    }
    return result.toString();
  }

  int get selectedBottomBarScreen => _selectedBottomBarScreen.value;
}

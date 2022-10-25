import 'package:get/get.dart';

import '../storage/local/prefs/app_settings_prefs.dart';

class LanguageChangeNotifierGetX extends GetxController{

  RxString _languageCode = AppSettingsPrefs().langCode.obs;

  static LanguageChangeNotifierGetX get to => Get.find();


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> changeLanguage({required String languageCode}) async{
    this._languageCode.value = languageCode;
    await AppSettingsPrefs().saveLanguage(language: languageCode);
    _languageCode.refresh();
  }

  String get languageCode => _languageCode.value;
}
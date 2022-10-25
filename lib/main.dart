import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subrate/controllers/getX/mission_getX_controller.dart';

import 'app_localizations.dart';
import 'controllers/getX/language_change_notifier_getX.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'controllers/storage/local/prefs/app_settings_prefs.dart';
import 'controllers/storage/local/prefs/user_preference_controller.dart';
import 'core/material_app_routes.dart';
import 'core/mission_distributor_localizations.dart';
import 'core/mission_distributor_theme.dart';
import 'core/res/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingsPrefs().initPreferences();
  await UserPreferenceController().initSharedPreferences();
  Get.put(MissionGetXController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LanguageChangeNotifierGetX _languageChangeNotifierGetX =
      Get.put(LanguageChangeNotifierGetX());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: MissionDistributorLocalizations.languages,
        locale: Locale(_languageChangeNotifierGetX.languageCode),
        title: 'subrate',
        theme: MissionDistributorTheme.missionDistributorTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.launchScreen,
        routes: MaterialAppRoutes.routes(),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subrate/controllers/getX/mission_getX_controller.dart';

import 'controllers/getX/language_change_notifier_getX.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'controllers/storage/local/prefs/app_settings_prefs.dart';
import 'controllers/storage/local/prefs/user_preference_controller.dart';
import 'core/material_app_routes.dart';
import 'core/mission_distributor_localizations.dart';
import 'core/mission_distributor_theme.dart';
import 'core/res/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'models/notification/notification_services.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppSettingsPrefs().initPreferences();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
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

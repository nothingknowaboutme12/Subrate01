import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subrate/controllers/getX/mission_getX_controller.dart';
import 'package:subrate/views/app/notification_screen.dart';
import 'package:subrate/views/app/profile_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controllers/getX/app_getX_controller.dart';
import '../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../core/res/assets.dart';
import '../../models/app/bottom_navigation_bar_screen.dart';
import '../../models/notification/notification_services.dart';
import 'Lesson/lesson_screen.dart';
import 'task/main_screen.dart';
import 'task/task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double width;
  late double height;

  final AppGetXController _appGetXController = Get.put(AppGetXController());
  final MissionGetXController _missionGetXController =
      Get.put(MissionGetXController());
  final List<BottomNavigationBarScreen> _bnScreens =
      <BottomNavigationBarScreen>[
    BottomNavigationBarScreen(
      widget: const MainScreen(),
      title: '',
      icon: const Icon(Icons.home_filled),
    ),
    BottomNavigationBarScreen(
        widget: LessonScreen(), title: '', icon: Icon(Icons.play_lesson)),
    BottomNavigationBarScreen(
      widget: const TaskScreen(),
      title: '',
      icon: Image.asset(
        Assets.logoBottomNavBarIcon,
        color: Colors.grey.shade600,
        filterQuality: FilterQuality.high,
      ),
    ),
    BottomNavigationBarScreen(
      widget: const ProfileScreen(),
      title: '',
      icon: CircleAvatar(
        radius: 16,
        backgroundImage: UserPreferenceController().userInformation.avatar != ''
            ? NetworkImage(
                UserPreferenceController().userInformation.avatar ?? '',
              )
            : AssetImage(
                Assets.profileImage,
              ) as ImageProvider,
      ),
    ),
  ];

  @override
  void initState() {
    _missionGetXController.read();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Obx(() => Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: OrientationBuilder(
            builder: (context, orientation) =>
                _bnScreens[_appGetXController.selectedBottomBarScreen].widget,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.grey.shade300,
              )
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: BottomNavigationBar(
                // selectedItemColor: Colors.red,
                backgroundColor: Colors.white,
                // unselectedLabelStyle: TextStyle(color: Colors.grey),
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                currentIndex: _appGetXController.selectedBottomBarScreen,
                onTap: (value) {
                  _appGetXController.changeSelectedBottomBarScreen(
                      selectedIndex: value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: _bnScreens[0].icon,
                    label: AppLocalizations.of(context)!.home,
                  ),
                  BottomNavigationBarItem(
                    icon: _bnScreens[1].icon,
                    label: AppLocalizations.of(context)!.lesson,
                  ),
                  BottomNavigationBarItem(
                    icon: _bnScreens[2].icon,
                    activeIcon: Image.asset(
                      Assets.logoBottomNavBarActiveIcon,
                    ),
                    label: AppLocalizations.of(context)!.task,
                  ),
                  // BottomNavigationBarItem(
                  //     icon: _bnScreens[3].icon, label: "Notification"),
                  BottomNavigationBarItem(
                    icon: _bnScreens[3].icon,
                    label: AppLocalizations.of(context)!.profile,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

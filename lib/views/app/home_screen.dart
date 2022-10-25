import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subrate/controllers/getX/mission_getX_controller.dart';
import 'package:subrate/views/app/profile_screen.dart';

import '../../app_localizations.dart';
import '../../controllers/getX/app_getX_controller.dart';
import '../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../core/res/assets.dart';
import '../../models/app/bottom_navigation_bar_screen.dart';
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
      // CircleAvatar(
      //   radius: 15,
      //   backgroundImage: AssetImage(
      //     Assets.profileImage,
      //     // color: Colors.grey.shade600,
      //     // filterQuality: FilterQuality.high,
      //   ),
      // ),
    ),
  ];

  @override
  void initState() {
    Get.put(MissionGetXController());
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
              borderRadius: BorderRadius.circular(30),
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
                    label: "Lesson",
                  ),
                  BottomNavigationBarItem(
                    icon: _bnScreens[2].icon,
                    activeIcon: Image.asset(
                      Assets.logoBottomNavBarActiveIcon,
                    ),
                    label: "Task",
                  ),
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

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:subrate/models/Lesson/lesson.dart';
import 'package:subrate/views/app/task/main_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controllers/getX/app_getX_controller.dart';
import '../../../../controllers/getX/mission_getX_controller.dart';
import '../../../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../../../core/res/assets.dart';
import '../../../../core/res/mission_distributor_colors.dart';
import '../../../../core/res/routes.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/widgets/MyElevatedButton.dart';
import '../../../../models/Task/task.dart';

import '../../../../models/network_link.dart';
import 'lesson_detail_screen.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({Key? key}) : super(key: key);

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> with Helpers {
  late double width;
  late double height;
  String done = '0';
  String todo = '0';

  final MissionGetXController _missionGetXController =
      Get.put(MissionGetXController());
  List<Lesson> lessons = [];
  // bool _selectedDoneMissions = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool connection = false;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    testConnection();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      showSnackBar(
          context: context,
          message: 'Couldn\'t check connectivity status',
          error: true);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (mounted)
      setState(() {
        _connectionStatus = result;
      });
  }

  testConnection() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      connection = true;
    } else {
      connection = false;
    }
  }

  bool isProgress = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    AppLocalizations localizations = AppLocalizations.of(context)!;
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (mounted) {
          setState(() {
            connection;
          });
        }
      },
    );
    return Scaffold(
      backgroundColor: MissionDistributorColors.scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          localizations.lesson,
          // "Lesson",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.account_balance_wallet_rounded,
            color: MissionDistributorColors.primaryColor,
            size: 26,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.walletScreen);
          },
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 16,
              backgroundImage:
                  (UserPreferenceController().userInformation.avatar != ''
                      ? (_connectionStatus.name != 'none' || connection)
                          ? NetworkImage(UserPreferenceController()
                                  .userInformation
                                  .avatar ??
                              '')
                          : AssetImage(Assets.profileImage)
                      : AssetImage(Assets.profileImage)) as ImageProvider,
            ),
            onPressed: () {
              AppGetXController.to
                  .changeSelectedBottomBarScreen(selectedIndex: 3);
            },
          ),
          SizedBox(width: width / 70),
        ],
      ),
      body: RefreshIndicator(
        color: MissionDistributorColors.primaryColor,
        backgroundColor: MissionDistributorColors.secondaryColor,
        onRefresh: () async {
          await MissionGetXController.to.read();
        },
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
            } else {}
            return
                // Obx(
                // () =>
                ListView(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(
                    start: width / 20,
                    end: width / 20,
                    top: height / 50,
                    bottom: height / 70,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height / 29),
                      SizedBox(
                        height: height / 1.395,
                        child: GetX<MissionGetXController>(
                          builder: (controller) {
                            Future.delayed(
                              Duration(seconds: 5),
                              () {
                                isProgress = true;
                                if (mounted)
                                  setState(() {
                                    isProgress = true;
                                  });
                              },
                            );
                            List<Lesson> _controller = controller.lessons.value;
                            if (_controller.isNotEmpty) {
                              return ListView.builder(
                                itemCount: _controller.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LessonDetailScreen(
                                            lessson: _controller[index],
                                          ),
                                        ),
                                      );
                                      //
                                    },
                                    child: Container(
                                      margin: EdgeInsetsDirectional.only(
                                        top: height / 70,
                                      ),
                                      height: height / 5.5,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MissionDistributorColors
                                            .primaryColor,
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              height: height / 4,
                                              width: double.infinity,
                                              child: _controller[index]
                                                      .image!
                                                      .isNotEmpty
                                                  ? !_controller[index]
                                                          .image!
                                                          .contains('http')
                                                      ? Image.asset(
                                                          Assets.missionImage,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Image.network(
                                                          _controller[index]
                                                              .image
                                                              .toString(),
                                                          // NetworkLink(
                                                          //         link: _controller[
                                                          //                 index]
                                                          //             .image
                                                          //             .toString())
                                                          //     .link,
                                                          fit: BoxFit.fill,
                                                        )
                                                  : Image.asset(
                                                      Assets.missionImage,
                                                      fit: BoxFit.fill,
                                                    ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: AlignmentDirectional
                                                    .topCenter,
                                                end: AlignmentDirectional
                                                    .bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.5),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          Container(
                                            alignment: AlignmentDirectional
                                                .bottomStart,
                                            padding: EdgeInsetsDirectional.only(
                                              start: width / 20,
                                              end: width / 20,
                                              top: height / 160,
                                              bottom: height / 70,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                _controller[index].title ??
                                                    localizations.no_has_title,
                                                // "No title",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (_connectionStatus.name == 'none') {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      localizations.no_internet,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (_controller.isEmpty) {
                              return Center(
                                child: Visibility(
                                  visible: isProgress,
                                  replacement:
                                      const CircularProgressIndicator(),
                                  child: Center(
                                    child: Text(localizations.no_lesson),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(localizations.no_lesson),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                // )
                ;
          },
        ),
      ),
    );
  }
}

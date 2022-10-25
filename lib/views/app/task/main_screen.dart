import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../app_localizations.dart';
import '../../../controllers/getX/app_getX_controller.dart';
import '../../../controllers/getX/mission_getX_controller.dart';
import '../../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../../core/res/assets.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/res/routes.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/widgets/MyElevatedButton.dart';

import '../../../models/Task/task.dart';
import '../../../models/network_link.dart';
import 'task_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with Helpers {
  late double width;
  late double height;
  String done = '0';
  String todo = '0';

  final MissionGetXController _missionGetXController =
      Get.put(MissionGetXController());

  List<Task> tasks = [];

  bool _selectedDoneMissions = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool connection = false;
  // data() async {
  //   await MissionGetXController.to.read();
  //   await AppGetXController.to.readGifts();
  //   await AppGetXController.to.readRank();
  // }

  @override
  void initState() {
    super.initState();
    // data();
    testConnection();
    initConnectivity();
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MissionGetXController.to.read();

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (mounted)
          // setState(() {
          connection;
        // });
      },
    );
    return Scaffold(
      backgroundColor: MissionDistributorColors.scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.home,
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
                  .changeSelectedBottomBarScreen(selectedIndex: 2);
            },
          ),
          SizedBox(width: width / 70),
        ],
      ),
      body: RefreshIndicator(
        color: MissionDistributorColors.primaryColor,
        backgroundColor: MissionDistributorColors.secondaryColor,
        onRefresh: () async {
          MissionGetXController.to.read();
          AppGetXController.to.readGifts();
          AppGetXController.to.readRank();
        },
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
            } else {}
            return Obx(
              () => ListView(
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
                        Text(
                          AppLocalizations.of(context)!.wallet,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.wallet_desc,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(height: height / 29),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Navigator.pushNamed(
                                            context, Routes.rankScreen);
                                      });
                                    },
                                    child: Container(
                                      height: height / 11.4,
                                      decoration: BoxDecoration(
                                        color:
                                            MissionDistributorColors.cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                Assets.totalEarningsIcon,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .total_earnings,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(end: width / 50),
                                                  child: const Divider(
                                                    color: Colors.white,
                                                    thickness: 3,
                                                  ),
                                                ),
                                                Text(
                                                  '${_missionGetXController.money.value}\$',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width / 60,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Navigator.pushNamed(
                                            context, Routes.rankScreen);
                                      });
                                    },
                                    child: Container(
                                      height: height / 11.4,
                                      decoration: BoxDecoration(
                                        color: MissionDistributorColors
                                            .primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                Assets.totalCoinsIcon,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .total_coins,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(end: width / 50),
                                                  child: const Divider(
                                                    color: Colors.white,
                                                    thickness: 3,
                                                  ),
                                                ),
                                                Text(
                                                  '${_missionGetXController.points.value}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 100,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Navigator.pushNamed(
                                            context, Routes.rankScreen);
                                      });
                                    },
                                    child: Container(
                                      height: height / 11.4,
                                      decoration: BoxDecoration(
                                        color: MissionDistributorColors
                                            .primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                Assets.overallAchievementIcon,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .overall_achievement,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    end: width / 50,
                                                  ),
                                                  child: const Divider(
                                                    color: Colors.white,
                                                    thickness: 3,
                                                  ),
                                                ),
                                                Text(
                                                  'missions ${_missionGetXController.missionsCount.value.completedMissionsCount}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width / 60,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Navigator.pushNamed(
                                            context, Routes.rankScreen);
                                      });
                                    },
                                    child: Container(
                                      height: height / 11.4,
                                      decoration: BoxDecoration(
                                        color:
                                            MissionDistributorColors.cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                Assets.remainingMissionsIcon,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .remaining_missions,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    end: width / 50,
                                                  ),
                                                  child: const Divider(
                                                    color: Colors.white,
                                                    thickness: 3,
                                                  ),
                                                ),
                                                Text(
                                                  'mission ${_missionGetXController.missionsCount.value.remainingMissionsCount}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: height / 100),
                        Text(
                          "Today Tasks",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height / 100),
                        SizedBox(
                          height: height / 2.12,
                          child: GetX<MissionGetXController>(
                            builder: (controller) {
                              Future.delayed(
                                const Duration(seconds: 5),
                                () {
                                  isProgress = true;
                                  if (mounted) {
                                    setState(() {
                                      isProgress = true;
                                    });
                                  }
                                },
                              );
                              List<Task> _controller =
                                  controller.remainingMissions;
                              if (_controller.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: _controller.length,
                                  itemBuilder: (context, index) {
                                    print(_controller[index].images);
                                    return GestureDetector(
                                      onTap: () {
                                        if (!_selectedDoneMissions) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MissionDetailsScreen(
                                                mission: _controller[index],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsetsDirectional.only(
                                          top: height / 70,
                                        ),
                                        height: height / 5.5,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                      BorderRadius.circular(
                                                    30,
                                                  ),
                                                ),
                                                height: height / 4.9,
                                                width: double.infinity,
                                                child: _controller[index]
                                                        .images
                                                        .isNotEmpty
                                                    ? _controller[index]
                                                            .images[0]
                                                            .name
                                                            .contains('http')
                                                        ? Image.asset(
                                                            Assets.missionImage,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.network(
                                                            NetworkLink(
                                                              link: _controller[
                                                                      index]
                                                                  .images[0]
                                                                  .name,
                                                            ).link,
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
                                                    Colors.black
                                                        .withOpacity(0.5),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            Container(
                                              alignment: AlignmentDirectional
                                                  .bottomStart,
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                start: width / 20,
                                                end: width / 20,
                                                top: height / 160,
                                                bottom: height / 80,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: Text(
                                                _controller[index].title ??
                                                    AppLocalizations.of(
                                                            context)!
                                                        .no_has_title,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
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
                                  children: const [
                                    Center(
                                      child: Text(
                                        'Not Have Connection, Please Check Your Internet Connection',
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
                                    child: const Center(
                                      child: Text('Not has Any Mission'),
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: Text('Not has Any Mission'),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

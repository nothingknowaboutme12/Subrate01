import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app_localizations.dart';
import '../../../controllers/getX/app_getX_controller.dart';
import '../../../controllers/getX/mission_getX_controller.dart';
import '../../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../../core/res/assets.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/res/routes.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({Key? key}) : super(key: key);

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  late double width;
  late double height;

  TextStyle textStyle = const TextStyle(
    color: MissionDistributorColors.primaryColor,
    fontSize: 15,
  );
  double buttonHeight = 803 / 23.74;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool connection = false;
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MissionDistributorColors.scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.ranking,
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
            Icons.arrow_back_ios,
            color: MissionDistributorColors.primaryColor,
            size: 26,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            buttonHeight = height / 23.74;
          } else {
            buttonHeight = height / 8;
          }
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: width / 15.28, vertical: height / 37),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height / 40),
                    Column(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.homeScreen);
                                });
                              },
                              child: Container(
                                height: height / 10,
                                decoration: BoxDecoration(
                                  color: MissionDistributorColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          Assets.overallAchievementIcon,
                                          width: width / 12,
                                          height: height / 20,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .overall_achievement,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            ' ${MissionGetXController.to.missionsCount.value.completedMissionsCount}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height / 60,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.homeScreen);
                                });
                              },
                              child: Container(
                                height: height / 10,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          Assets.remainingMissionsIcon,
                                          width: width / 12,
                                          height: height / 22,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .remaining_missions,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            ' ${MissionGetXController.to.missionsCount.value.remainingMissionsCount}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height / 46),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.homeScreen);
                                });
                              },
                              child: Container(
                                height: height / 10,
                                decoration: BoxDecoration(
                                  color: MissionDistributorColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          Assets.totalCoinsIcon,
                                          width: width / 12,
                                          height: height / 22,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.coins,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '${MissionGetXController.to.points.value}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height / 60,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.homeScreen);
                                });
                              },
                              child: Container(
                                height: height / 10,
                                decoration: BoxDecoration(
                                  color: MissionDistributorColors.cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          Assets.totalEarningsIcon,
                                          width: width / 12,
                                          height: height / 22,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .wallet,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '${MissionGetXController.to.money.value}\$',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height / 60,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.homeScreen);
                                });
                              },
                              child: Container(
                                height: height / 10,
                                decoration: BoxDecoration(
                                  color: MissionDistributorColors.thirdColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          Assets.giftIcon,
                                          width: width / 12,
                                          height: height / 22,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.gifts,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '${AppGetXController.to.gift()}\$',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height / 50,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 15),
                          child: const Divider(
                            color: MissionDistributorColors.primaryColor,
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          height: height / 50,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: height / 6,
                            decoration: BoxDecoration(
                              color: MissionDistributorColors.thirdColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsetsDirectional.only(
                                        start: width / 30, top: height / 60),
                                    child: Text(
                                      AppLocalizations.of(context)!.your_rank,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              Assets.overallAchievementIcon,
                                              width: width / 12,
                                              height: height / 20,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: CircleAvatar(
                                                  radius: 16,
                                                  child: Assets.profileImage !=
                                                          ''
                                                      ? Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child: UserPreferenceController()
                                                                        .userInformation
                                                                        .avatar !=
                                                                    ''
                                                                ? !(_connectionStatus.name !=
                                                                            'none' ||
                                                                        connection)
                                                                    ? const Icon(
                                                                        Icons
                                                                            .person)
                                                                    : Image
                                                                        .network(
                                                                        UserPreferenceController().userInformation.avatar ??
                                                                            '',
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                        width:
                                                                            width /
                                                                                8,
                                                                        height:
                                                                            height /
                                                                                15,
                                                                      )
                                                                : Image.asset(
                                                                    Assets
                                                                        .profileImage,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    width: 60,
                                                                    height: 60,
                                                                  ),
                                                          ),
                                                        )
                                                      : Container(),
                                                ),
                                                onPressed: () {
                                                  AppGetXController.to
                                                      .changeSelectedBottomBarScreen(
                                                          selectedIndex: 2);
                                                },
                                              ),
                                              Text(
                                                UserPreferenceController()
                                                    .userInformation
                                                    .name
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                '${AppGetXController.to.rank}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 0),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //   height: height / 3.67,
                    //   decoration: BoxDecoration(
                    //     color: MissionDistributorColors.primaryColor,
                    //     borderRadius: BorderRadius.circular(41),
                    //   ),
                    //   alignment: Alignment.center,
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     padding: EdgeInsets.symmetric(
                    //       vertical: height / 23.7,
                    //       horizontal: width / 17.12,
                    //     ),
                    //     child: Stack(
                    //       children: [
                    //         Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   children: [
                    //                     const Text(
                    //                       'Done Mission',
                    //                       style: TextStyle(
                    //                         color: Colors.white,
                    //                         fontSize: 12,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 2),
                    //                     Container(
                    //                       padding: const EdgeInsets.all(4),
                    //                       height: height / 24,
                    //                       alignment: Alignment.center,
                    //                       child: Text(
                    //                         MissionGetXController
                    //                             .to
                    //                             .missionsCount
                    //                             .value
                    //                             .completedMissionsCount
                    //                             .toString(),
                    //                         style: const TextStyle(
                    //                             fontSize: 20,
                    //                             color: Color(0xffF3CC30)),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Column(
                    //                   children: [
                    //                     const Text(
                    //                       'Coins',
                    //                       style: TextStyle(
                    //                         color: Colors.white,
                    //                         fontSize: 12,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 2),
                    //                     Container(
                    //                       padding: const EdgeInsets.all(4),
                    //                       height: height / 24,
                    //                       alignment: Alignment.center,
                    //                       child: Text(
                    //                         MissionGetXController.to.points
                    //                             .toString(),
                    //                         style: const TextStyle(
                    //                             fontSize: 20,
                    //                             color: Color(0xffF3CC30)),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   children: [
                    //                     const Text(
                    //                       'Gift',
                    //                       style: TextStyle(
                    //                         color: Colors.white,
                    //                         fontSize: 12,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 2),
                    //                     Container(
                    //                       padding: const EdgeInsets.all(4),
                    //                       height: height / 24,
                    //                       alignment: Alignment.center,
                    //                       child: Text(
                    //                         '${AppGetXController.to.gift()}\$',
                    //                         style: const TextStyle(
                    //                             fontSize: 20,
                    //                             color: Color(0xffF3CC30)),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Column(
                    //                   children: [
                    //                     const Text(
                    //                       'Wallet',
                    //                       style: TextStyle(
                    //                         color: Colors.white,
                    //                         fontSize: 12,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 2),
                    //                     Container(
                    //                       padding: const EdgeInsets.all(4),
                    //                       height: height / 24,
                    //                       alignment: Alignment.center,
                    //                       child: Text(
                    //                         '${MissionGetXController.to.money.toString()}\$',
                    //                         style: const TextStyle(
                    //                             fontSize: 20,
                    //                             color: Color(0xffF3CC30)),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         Align(
                    //           alignment: Alignment.center,
                    //           child: Container(
                    //             height: height / 11.2,
                    //             width: width / 5.2,
                    //             decoration: BoxDecoration(
                    //               color: Colors.transparent,
                    //               shape: BoxShape.circle,
                    //               border: Border.all(
                    //                 color: Colors.white,
                    //                 width: 5,
                    //               ),
                    //             ),
                    //             alignment: Alignment.center,
                    //             child: const Text(
                    //               '46%',
                    //               style: TextStyle(
                    //                 fontSize: 27,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.white,
                    //               ),
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: height / 20),
                    // const Text(
                    //   'Please wait!',
                    //   style: TextStyle(
                    //     fontSize: 22,
                    //     fontWeight: FontWeight.bold,
                    //     color: MissionDistributorColors.primaryColor,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: width / 30),
                    //   child: const Text(
                    //     'Lorem Ipsum is simply dummy text of the printing and typesetting Industry.',
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       color: MissionDistributorColors.primaryColor,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // SizedBox(height: height / 20),
                    // MyElevatedButton(
                    //   onPressed: () async {
                    //     Navigator.pushReplacementNamed(context, Routes.doneScreen);
                    //   },
                    //   child: const Text(
                    //     'DONE',
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w300,
                    //     ),
                    //   ),
                    //   height: buttonHeight,
                    //   width: width / 1.27,
                    //   borderRadiusGeometry: BorderRadius.circular(20),
                    //   gradient: const LinearGradient(
                    //     colors: [
                    //       MissionDistributorColors.primaryColor,
                    //       MissionDistributorColors.primaryColor,
                    //     ],
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

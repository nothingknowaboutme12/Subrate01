import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../app_localizations.dart';
import '../controllers/getX/connection_getX_controller.dart';
import '../controllers/storage/local/prefs/user_preference_controller.dart';
import '../core/res/assets.dart';

import '../core/res/mission_distributor_colors.dart';
import '../core/res/routes.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  late double width;
  late double height;
  ConnectionGetXController connectionGetXController =
      Get.put(ConnectionGetXController());

  ConnectivityResult _connectionStatus = ConnectivityResult.values[1];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        String route = (UserPreferenceController().loggedIn)
            ? Routes.homeScreen
            : Routes.authenticationScreen;
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    // setState(() {
    _connectionStatus = result;
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _updateConnectionStatus;
  }

  double imageHeight = 803.6363636363636 / 6.3;
  double imageWidth = 392.72727272727275 / 2.8337;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        imageHeight = height / 4.78;
        imageWidth = width / 2.8337;
      } else {
        imageHeight = height / 3;
        imageWidth = width;
      }
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height / 2.7),
                Image.asset(
                  Assets.logo,
                  filterQuality: FilterQuality.high,
                  width: imageWidth,
                  height: imageHeight,
                ),
                Text(
                  AppLocalizations.of(context)!.app_name,
                  style: const TextStyle(
                    fontSize: 32,
                    color: MissionDistributorColors.primaryColor,
                  ),
                ),
                SizedBox(height: height / 10),
                Image.asset(
                  Assets.launchScreenImage,
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

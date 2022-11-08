import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:subrate/controllers/getX/app_getX_controller.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controllers/getX/language_change_notifier_getX.dart';
import '../../controllers/getX/mission_getX_controller.dart';
import '../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../controllers/storage/network/api/controllers/auth_api_controller.dart';
import '../../core/res/assets.dart';
import '../../core/res/mission_distributor_colors.dart';
import '../../core/res/routes.dart';
import '../../core/utils/helpers.dart';
import '../../core/widgets/MyElevatedButton.dart';
import '../auth/kyc_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  late double width;
  late double height;
  double buttonSize = 803.6363636363636 / 20;
  final TextStyle _textStyle = const TextStyle(
    fontSize: 21,
    color: MissionDistributorColors.primaryColor,
    fontWeight: FontWeight.w300,
  );

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late bool connection = false;

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
        if (result.name != 'none') {
          connection = true;
        }
        print(_connectionStatus.name);
      });
  }

  double itemSize = 800 / 6;
  double? _progressValue = 0;

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
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.editProfileScreen);
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            itemSize = height / 15;
          } else {
            itemSize = height / 6;
          }
          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  Assets.bgMaskImage,
                  fit: BoxFit.cover,
                ),
              ),
              Image.asset(
                Assets.maskImage,
              ),
              ListView(
                children: [
                  SizedBox(height: height / 14),
                  Container(
                    height: height / 3.8,
                    margin: EdgeInsets.symmetric(horizontal: width / 9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: width / 20),
                      alignment: Alignment.center,
                      child: ListView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: height / 80),
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: (UserPreferenceController()
                                                .userInformation
                                                .avatar !=
                                            ''
                                        ? !(_connectionStatus.name != 'none' ||
                                                connection)
                                            ? AssetImage(Assets.profileImage)
                                            : NetworkImage(
                                                UserPreferenceController()
                                                        .userInformation
                                                        .avatar ??
                                                    '')
                                        : AssetImage(Assets.profileImage))
                                    as ImageProvider,
                              ),
                              SizedBox(height: height / 200),
                              Text(
                                UserPreferenceController().userInformation.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: height / 150),
                              Text(
                                UserPreferenceController()
                                    .userInformation
                                    .email,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: height / 60),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              width: width / 10,
                                              height: height / 22,
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: MissionDistributorColors
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Image.asset(
                                                Assets.totalEarningsIcon,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: width / 40),
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
                                                    color:
                                                        MissionDistributorColors
                                                            .primaryColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(end: width / 50),
                                                  child: const Divider(
                                                    color:
                                                        MissionDistributorColors
                                                            .primaryColor,
                                                    thickness: 2,
                                                  ),
                                                ),
                                                Text(
                                                  '${MissionGetXController.to.money.value}\$',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        MissionDistributorColors
                                                            .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              width: width / 10,
                                              height: height / 22,
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: MissionDistributorColors
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Image.asset(
                                                Assets.totalCoinsIcon,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: width / 40),
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
                                                    color:
                                                        MissionDistributorColors
                                                            .primaryColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(end: width / 50),
                                                  child: const Divider(
                                                    color:
                                                        MissionDistributorColors
                                                            .primaryColor,
                                                    thickness: 2,
                                                  ),
                                                ),
                                                Text(
                                                  '${MissionGetXController.to.points.value}\$',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        MissionDistributorColors
                                                            .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width / 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: height / 30),
                        MyElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.editProfileScreen);
                          },
                          child: SizedBox(
                            height: height / 12.86,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: width / 20,
                                  color: MissionDistributorColors.primaryColor,
                                ),
                                SizedBox(width: width / 30),
                                Text(
                                  AppLocalizations.of(context)!
                                      .profile_information,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: width / 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height / 80),
                        MyElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.appLangScreen);
                          },
                          child: SizedBox(
                            height: height / 12.86,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.translate,
                                  size: width / 20,
                                  color: MissionDistributorColors.primaryColor,
                                ),
                                SizedBox(width: width / 30),
                                Text(
                                  AppLocalizations.of(context)!
                                      .application_language,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: width / 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height / 80),
                        MyElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.changePasswordScreen);
                          },
                          child: SizedBox(
                            height: height / 12.86,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.lock,
                                  size: width / 20,
                                  color: MissionDistributorColors.primaryColor,
                                ),
                                SizedBox(width: width / 30),
                                Text(
                                  AppLocalizations.of(context)!.change_password,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: width / 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height / 80),
                        MyElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.rankScreen);
                          },
                          child: SizedBox(
                            height: height / 12.86,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.workspace_premium_sharp,
                                  size: width / 20,
                                  color: MissionDistributorColors.primaryColor,
                                ),
                                SizedBox(width: width / 30),
                                Text(
                                  AppLocalizations.of(context)!.ranking,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: width / 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyElevatedButton(
                    height: buttonSize,
                    width: width,
                    borderRadiusGeometry: BorderRadius.circular(5),
                    marginHorizontal: width / 19,
                    gradient: const LinearGradient(
                      colors: [
                        MissionDistributorColors.primaryColor,
                        MissionDistributorColors.primaryColor
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KycScreen(isSignUP: false),
                          ));
                    },
                    child: Text(AppLocalizations.of(context)!.kyc_valid),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width / 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: height / 30),
                        MyElevatedButton(
                          onPressed: () async => await performLogout(),
                          child: SizedBox(
                            height: height / 12.86,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: width / 20,
                                  color: MissionDistributorColors.primaryColor,
                                ),
                                SizedBox(width: width / 30),
                                Text(
                                  AppLocalizations.of(context)!.logout,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: width / 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future performLogout() async {
    await testConnection();
    if (connection) {
      showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: CircularProgressIndicator(
                value: _progressValue,
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(height: height / 4),
            Center(
              child: Container(
                height: height / 7,
                margin: EdgeInsets.symmetric(
                  horizontal: width / 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.confirm_logout,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyElevatedButton(
                          width: width / 2.5,
                          borderRadiusGeometry: BorderRadius.circular(5),
                          gradient: const LinearGradient(colors: [
                            MissionDistributorColors.primaryColor,
                            MissionDistributorColors.primaryColor,
                          ]),
                          onPressed: () async {
                            await logout();
                            AppGetXController.to.changeSelectedBottomBarScreen(
                                selectedIndex: 0);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.logout,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                        MyElevatedButton(
                          width: width / 2.5,
                          borderRadiusGeometry: BorderRadius.circular(5),
                          gradient: const LinearGradient(colors: [
                            Colors.grey,
                            Colors.grey,
                          ]),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      showSnackBar(
          context: context,
          message: 'Please check your connection!',
          error: true);
    }
  }

  Future logout() async {
    _changeProgressValue(value: null);
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    bool status = await AuthApiController().logout(context);
    _changeProgressValue(value: status ? 1 : 0);

    if (status) {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.logout_successfully);
      UserPreferenceController().logout();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.authenticationScreen,
        (route) => false,
      );
    } else {
      Navigator.pop(context);
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.logout_failed,
          error: true);
    }
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }
}

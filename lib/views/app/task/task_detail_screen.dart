import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subrate/controllers/getX/app_getX_controller.dart';
import 'package:subrate/controllers/storage/local/prefs/user_preference_controller.dart';
import 'package:subrate/core/res/routes.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../../app_localizations.dart';
import '../../../controllers/getX/do_mission_getX_controller.dart';
import '../../../controllers/getX/mission_getX_controller.dart';
import '../../../core/res/assets.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/widgets/MyElevatedButton.dart';

import '../../../models/Task/do_task.dart';
import '../../../models/Task/task.dart';
import '../../../models/network_link.dart';
import '../../../models/url_link.dart';
import 'task_completed_screen.dart';

// ignore: must_be_immutable
class MissionDetailsScreen extends StatefulWidget {
  Task mission;

  MissionDetailsScreen({required this.mission, Key? key}) : super(key: key);

  @override
  State<MissionDetailsScreen> createState() => _MissionDetailsScreenState();
}

class _MissionDetailsScreenState extends State<MissionDetailsScreen>
    with Helpers {
  late double width;
  late double height;
  double buttonHeight = 803 / 23.74;

  Uri _url = Uri.parse('https://flutter.dev');
  bool isGoButtonVisible = true;
  DoMissionGetXController doMissionGetXController =
      Get.put(DoMissionGetXController());

  Future<File>? imageFile;
  File? _image;
  XFile? pickedFile;
  String result = '';
  ImagePicker? imagePicker;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool connection = false;

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
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    imagePicker = ImagePicker();
  }

  double? _progressValue = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    _url = Uri.parse(widget.mission.link);
    print("Image url${widget.mission.images.first.name}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Task Detail",
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
      backgroundColor: MissionDistributorColors.scaffoldBackground,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            buttonHeight = height / 23.74;
          } else {
            buttonHeight = height / 8;
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: width / 20),
            alignment: AlignmentDirectional.center,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(
                    top: height / 70,
                  ),
                  height: height / 4.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MissionDistributorColors.primaryColor,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          height: height / 4.5,
                          width: double.infinity,
                          child: widget.mission.images.isNotEmpty
                              ? !widget.mission.images[0].name.contains('http')
                                  ? Image.asset(
                                      Assets.missionImage,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      widget.mission.images[0].name,
                                      // NetworkLink(
                                      //   link: widget.mission.images[0].name,
                                      // ).link,
                                      // fit: BoxFit.fill,
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
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.bottomStart,
                        padding: EdgeInsetsDirectional.only(
                          start: width / 20,
                          end: width / 20,
                          top: height / 160,
                          bottom: height / 80,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          widget.mission.title ??
                              AppLocalizations.of(context)!.no_has_title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height / 100),
                SingleChildScrollView(
                  child: Text(
                    widget.mission.description ?? 'No has description',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: height / 20),
                Container(
                  margin: EdgeInsetsDirectional.only(start: width / 15),
                  padding: EdgeInsetsDirectional.only(
                      top: height / 50,
                      start: width / 15,
                      bottom: height / 50,
                      end: width / 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How to get the job done',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: MissionDistributorColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: height / 100),
                      Container(
                        child: widget.mission.steps.isNotEmpty
                            ? SizedBox(
                                height: height / 5,
                                child: ListView.builder(
                                  itemCount: widget.mission.steps.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsetsDirectional.only(
                                        top: height / 100,
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: width / 19.45,
                                              height: height / 51,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: MissionDistributorColors
                                                    .primaryColor,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                (index + 1).toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width / 100),
                                            Text(
                                              // index == 0 ?
                                              widget.mission.steps[index],
                                              // : index == 1
                                              //     ? widget
                                              //         .mission.steps[index]
                                              //     : widget
                                              //         .mission.steps[index],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: MissionDistributorColors
                                                    .primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(
                                height: height / 7,
                                child: const Center(
                                  child: Text(
                                    'No has steps',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          MissionDistributorColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: height / 50),
                      Visibility(
                        visible: isGoButtonVisible,
                        child: MyElevatedButton(
                          onPressed: () async {
                            print(widget.mission.link);
                            await _launchUrl(
                                widget.mission.link.contains('https://') ||
                                        widget.mission.link.contains('http://')
                                    ? widget.mission.link
                                    : UrlLink(link: widget.mission.link).link);
                            setState(() {
                              isGoButtonVisible = false;
                            });
                            // Navigator.pushNamed(context, Routes.signUpScreen);
                          },
                          child: const Text(
                            'GO',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          height: buttonHeight,
                          width: width / 1.27,
                          borderRadiusGeometry: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              MissionDistributorColors.primaryColor,
                              MissionDistributorColors.primaryColor,
                            ],
                          ),
                        ),
                        replacement: MyElevatedButton(
                          onPressed: () async {
                            await selectPhotoFromGallery();
                            if (_image != null) {}
                          },
                          child: const Text(
                            'Submit screenshot',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          height: buttonHeight,
                          width: width / 1.27,
                          borderRadiusGeometry: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              MissionDistributorColors.primaryColor,
                              MissionDistributorColors.primaryColor,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> selectPhotoFromGallery() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    setState(() {
      this.pickedFile = pickedFile;
    });
    storeMission(image: _image!.path);
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }

  Future<void> storeMission({required String image}) async {
    _changeProgressValue(value: null);
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          value: _progressValue,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
    String money = MissionGetXController.to.money.value;
    await initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (_connectionStatus.name != 'none') {
      doMissionGetXController.upload(
        filePath: image,
        doMission: DoTask(
          date: DateTime.now().toString(),
          missionId: widget.mission.id.toString(),
          screenShot: image,
        ),
        imageUploadResponse: ({
          required String message,
          required bool status,
          DoTask? doMission,
        }) {
          _changeProgressValue(value: status ? 1 : 0);
          if (status) {
            showSnackBar(
                message: AppLocalizations.of(context)!.success_do_mission,
                context: context);
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MissionCompleteScreen(
                  money: money.toString(),
                  mission: widget.mission,
                  imageUrl: widget.mission.images.isNotEmpty
                      ? widget.mission.images[0].name
                      : Assets.missionImage,
                ),
              ),
            );
          } else {
            showSnackBar(message: message, context: context, error: true);
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(message),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          }
        },
      );
    } else {
      Navigator.pop(context);
      showSnackBar(
          message: AppLocalizations.of(context)!.no_internet_connection,
          context: context,
          error: true);
    }
    // Navigator.of(context).pop();
  }

  Future<void> _launchUrl(String link) async {
    if (!await launchUrl(Uri.parse(link))) {
      throw 'Could not launch $_url';
    }
  }
}

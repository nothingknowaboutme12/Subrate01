import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:image_picker/image_picker.dart';
import 'package:subrate/controllers/getX/app_getX_controller.dart';
import 'package:subrate/controllers/storage/local/prefs/user_preference_controller.dart';
import 'package:subrate/core/res/routes.dart';
import 'package:subrate/core/widgets/MyElevatedButton.dart';
import 'package:subrate/models/Lesson/LessonTaskController.dart';
import 'package:subrate/models/Lesson/lesson.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controllers/getX/do_mission_getX_controller.dart';
import '../../../core/res/assets.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/utils/helpers.dart';
import '../../../models/Task/task.dart';
import 'Task/lesson_task_detail_screen.dart';
import 'Task/lesson_task_screen.dart';

// ignore: must_be_immutable
class LessonDetailScreen extends StatefulWidget {
  Lesson lessson;
  String? id;
  LessonDetailScreen({required this.lessson, this.id, Key? key})
      : super(key: key);

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> with Helpers {
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
    if (mounted) {
      setState(() {
        connection;
      });
    }
  }

  LessonTaskGetxController? lessonTaskGetxController;
  @override
  Filter? filter;
  void initState() {
    super.initState();
    initConnectivity();
    filter = Filter(widget.id);
    print("here is id into main ${widget.id}");
    lessonTaskGetxController =
        Get.put(LessonTaskGetxController(widget.id.toString()));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    imagePicker = ImagePicker();
  }

  double? _progressValue = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    _url = Uri.parse(widget.lessson.link.toString());
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.lesson_detail,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.grey.shade500,
            size: 26,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
            padding: EdgeInsets.only(top: 2),
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
                          child: widget.lessson.image!.isNotEmpty
                              ? !widget.lessson.image!.contains('http')
                                  ? Image.asset(
                                      Assets.missionImage,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      widget.lessson.image.toString(),
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
                          widget.lessson.title ??
                              AppLocalizations.of(context)!.no_has_title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height / 120),
                Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Text(
                      widget.lessson.title ??
                          AppLocalizations.of(context)!.no_has_title,
                      // textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height / 100),
                Container(
                  height: height * 0.23,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                  // margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey)],
                    border: Border.all(color: Colors.white60),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "General knowledge",
                        style: const TextStyle(
                          color: MissionDistributorColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: MissionDistributorColors.primaryColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.10,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            widget.lessson.description ?? 'No has description',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 50),
                Container(
                  height: height * 0.08,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          widget.lessson.link.toString(),
                        )),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.attach_file_sharp,
                          color: MissionDistributorColors.primaryColor,
                        ),
                        onPressed: () async {
                          final url = ClipboardData(text: widget.lessson.link);
                          await Clipboard.setData(url);
                          await Clipboard.getData('text/plain');
                        }),
                  ),
                ),
                SizedBox(height: height / 50),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(height: height / 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Do the task to get earned",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MissionDistributorColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: height / 30),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: height * 0.060,
                    width: width * 0.35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: widget.id == null
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LessonTaskScreen(
                                      id: widget.lessson.id.toString(),
                                    ),
                                  ));
                            }
                          : () async {
                              showSnackBar(
                                  context: context,
                                  message:
                                      AppLocalizations.of(context)!.loading,
                                  time: 2);
                              await filter!.filtertaskData();

                              ;
                              if (filter!.filtertask != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LessonTaskDetail(
                                        mission: filter!.filtertask as Task,
                                      ),
                                    ));
                              } else {
                                showSnackBar(
                                    context: context,
                                    message:
                                        AppLocalizations.of(context)!.no_task);
                                return;
                              }
                            },
                      child: Text(AppLocalizations.of(context)!.task),
                    ),
                  ),
                ),
                SizedBox(height: height / 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

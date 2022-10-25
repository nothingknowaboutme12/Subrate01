import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:subrate/controllers/getX/app_getX_controller.dart';
import 'package:subrate/controllers/storage/local/prefs/user_preference_controller.dart';
import 'package:subrate/core/res/routes.dart';
import 'package:subrate/core/widgets/MyElevatedButton.dart';
import 'package:subrate/models/Lesson/lesson.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app_localizations.dart';

import '../../../core/res/assets.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/utils/helpers.dart';
import 'Task/lesson_task_screen.dart';

// ignore: must_be_immutable
class LessonDetailScreen extends StatefulWidget {
  Lesson lessson;

  LessonDetailScreen({required this.lessson, Key? key}) : super(key: key);

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> with Helpers {
  late double width;
  late double height;
  double buttonHeight = 803 / 23.74;

  Uri _url = Uri.parse('https://flutter.dev');
  bool isGoButtonVisible = true;
  // DoMissionGetXController doMissionGetXController =
  // Get.put(DoMissi onGetXController());

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
    setState(() {
      connection;
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
    _url = Uri.parse(widget.lessson.link.toString());
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text(
          "Lesson Detail",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade500,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
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
          return ListView(
            children: [
              // SizedBox(height: height / 30),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey.shade800)],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  // border: Border.(color: Colors.grey.shade400, width: 1),
                  image: DecorationImage(
                      image: (widget.lessson.image!.isNotEmpty
                          ? !widget.lessson.image!.contains('http')
                              ? AssetImage(
                                  Assets.missionImage,
                                )
                              : NetworkImage(
                                  widget.lessson.image.toString(),
                                )
                          : AssetImage(
                              Assets.missionImage,
                            )) as ImageProvider,
                      fit: BoxFit.fill),
                ),
                height: height / 3,
                width: double.infinity,

                // child:
              ),
              SizedBox(height: height / 100),
              Container(
                // alignment: AlignmentDirectional.bottomStart,
                padding: EdgeInsetsDirectional.only(
                  start: width / 15,
                  end: width / 20,
                  top: height / 160,
                  bottom: height / 50,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                  child: Text(
                    widget.lessson.title ??
                        AppLocalizations.of(context)!.no_has_title,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height / 100),
              Container(
                height: height * 0.30,
                width: height * 0.80,
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white54),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
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
                      Text(
                        widget.lessson.description ?? 'No has description',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.050,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          onPressed: () {},
                          child: Text("Reaad more"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              Container(
                height: height * 0.11,
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 10),
                // padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(widget.lessson.link.toString()),
                        trailing: IconButton(
                            icon: Icon(
                              Icons.attach_file_sharp,
                              color: MissionDistributorColors.primaryColor,
                            ),
                            onPressed: () async {
                              final url =
                                  ClipboardData(text: widget.lessson.link);
                              await Clipboard.setData(url);
                              await Clipboard.getData('text/plain');
                            }),
                      ),
                    ),
                    Divider(
                      color: MissionDistributorColors.primaryColor,
                    )
                  ],
                ),
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LessonTaskScreen(
                              id: widget.lessson.id.toString(),
                            ),
                          ));
                    },
                    child: Text("Tasks"),
                  ),
                ),
              ),
              SizedBox(height: height / 20),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../app_localizations.dart';
import '../../../controllers/getX/do_mission_getX_controller.dart';
import '../../../controllers/getX/mission_getX_controller.dart';
import '../../../core/res/assets.dart';
import '../../../core/res/assets.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/res/routes.dart';
import '../../../core/widgets/MyElevatedButton.dart';

import '../../../models/Task/task.dart';
import '../../../models/network_link.dart';
import '../../../models/url_link.dart';

// ignore: must_be_immutable
class MissionCompleteScreen extends StatefulWidget {
  Task mission;
  String imageUrl;
  // String money;

  MissionCompleteScreen(
      {
      // required this.money,
      required this.mission,
      required this.imageUrl,
      Key? key})
      : super(key: key);

  @override
  State<MissionCompleteScreen> createState() => _MissionCompleteScreenState();
}

class _MissionCompleteScreenState extends State<MissionCompleteScreen> {
  late double width;
  late double height;
  double buttonHeight = 803 / 23.74;

  Uri _url = Uri.parse('https://flutter.dev');
  bool isGoButtonVisible = true;

  TextStyle textStyle = const TextStyle(
    color: MissionDistributorColors.primaryColor,
    fontSize: 13,
  );
  late String missionMoney = MissionGetXController.to.money.value;
  late double rate = MissionGetXController.to.rate.value;
  late double wallet;

  @override
  void initState() {
    doall();
    _url = widget.mission.link != null && widget.mission.link != ''
        ? Uri.parse(widget.mission.link)
        : Uri.parse('https://flutter.dev');

    super.initState();
  }

  doall() async {
    await MissionGetXController.to.read();
    await DoMissionGetXController.to.totalPoint();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MissionDistributorColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsetsDirectional.only(start: 10),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
              size: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.mission,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            buttonHeight = height / 18;
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
                              ? widget.mission.images[0].name.contains('http')
                                  ? Image.asset(
                                      Assets.missionImage,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      NetworkLink(
                                        link: widget.mission.images[0].name,
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
                    widget.mission.description ??
                        AppLocalizations.of(context)!.no_has_description,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: height / 20),
                Container(
                  padding: EdgeInsetsDirectional.only(
                      top: height / 50, start: width / 15, end: width / 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.points}: ',
                                    style: textStyle,
                                  ),
                                  Text(
                                    widget.mission.points.toString(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.wallet}: ',
                                    style: textStyle,
                                  ),
                                  Text(
                                    '${(double.parse(widget.mission.points) / rate)}\$',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          SizedBox(height: height / 100),
                          Row(
                            children: [
                              Container(
                                height: height / 12,
                                width: width / 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        MissionDistributorColors.primaryColor,
                                    width: 2,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '%${((100 / MissionGetXController.to.missionsCount.value.missionsCount) * MissionGetXController.to.missionsCount.value.completedMissionsCount).toString().split('.')[0]}',
                                  style: const TextStyle(
                                    color:
                                        MissionDistributorColors.primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: width / 40),
                              Text(
                                '${MissionGetXController.to.missionsCount.value.missionsCount}\\${MissionGetXController.to.missionsCount.value.completedMissionsCount}',
                                style: const TextStyle(
                                  color: MissionDistributorColors.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height / 50),
                          Text(
                            AppLocalizations.of(context)!.general_knowledge,
                            style: const TextStyle(
                              color: MissionDistributorColors.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: height / 70),
                          Text(
                            widget.mission.title ??
                                AppLocalizations.of(context)!.no_has_title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height / 100),
                      const Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Divider(
                          color: MissionDistributorColors.primaryColor,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 50),
                Container(
                  padding: EdgeInsetsDirectional.only(
                      top: height / 50, start: width / 15, end: width / 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width / 1.7,
                            child: Text(
                              widget.mission.link.contains('https://') ||
                                      widget.mission.link.contains('http://')
                                  ? widget.mission.link
                                  : UrlLink(link: widget.mission.link).link,
                              style: const TextStyle(
                                color: MissionDistributorColors.primaryColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.share,
                            color: MissionDistributorColors.primaryColor,
                          ),
                          const SizedBox(width: 0),
                        ],
                      ),
                      SizedBox(height: height / 100),
                      const Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Divider(
                          color: MissionDistributorColors.primaryColor,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 40),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                SizedBox(height: height / 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.total_points}: ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Obx(() {
                          return Text(
                            MissionGetXController.to.points.toString(),
                            style: const TextStyle(
                              color: MissionDistributorColors.primaryColor,
                              fontSize: 18,
                            ),
                          );
                        }),
                      ],
                    ),
                    MyElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, Routes.walletScreenScreen);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.go_wallet,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      height: buttonHeight,
                      width: width / 2.5,
                      borderRadiusGeometry: BorderRadius.circular(5),
                      gradient: const LinearGradient(
                        colors: [
                          MissionDistributorColors.primaryColor,
                          MissionDistributorColors.primaryColor,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}

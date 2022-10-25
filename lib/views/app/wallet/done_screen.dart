import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/res/assets.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/res/routes.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
          } else {}
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MissionDistributorColors.primaryColor,
                  MissionDistributorColors.thirdColor,
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: width / 15.28, vertical: height / 37),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 200,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.homeScreen);
                  },
                  icon: Image.asset(Assets.doneImage),
                ),
                SizedBox(height: height / 20),
                const Text(
                  'Go To Home Page',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height / 5),
              ],
            ),
          );
        },
      ),
    );
  }
}

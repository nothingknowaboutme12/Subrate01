import 'package:flutter/material.dart';
import 'package:subrate/core/res/mission_distributor_colors.dart';

class MissionDistributorTheme {
  static ThemeData missionDistributorTheme() {
    return ThemeData(
      primaryColor: MissionDistributorColors.primaryColor,
      primarySwatch: MissionDistributorColors.blue,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: MissionDistributorColors.primaryColor,
        refreshBackgroundColor: Colors.transparent,
        linearMinHeight: 3,
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              const BorderSide(color: MissionDistributorColors.primaryColor),
        ),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.black,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor:
            MaterialStateProperty.all(MissionDistributorColors.primaryColor),
      ),
    );
  }
}

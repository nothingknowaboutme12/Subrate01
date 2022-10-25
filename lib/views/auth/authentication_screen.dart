import 'package:flutter/material.dart';
import 'package:subrate/views/app/task/main_screen.dart';
import 'package:subrate/views/auth/kyc_screen.dart';

import '../../app_localizations.dart';
import '../../core/res/assets.dart';
import '../../core/res/mission_distributor_colors.dart';
import '../../core/res/routes.dart';
import '../../core/widgets/MyElevatedButton.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
  }

  double buttonHeight = 803 / 23.74;
  double buttonWidth = 392 / 1.27;
  double bottomSizeBox = 803 / 10;
  double sizedBoxHeight = 803 / 4.95;

  double socialNetworkSize = 803.6363636363636 / 5;
  double socialNetworkBottomHeight = 803.6363636363636 / 8;
  double socialNetworkTopHeight = 803.6363636363636 / 6.2297;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            bottomSizeBox = 0;
            buttonHeight = height / 17;
            buttonWidth = width / 1.27;
            sizedBoxHeight = height / 1.75;

            socialNetworkSize = height / 15;
            socialNetworkBottomHeight = height / 8;
            socialNetworkTopHeight = height / 6.2297;
          } else {
            bottomSizeBox = height / 10;
            buttonHeight = height / 7;
            buttonWidth = width / 3.68;
            socialNetworkSize = height / 12;
            socialNetworkBottomHeight = height / 16;
            socialNetworkTopHeight = height / 9;
          }
          return Stack(
            children: [
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.authBackgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomCenter,
                child: Image.asset(
                  Assets.authImage,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: sizedBoxHeight),
                        Text(
                          AppLocalizations.of(context)!.welcome_to,
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: height / 100),
                        Text(
                          AppLocalizations.of(context)!.app_name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: height / 100),
                        Text(
                          AppLocalizations.of(context)!.to_follow_please,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: height / 50),
                        MyElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.signUpScreen);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) =>
                            //           KycScreen(isSignUP: true),
                            //     ));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.sign_up.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: MissionDistributorColors.primaryColor,
                            ),
                          ),
                          height: buttonHeight,
                          width: width / 1.27,
                          borderRadiusGeometry: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                        ),
                        SizedBox(height: height / 70),
                        MyElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.signInScreen);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.sign_in.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          height: buttonHeight,
                          width: buttonWidth,
                          borderRadiusGeometry: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

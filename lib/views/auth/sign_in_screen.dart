import 'dart:io';

import 'package:flutter/material.dart';

import '../../app_localizations.dart';
import '../../controllers/storage/network/api/controllers/auth_api_controller.dart';
import '../../core/res/assets.dart';
import '../../core/res/mission_distributor_colors.dart';
import '../../core/res/routes.dart';
import '../../core/utils/helpers.dart';
import '../../core/widgets/MyElevatedButton.dart';
import '../../models/auth/socialAuth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with Helpers {
  late double width;
  late double height;

  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  String? _emailError;
  String? _passwordError;

  double socialNetworkSize = 803.6363636363636 / 5;
  double socialNetworkBottomHeight = 803.6363636363636 / 8;
  double socialNetworkTopHeight = 803.6363636363636 / 6.2297;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  double? _progressValue = 0;

  double buttonSize = 803.6363636363636 / 16;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    AppLocalizations? localizations = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.sign_in,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        backgroundColor: MissionDistributorColors.scaffoldBackground,
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              buttonSize = height / 16;

              socialNetworkSize = height / 15;
              socialNetworkBottomHeight = height / 8;
              socialNetworkTopHeight = height / 6.2297;
            } else {
              buttonSize = height / 8;

              socialNetworkSize = height / 12;
              socialNetworkBottomHeight = height / 16;
              socialNetworkTopHeight = height / 9;
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: width / 19.63),
              width: width,
              height: height,
              alignment: Alignment.center,
              child: ListView(
                children: [
                  LinearProgressIndicator(
                    value: _progressValue,
                    backgroundColor: Colors.transparent,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height / 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyElevatedButton(
                            onPressed: () async {
                              try {
                                _changeProgressValue(value: null);
                                showDialog(
                                  context: context,
                                  builder: (context) => Container(),
                                );
                                bool status = await SocialAuth.GoogleSignin();
                                if (status) {
                                  showSnackBar(
                                      context: context,
                                      message:
                                          localizations!.login_successfully);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Routes.homeScreen, (route) => false);
                                }
                                _changeProgressValue(value: 0);
                                Navigator.pop(context);
                              } catch (e) {
                                _changeProgressValue(value: 0);
                                Navigator.pop(context);
                                print(e.toString());
                                showSnackBar(
                                  context: context,
                                  message: localizations!.cancel,
                                  error: true,
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.googleIcon,
                                  width: width / 8.925,
                                  height: socialNetworkSize,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  localizations!.register_with_google,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            height: buttonSize,
                            borderRadiusGeometry: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          MyElevatedButton(
                            onPressed: () async {
                              try {
                                _changeProgressValue(value: null);
                                showDialog(
                                  context: context,
                                  builder: (context) => Container(),
                                );
                                bool status = await SocialAuth.FacebookSignin();
                                if (status) {
                                  showSnackBar(
                                      context: context,
                                      message:
                                          localizations.login_successfully);
                                  // Navigator.pushNamedAndRemoveUntil(context,
                                  //     Routes.homeScreen, (route) => false);
                                  _changeProgressValue(value: 0);
                                  Navigator.pop(context);
                                } else {
                                  _changeProgressValue(value: 0);
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                _changeProgressValue(value: 0);
                                Navigator.pop(context);
                                showSnackBar(
                                  error: true,
                                  context: context,
                                  message:
                                      "Something went wrong please try again",
                                );
                                showSnackBar(
                                  error: true,
                                  context: context,
                                  message: e.toString(),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.facebookIcon,
                                  width: width / 8.925,
                                  height: socialNetworkSize,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  localizations.register_with_facebook,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            height: buttonSize,
                            borderRadiusGeometry: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          MyElevatedButton(
                            onPressed: Platform.isIOS
                                ? () async {
                                    print("Register with apple");
                                  }
                                : () {
                                    showSnackBar(
                                        context: context,
                                        message: "Your are not apple user",
                                        error: true);
                                    return;
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/app_icons/apple.png",
                                  fit: BoxFit.cover,
                                  width: width / 8.925,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  localizations.register_with_apple,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            height: buttonSize,
                            borderRadiusGeometry: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width / 6,
                              child: const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            Text(
                              localizations.register_by_email,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: width / 6,
                              child: const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height / 17,
                      ),
                      TextField(
                        controller: _emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: localizations.email,
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          filled: true,
                          fillColor: MissionDistributorColors.textFieldColor,
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: MissionDistributorColors.primaryColor),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          errorText: _emailError,
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 42.29,
                      ),
                      TextField(
                        controller: _passwordTextController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(!_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          hintText: localizations.password,
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            // color: MissionDistributorColors.primaryColor,
                          ),
                          filled: true,
                          fillColor: MissionDistributorColors.textFieldColor,
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: MissionDistributorColors.primaryColor),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          errorText: _passwordError,
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 44.64,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.forgotPasswordScreen);
                          },
                          child: Text(
                            localizations.forget_password,
                            style: const TextStyle(
                              color: MissionDistributorColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 11.318,
                      ),
                      MyElevatedButton(
                        onPressed: () async => await performLogin(),
                        child: Text(
                          localizations.sign_in,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        height: buttonSize,
                        width: width / 1.57,
                        borderRadiusGeometry: BorderRadius.circular(25),
                        marginHorizontal: width / 8.72,
                        gradient: const LinearGradient(
                          colors: [
                            MissionDistributorColors.primaryColor,
                            MissionDistributorColors.primaryColor,
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localizations.do_not_have_an_account,
                            style: const TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.signUpScreen);
                            },
                            child: Text(
                              localizations.sign_up,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: height / 10,
                      // ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (checkFieldError()) {
      return true;
    } else {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.enter_required_data,
          error: true,
          time: 1);
      return false;
    }
  }

  bool checkFieldError() {
    bool mobile = checkEmail();
    bool password = checkPassword();
    setState(() {
      _emailError = !mobile ? AppLocalizations.of(context)!.enter_email : null;
      _passwordError =
          !password ? AppLocalizations.of(context)!.enter_password : null;
    });
    if (mobile && password) {
      return true;
    } else {
      return false;
    }
  }

  bool checkEmail() {
    if (_emailTextController.text.isNotEmpty) {
      if (_emailTextController.text.contains("@")) {
        return true;
      } else {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.enter_correct_email,
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  bool checkPassword() {
    if (_passwordTextController.text.isNotEmpty) {
      if (_passwordTextController.text.length >= 4) {
        return true;
      } else {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.enter_correct_password,
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> login() async {
    _changeProgressValue(value: null);
    showDialog(
      context: context,
      builder: (context) => const Center(),
    );
    bool status = await AuthApiController().login(
      email: _emailTextController.text.trim(),
      password: _passwordTextController.text.trim(),
    );
    _changeProgressValue(value: status ? 1 : 0);
    if (status) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homeScreen, (route) => false);
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.login_successfully);
      _changeProgressValue(value: status ? 1 : 0);
    } else {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.login_failed,
          error: true);
      Navigator.pop(context);
    }
  }
}

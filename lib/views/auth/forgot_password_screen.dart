import 'package:flutter/material.dart';

import '../../app_localizations.dart';
import '../../core/res/mission_distributor_colors.dart';
import '../../core/utils/helpers.dart';
import '../../core/widgets/MyElevatedButton.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with Helpers {
  late double width;
  late double height;

  late TextEditingController _emailTextEditingController;
  String? _emailError;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    super.dispose();
  }

  double? _progressValue = 0;

  double buttonSize = 803.6363636363636 / 16;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.forget_password,
          style: const TextStyle(color: Colors.black87, fontSize: 17),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            buttonSize = height / 16;
          } else {
            buttonSize = height / 8;
          }
          return Container(
            width: double.infinity,
            color: Colors.white,
            child: ListView(
              children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: width / 10.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height / 9.3),
                      Text(
                        AppLocalizations.of(context)!.need_help_with_password,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: height / 73.8),
                      Text(
                        AppLocalizations.of(context)!
                            .you_can_retrieve_your_password,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: height / 50),
                      TextField(
                        controller: _emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.put_your_email_here,
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
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
                      SizedBox(height: height / 10.5),
                      MyElevatedButton(
                        onPressed: () async => await performForgetPassword(),
                        child: Text(
                          AppLocalizations.of(context)!.send,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        height: buttonSize,
                        width: width / 1.57,
                        borderRadiusGeometry: BorderRadius.circular(10),
                        marginHorizontal: width / 8.72,
                        gradient: const LinearGradient(
                          colors: [
                            MissionDistributorColors.primaryColor,
                            MissionDistributorColors.primaryColor
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> performForgetPassword() async {
    if (checkData()) {
      await resetPassword();
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
    bool email = checkEmail();
    setState(() {
      _emailError = !email ? AppLocalizations.of(context)!.enter_email : null;
    });
    if (email) {
      return true;
    } else {
      return false;
    }
  }

  bool checkEmail() {
    if (_emailTextEditingController.text.isNotEmpty) {
      if (_emailTextEditingController.text.contains("@")) {
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

  Future<void> resetPassword() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Colors.pink,
          value: _progressValue,
        ),
      ),
    );
    _changeProgressValue(value: null);

    bool status = true;
    _changeProgressValue(value: status ? 1 : 0);

    if (status) {
      Navigator.pop(context);
      Navigator.pop(context);
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.password_reset_email_sent);
    } else {
      Navigator.pop(context);
      // Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }
}

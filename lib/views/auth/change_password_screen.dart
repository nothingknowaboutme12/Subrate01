import 'package:flutter/material.dart';

import '../../../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../../../core/res/routes.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/widgets/MyElevatedButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controllers/storage/network/api/controllers/auth_api_controller.dart';
import '../../core/res/mission_distributor_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with Helpers {
  late double width;
  late double height;

  late TextEditingController _oldPasswordTextEditingController;
  late TextEditingController _newPasswordTextEditingController;
  late TextEditingController _confirmNewPasswordTextEditingController;

  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmNewPasswordError;

  @override
  void initState() {
    super.initState();
    _oldPasswordTextEditingController = TextEditingController();
    _newPasswordTextEditingController = TextEditingController();
    _confirmNewPasswordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordTextEditingController.dispose();
    _newPasswordTextEditingController.dispose();
    _confirmNewPasswordTextEditingController.dispose();
    super.dispose();
  }

  double buttonSize = 803.6363636363636 / 16;

  double? _progressValue = 0;
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  bool _isObscureOld = true;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MissionDistributorColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 18.7),
          child: IconButton(
            color: Colors.grey,
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 15,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.change_password,
          style: const TextStyle(fontSize: 17, color: Colors.black),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
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
                      LinearProgressIndicator(
                        value: _progressValue,
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(height: height / 12.3),
                      TextField(
                        controller: _oldPasswordTextEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isObscureOld,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscureOld
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscureOld = !_isObscureOld;
                                });
                              }),
                          hintText: AppLocalizations.of(context)!.old_password,
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
                          errorText: _oldPasswordError,
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height / 40.6),
                      TextField(
                        controller: _newPasswordTextEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          hintText: AppLocalizations.of(context)!.new_password,
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
                          errorText: _newPasswordError,
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height / 40.6),
                      TextField(
                        controller: _confirmNewPasswordTextEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isObscureConfirm,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscureConfirm
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscureConfirm = !_isObscureConfirm;
                                });
                              }),
                          hintText: AppLocalizations.of(context)!
                              .confirm_new_password,
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
                          errorText: _confirmNewPasswordError,
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height / 12.3),
                      MyElevatedButton(
                        onPressed: () async => await performChangePassword(),
                        child: Text(
                          AppLocalizations.of(context)!.change_password,
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
                            MissionDistributorColors.primaryColor,
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.forgotPasswordScreen);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forgot_password,
                          style: const TextStyle(
                              color: MissionDistributorColors.primaryColor),
                        ),
                      ),
                      SizedBox(height: height / 40.6),
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

  Future<void> performChangePassword() async {
    if (checkData()) {
      await changePassword();
    }
  }

  bool checkData() {
    if (checkFieldError()) {
      return true;
    }
    return false;
  }

  bool checkFieldError() {
    bool oldPassword = checkOldPassword();
    if (!oldPassword) return false;
    bool newPassword = checkNewPassword();
    if (!newPassword) return false;
    bool confirmNewPassword = checkConfirmPassword();
    if (!confirmNewPassword) return false;

    setState(() {
      _oldPasswordError = !oldPassword
          ? AppLocalizations.of(context)!.enter_old_password
          : null;
      _newPasswordError = !newPassword
          ? AppLocalizations.of(context)!.enter_new_password
          : null;
      _confirmNewPasswordError = !confirmNewPassword
          ? AppLocalizations.of(context)!.enter_confirm_new_password
          : null;
    });
    if (oldPassword && newPassword && confirmNewPassword) {
      return true;
    } else {
      return false;
    }
  }

  bool checkOldPassword() {
    if (_oldPasswordTextEditingController.text.isNotEmpty) {
      if (_oldPasswordTextEditingController.text.length >= 4) {
        if (UserPreferenceController().password ==
            _oldPasswordTextEditingController.text) {
          return true;
        } else {
          showSnackBar(
              context: context,
              message: AppLocalizations.of(context)!.wrong_old_password,
              error: true,
              time: 1);
          return false;
        }
      } else {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.enter_correct_old_password,
            error: true,
            time: 1);
        return false;
      }
    } else {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.enter_required_data,
          error: true,
          time: 1);
      return false;
    }
  }

  bool checkNewPassword() {
    if (_newPasswordTextEditingController.text.isNotEmpty) {
      if (_newPasswordTextEditingController.text.length >= 6) {
        return true;
      } else {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.enter_correct_new_password,
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  bool checkConfirmPassword() {
    if (_confirmNewPasswordTextEditingController.text.isNotEmpty) {
      if (_confirmNewPasswordTextEditingController.text.length >= 6) {
        if (_confirmNewPasswordTextEditingController.text ==
            _newPasswordTextEditingController.text) {
          return true;
        } else {
          showSnackBar(
              context: context,
              message:
                  AppLocalizations.of(context)!.two_password_are_not_equaled,
              error: true,
              time: 1);
          return false;
        }
      } else {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!
                .enter_correct_confirm_new_password,
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> changePassword() async {
    _changeProgressValue(value: null);
    showDialog(context: context, builder: (context) => const Center());
    bool status = await AuthApiController().changePassword(
        oldPassword: UserPreferenceController().password,
        newPassword: _newPasswordTextEditingController.text,
        context: context);
    _changeProgressValue(value: status ? 1 : 0);
    if (status) {
      UserPreferenceController()
          .updatePassword(_newPasswordTextEditingController.text);
      Navigator.pop(context);
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.change_password_successfully);
    } else {
      Navigator.pop(context);
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.change_password_failed,
          error: true);
    }
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }
}

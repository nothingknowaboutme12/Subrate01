import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:subrate/models/notification/notification.dart';
import '../../controllers/storage/network/api/controllers/auth_api_controller.dart';
import '../../core/res/mission_distributor_colors.dart';
import '../../core/res/routes.dart';
import '../../core/utils/helpers.dart';
import '../../core/widgets/MyElevatedButton.dart';
import 'kyc_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Helpers {
  late double width;
  late double height;

  late TextEditingController _usernameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPasswordTextController;
  late TextEditingController _mobile;
  late TextEditingController _birthDateTextEditingController;
  String? _usernameError;
  String? _mobilerror;
  String? _birthDateError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  List<DropdownMenuItem> citiesItem = [];
  bool checked = false;
  double editTextSize = 803.6363636363636 / 12.36;

  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
    _birthDateTextEditingController = TextEditingController();
    _mobile = TextEditingController();
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    _mobile.dispose();
    _birthDateTextEditingController.dispose();
    super.dispose();
  }

  File? Image;
  double? _progressValue = 0;
  double buttonSize = 803.6363636363636 / 16;
  double bottomSizeBox = 803.6363636363636 / 3.4197;
  bool _isObscure = true;
  bool _isObscureConfirm = true;

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
          AppLocalizations.of(context)!.sign_up,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
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
            bottomSizeBox = height / 4;
          } else {
            buttonSize = height / 8;
            bottomSizeBox = height / 7;
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: width,
            height: height,
            alignment: Alignment.topCenter,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height / 13.68),
                    SizedBox(
                      height: height * 0.15,
                      width: width * 0.25,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage: Image == null
                                ? null
                                : FileImage(
                                    Image as File,
                                  ),
                            child: Image == null
                                ? Icon(
                                    Icons.person,
                                    color: Colors.grey.shade700,
                                    size: 45,
                                  )
                                : Text(""),
                            backgroundColor: Colors.grey.shade300,
                            radius: 50,
                          ),
                          Positioned(
                            // right: ,
                            bottom: 18,
                            right: 8,
                            child: SizedBox(
                              height: height * 0.0350,
                              width: width * 0.080,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                    size: 28,
                                  ),
                                  onPressed: () async {
                                    await showDialog<ImageSource>(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) {
                                          return SimpleDialog(
                                            title: Text(
                                              localizations!.selectImage,
                                            ),
                                            children: [
                                              SimpleDialogOption(
                                                  child: ListTile(
                                                    title: Text(
                                                        localizations.camera
                                                        // "Camera",
                                                        ),
                                                    leading: Icon(
                                                      Icons.camera_alt,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pop(context);

                                                    ImagePicker picker =
                                                        ImagePicker();
                                                    final picked =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                    if (picked != null) {
                                                      setState(() {
                                                        Image =
                                                            File(picked.path);
                                                      });
                                                    }
                                                  }),
                                              SimpleDialogOption(
                                                  child: ListTile(
                                                    title: Text(
                                                        localizations.gallery),
                                                    leading: Icon(
                                                      Icons.image,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    ImagePicker picker =
                                                        ImagePicker();
                                                    final picked =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    if (picked != null) {
                                                      setState(() {
                                                        Image =
                                                            File(picked.path);
                                                      });
                                                    }
                                                  }),
                                            ],

                                            // Navigator.pop(context);
                                          );
                                        });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 20.68),
                    TextField(
                      controller: _usernameTextController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: localizations!.name,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: MissionDistributorColors.textFieldColor,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: ThemeData()
                                    .inputDecorationTheme
                                    .focusedBorder
                                    ?.borderSide
                                    .color ??
                                MissionDistributorColors.primaryColor,
                          ),
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
                        errorText: _usernameError,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 42.29),
                    TextField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: localizations.email,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
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
                    SizedBox(height: height / 42.29),
                    TextField(
                      controller: _mobile,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: localizations.numbers,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: MissionDistributorColors.textFieldColor,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: ThemeData()
                                    .inputDecorationTheme
                                    .focusedBorder
                                    ?.borderSide
                                    .color ??
                                MissionDistributorColors.primaryColor,
                          ),
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
                        errorText: _mobilerror,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 42.29),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: editTextSize,
                      child: TextField(
                        controller: _birthDateTextEditingController,
                        decoration: InputDecoration(
                          label: Text(AppLocalizations.of(context)!.birthDate),
                          errorText: _birthDateError,
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: MissionDistributorColors.secondaryColor,
                              width: 2,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: MissionDistributorColors.primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 42.29),
                    TextField(
                      controller: _passwordTextController,
                      keyboardType: TextInputType.visiblePassword,
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
                          color: Colors.grey,
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
                    SizedBox(height: height / 42.29),
                    TextField(
                      controller: _confirmPasswordTextController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscureConfirm,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(!_isObscureConfirm
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscureConfirm = !_isObscureConfirm;
                              });
                            }),
                        hintText: localizations.confirm_password,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
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
                        errorText: _confirmPasswordError,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 42.29),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        localizations.password_length,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: height / 42.29),
                    FittedBox(
                      child: Row(
                        children: [
                          Checkbox(
                            value: checked,
                            onChanged: (value) {
                              setState(() {
                                checked = value as bool;
                              });
                            },
                          ),
                          Text(
                            localizations.agree_and_term,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    localizations.term_and_condition,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  content: Text(
                                    "There we will show all the term and conditions",
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                  actions: [
                                    MyElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      height: buttonSize,
                                      width: width,
                                      borderRadiusGeometry:
                                          BorderRadius.circular(15),
                                      marginHorizontal: width / 8.72,
                                      gradient: const LinearGradient(
                                        colors: [
                                          MissionDistributorColors.primaryColor,
                                          MissionDistributorColors.primaryColor
                                        ],
                                      ),
                                      child: Text(
                                        "X",
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              "Terms and conditions",
                              style: TextStyle(
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: MissionDistributorColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 17.85),
                    MyElevatedButton(
                      onPressed: checked
                          ? () async {
                              await performSignUp();
                            }
                          : null,
                      height: buttonSize,
                      width: width,
                      borderRadiusGeometry: BorderRadius.circular(15),
                      marginHorizontal: width / 8.72,
                      gradient: const LinearGradient(
                        colors: [
                          MissionDistributorColors.primaryColor,
                          MissionDistributorColors.primaryColor
                        ],
                      ),
                      child: Text(
                        localizations.sign_up,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          localizations.already_have_an_account,
                          style: const TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.signInScreen);
                          },
                          child: Text(localizations.sign_in),
                        ),
                      ],
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

  Future<void> performSignUp() async {
    if (checkFieldError()) {
      await signUp();
    }
  }

  bool checkFieldError() {
    bool username = checkUsername();
    bool email = checkEmail();
    bool phone = checkphone();
    bool password = checkPassword();
    bool confirmPassword = checkConfirmPassword();
    bool checkDateBirth = checkBirthDate();
    setState(() {
      _usernameError =
          !username ? AppLocalizations.of(context)!.enter_username : null;
      _emailError = !email ? AppLocalizations.of(context)!.enter_email : null;
      _passwordError =
          !password ? AppLocalizations.of(context)!.enter_password : null;
      _confirmPasswordError = !confirmPassword
          ? AppLocalizations.of(context)!.enter_confirm_password
          : null;
      _mobilerror =
          !phone ? AppLocalizations.of(context)!.enter_phone_number : null;
      _birthDateError = !checkDateBirth
          ? AppLocalizations.of(context)!.enter_birthdate
          : null;
    });
    if (username &&
        email &&
        password &&
        confirmPassword &&
        phone &&
        checkDateBirth) {
      return true;
    } else {
      return false;
    }
  }

  bool checkUsername() {
    if (_usernameTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkBirthDate() {
    if (_birthDateTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkphone() {
    if (_mobile.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkEmail() {
    if (_emailTextController.text.isNotEmpty) {
      if (_emailTextController.text.contains('@')) {
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
      if (_passwordTextController.text.length >= 9) {
        return true;
      } else {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.password_length,
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  bool checkConfirmPassword() {
    if (_confirmPasswordTextController.text.isNotEmpty) {
      if (_confirmPasswordTextController.text.length >= 4) {
        if (_confirmPasswordTextController.text ==
            _passwordTextController.text) {
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
            message: AppLocalizations.of(context)!.enter_correct_password,
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> signUp() async {
    print("Value of image is ${Image}");
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: MissionDistributorColors.primaryColor,
              ),
            ));
    bool status = await AuthApiController().register(
        name: _usernameTextController.text,
        email: _emailTextController.text,
        password: _passwordTextController.text,
        image: Image == null ? "" : base64Encode(Image!.readAsBytesSync()),
        date: _birthDateTextEditingController.text,
        phone: _mobile.text,
        context: context);
    if (status) {
      await login();
    } else {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.sign_up_failed,
          error: true);
      Navigator.pop(context);
    }
  }

  Future<void> login() async {
    bool status = await AuthApiController().login(
      email: _emailTextController.text.trim(),
      password: _passwordTextController.text.trim(),
    );
    if (status) {
      final token = await FirebaseMessaging.instance.getToken();
      NotificationApi.fcmtokenUpdate(token.toString());
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.sign_up_successfully);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => KycScreen(isSignUP: true),
        ),
        (route) => false,
      );
      Navigator.of(context);
    } else {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.sign_up_failed,
          error: true);
      Navigator.pop(context);
    }
  }
}

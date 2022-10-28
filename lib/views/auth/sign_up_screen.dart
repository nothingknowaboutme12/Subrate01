import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../app_localizations.dart';
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

  String? _usernameError;
  String? _mobilerror;
  String? _dateerror;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  List<DropdownMenuItem> citiesItem = [];

  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
    _mobile = TextEditingController();
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    _mobile.dispose();
    super.dispose();
  }

  File? image;
  double? _progressValue = 0;
  double buttonSize = 803.6363636363636 / 16;
  double bottomSizeBox = 803.6363636363636 / 3.4197;
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  bool _isObscureOld = true;

  String? selectedDate;
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
                // LinearProgressIndicator(
                //   value: _progressValue,
                //   backgroundColor: Colors.transparent,
                // ),
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
                            backgroundImage: image == null
                                ? null
                                : FileImage(
                                    image as File,
                                  ),
                            child: image == null
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
                                                localizations!.selectImage),
                                            children: [
                                              SimpleDialogOption(
                                                  child: ListTile(
                                                    title: Text(
                                                        localizations.camera),
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
                                                        image =
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
                                                        image =
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
                    GestureDetector(
                      onTap: Platform.isIOS
                          ? () async {
                              // Cuper

                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (_) => Container(
                                        height: 500,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 400,
                                              child: CupertinoDatePicker(
                                                  initialDateTime:
                                                      DateTime.now(),
                                                  onDateTimeChanged: (val) {
                                                    setState(() {
                                                      selectedDate =
                                                          val.toString();
                                                    });
                                                  }),
                                            ),

                                            // Close the modal
                                            CupertinoButton(
                                              child: Text(localizations.ok),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            )
                                          ],
                                        ),
                                      ));
                            }
                          : () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101),
                              );

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  selectedDate = formattedDate
                                      .toString(); //set output date to TextField value.
                                });
                              } else {
                                showSnackBar(
                                    context: context,
                                    message: localizations.date_not_selected,
                                    error: true);
                              }
                            },
                      child: Container(
                        height: height * 0.07,
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          selectedDate == null
                              ? localizations.date_not_selected
                              : selectedDate.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MissionDistributorColors.textFieldColor,
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
                    SizedBox(height: height / 17.85),
                    MyElevatedButton(
                      onPressed: () async {
                        if (image == null) {
                          showSnackBar(
                            context: context,
                            message: localizations.selectImage,
                            error: true,
                          );
                          return;
                        }
                        image == null ? Text('') : await performSignUp();
                      },
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
    if (checkData()) {
      await signUp();
    }
  }

  bool checkData() {
    if (checkFieldError()) {
      if (selectedDate == null) {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.enter_birthdate,
            error: true,
            time: 1);
        return false;
      }
      return true;
    } else
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.enter_required_data,
          error: true,
          time: 1);
    return false;
  }

  bool checkFieldError() {
    bool username = checkUsername();
    bool email = checkEmail();
    bool phone = checkphone();
    bool password = checkPassword();
    bool confirmPassword = checkConfirmPassword();

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
    });
    if (username && email && password && confirmPassword && phone) {
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
        image: base64Encode(image!.readAsBytesSync()),
        date: selectedDate.toString(),
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

import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subrate/controllers/storage/local/prefs/user_preference_controller.dart';
import 'package:subrate/controllers/storage/network/api/api_settings.dart';
import 'package:subrate/core/res/network.dart';
import 'package:subrate/core/utils/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:subrate/models/authorization_header.dart';
import '../../app_localizations.dart';
import '../../core/res/assets.dart';
import '../../core/res/mission_distributor_colors.dart';
import '../../core/res/routes.dart';
import '../../core/widgets/MyElevatedButton.dart';
import '../../models/network_link.dart';

class KycScreen extends StatefulWidget {
  // static const String routName = "KycScreen";
  bool isSignUP;
  bool wallet;
  KycScreen({Key? key, required this.isSignUP, this.wallet = false})
      : super(key: key);

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> with Helpers {
  late double width;
  late double height;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController DBirth;
  final List<String> item = ["License", "Passport", "National"];
  String? selectedValue;
  String? ImageUrl;
  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    DBirth = TextEditingController();
    name.text = UserPreferenceController().userInformation.name;
    email.text = UserPreferenceController().userInformation.email;

    phone.text =
        UserPreferenceController().userInformation.mobile.toString() ?? '';

    DBirth.text =
        UserPreferenceController().userInformation.dob.toString() ?? '';

    ImageUrl =
        UserPreferenceController().userInformation.avatar.toString() ?? '';
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    DBirth.dispose();
    super.dispose();
  }

  File? identityImage;
  File? InfoImage;
  double? _progressValue = 0;
  double buttonSize = 803.6363636363636 / 16;
  double bottomSizeBox = 803.6363636363636 / 3.4197;
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  bool _isObscureOld = true;
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
          localizations!.kyc_valid,
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
              shrinkWrap: true,
              children: [
                LinearProgressIndicator(
                  value: _progressValue,
                  backgroundColor: Colors.transparent,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height / 40.68),
                      ImageUrl!.isNotEmpty
                          ? CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  // .FileImage(File(ImageUrl.toString()))
                                  NetworkImage(
                                ImageUrl.toString(),
                              ),
                            )
                          : SizedBox(
                              height: height * 0.15,
                              width: width * 0.25,
                              child: Stack(
                                clipBehavior: Clip.none,
                                fit: StackFit.expand,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: InfoImage == null
                                        ? null
                                        : FileImage(
                                            InfoImage as File,
                                          ),
                                    child: InfoImage == null
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
                                    bottom: 13,
                                    right: 10,
                                    child: SizedBox(
                                      height: height * 0.0350,
                                      width: width * 0.080,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: Colors.blue,
                                            size: 27,
                                          ),
                                          onPressed: () async {
                                            await showDialog<ImageSource>(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (context) =>
                                                  SimpleDialog(
                                                title: Text(
                                                    localizations.selectImage),
                                                children: [
                                                  SimpleDialogOption(
                                                      child: ListTile(
                                                        title: Text(
                                                            localizations
                                                                .camera),
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
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                        if (picked != null) {
                                                          setState(() {
                                                            InfoImage = File(
                                                                picked.path);
                                                          });
                                                        }
                                                      }),
                                                  SimpleDialogOption(
                                                      child: ListTile(
                                                        title: Text(
                                                            localizations
                                                                .gallery),
                                                        leading: Icon(
                                                          Icons.image,
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        // Navigator.pop(context);

                                                        ImagePicker picker =
                                                            ImagePicker();
                                                        final picked =
                                                            await picker.pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                        if (picked != null) {
                                                          setState(() {
                                                            InfoImage = File(
                                                                picked.path);
                                                          });
                                                        }
                                                      }),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(height: height / 20.68),
                      customtextfield(
                        controller: name,
                        enabled: false,
                        keyboard: TextInputType.name,
                        title: localizations.name,
                      ),
                      SizedBox(height: height / 42.29),
                      customtextfield(
                        controller: email,
                        title: localizations.email,
                        enabled: false,
                        keyboard: TextInputType.emailAddress,
                        valid: (value) {
                          if (value!.isEmpty) {
                            showSnackBar(
                                context: context,
                                message: localizations.enter_email,
                                error: true);
                            return localizations.enter_email;
                          }
                          if (!value.contains('@')) {
                            showSnackBar(
                                context: context,
                                message: localizations.enter_correct_email,
                                error: true);
                            return localizations.enter_correct_email;
                          }
                        },
                      ),
                      SizedBox(
                        height: height / 42.29,
                      ),
                      customtextfield(
                        controller: phone,
                        enabled: widget.isSignUP ? false : true,
                        title: localizations.phone_number,
                        keyboard: TextInputType.phone,
                        valid: (value) {
                          if (value!.isEmpty) {
                            showSnackBar(
                                context: context,
                                message: localizations.enter_phone_number,
                                error: true);
                            return localizations.enter_phone_number;
                          }
                        },
                      ),
                      SizedBox(height: height / 42.29),
                      widget.isSignUP
                          ? customtextfield(
                              title: localizations.birthDate,
                              controller: DBirth,
                              enabled: false,
                            )
                          : GestureDetector(
                              onTap: Platform.isIOS
                                  ? () async {
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
                                                      child:
                                                          CupertinoDatePicker(
                                                              initialDateTime:
                                                                  DateTime
                                                                      .now(),
                                                              onDateTimeChanged:
                                                                  (val) {
                                                                setState(() {
                                                                  DBirth.text =
                                                                      val.toString();
                                                                });
                                                              }),
                                                    ),

                                                    // Close the modal
                                                    CupertinoButton(
                                                      child: Text(
                                                          localizations.ok),
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                    )
                                                  ],
                                                ),
                                              ));
                                    }
                                  : () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101),
                                      );

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        setState(() {
                                          DBirth.text = formattedDate
                                              .toString(); //set output date to TextField value.
                                        });
                                      } else {
                                        showSnackBar(
                                            context: context,
                                            message:
                                                localizations.date_not_selected,
                                            error: true);
                                      }
                                    },
                              child: Container(
                                height: height * 0.07,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 13),
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  DBirth.text.isEmpty
                                      ? localizations.date_not_selected
                                      : DBirth.text.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      MissionDistributorColors.textFieldColor,
                                ),
                              ),
                            ),
                      SizedBox(height: height / 42.29),
                      GestureDetector(
                        onTap: () async {
                          await showDialog<ImageSource>(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) => SimpleDialog(
                              title: Text(localizations.selectImage),
                              children: [
                                SimpleDialogOption(
                                    child: ListTile(
                                      title: Text(localizations.camera),
                                      leading: Icon(
                                        Icons.camera_alt,
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      ImagePicker picker = ImagePicker();
                                      final picked = await picker.pickImage(
                                          source: ImageSource.camera);
                                      if (picked != null) {
                                        setState(() {
                                          identityImage = File(picked.path);
                                        });
                                      }
                                    }),
                                SimpleDialogOption(
                                    child: ListTile(
                                      title: Text(localizations.gallery),
                                      leading: Icon(
                                        Icons.image,
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      ImagePicker picker = ImagePicker();
                                      final picked = await picker.pickImage(
                                          source: ImageSource.gallery);
                                      if (picked != null) {
                                        setState(() {
                                          identityImage = File(picked.path);
                                        });
                                      }
                                    }),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: height * 0.07,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 13, vertical: 13),
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            identityImage == null
                                ? localizations.uploadid
                                : localizations.select,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MissionDistributorColors.textFieldColor,
                          ),
                        ),
                      ),
                      SizedBox(height: height / 42.29),
                      Container(
                        height: height * 0.07,
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              localizations.idtype,
                              style: TextStyle(
                                fontSize: 16,
                                //     color: Colors.grey,
                              ),
                            ),
                            items: item
                                .map(
                                  (itm) => DropdownMenuItem<String>(
                                    value: itm,
                                    child: Text(
                                      itm,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MissionDistributorColors.textFieldColor,
                        ),
                      ),
                      SizedBox(height: height / 42.29),
                      MyElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            if (identityImage == null) {
                              showSnackBar(
                                  context: context,
                                  message: localizations.selectImage,
                                  error: true);
                              return;
                            } else if (selectedValue == null) {
                              {
                                showSnackBar(
                                    context: context,
                                    message: localizations.idtype,
                                    error: true);
                                return;
                              }
                            } else if (DBirth.text.isEmpty) {
                              {
                                showSnackBar(
                                    context: context,
                                    message: localizations.date_not_selected,
                                    error: true);
                                return;
                              }
                            } else
                              try {
                                await validate();
                              } catch (e) {
                                _changeProgressValue(value: 0);
                                showSnackBar(
                                    context: context,
                                    message: e.toString(),
                                    error: true);
                              }
                          }
                        },
                        child: Text(
                          localizations.kyc_valid,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
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

  void _changeProgressValue({required double? value}) {
    if (mounted)
      setState(() {
        _progressValue = value;
      });
  }

  bool status = false;

  Future<void> validate() async {
    _changeProgressValue(value: null);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Container());
    // _changeProgressValue(value: 0);
    String token = UserPreferenceController().token;
    var response = (await http.post(Uri.parse(ApiSettings.kyc),
        body: ImageUrl!.isNotEmpty
            ? {
                'name': name.text,
                'email': email.text,
                'phone': phone.text,
                'dob': DBirth.text,
                'identity_type': selectedValue,
                'identity_screenshot': base64Encode(
                  identityImage!.readAsBytesSync(),
                ),
              }
            : {
                'name': name.text,
                'email': email.text,
                'phone': phone.text,
                'dob': DBirth.text,
                'identity_type': selectedValue,
                'identity_screenshot': base64Encode(
                  identityImage!.readAsBytesSync(),
                ),
                'avatar': base64Encode(
                  InfoImage!.readAsBytesSync(),
                )
              },
        headers: {
          HttpHeaders.authorizationHeader:
              AuthorizationHeader(token: token).token,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      showSnackBar(context: context, message: "Validation submit successfully");
      widget.wallet
          ? Navigator.pushNamed(context, Routes.walletScreen)
          : Navigator.pushReplacementNamed(
              context,
              await Routes.homeScreen,
            );
    } else {
      _changeProgressValue(value: 0);
      Navigator.pop(context);
      Navigator.pop(context);
      showSnackBar(
          context: context,
          message: "Something went wrong, please try again",
          error: true);
    }
    _changeProgressValue(value: 0.0);
  }
}

class customtextfield extends StatelessWidget {
  customtextfield({
    Key? key,
    this.controller,
    required this.title,
    this.keyboard,
    this.valid,
    this.enabled = true,
  });

  final TextEditingController? controller;
  TextInputType? keyboard;
  String? title;
  String? Function(String?)? valid;
  bool enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: valid,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: title,
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
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        // errorText: _usernameError,

        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red.shade300,
            width: 2,
          ),
        ),
      ),
    );
  }
}

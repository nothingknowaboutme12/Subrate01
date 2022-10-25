import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../../../core/res/assets.dart';
import '../../../../core/res/routes.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/widgets/MyElevatedButton.dart';
import '../../app_localizations.dart';
import '../../controllers/storage/network/api/controllers/auth_api_controller.dart';
import '../../core/res/mission_distributor_colors.dart';
import '../../models/auth/User.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with Helpers {
  late double width;
  late double height;

  late TextEditingController _usernameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _phoneTextEditingController;

  String? _usernameError;
  String? _emailError;
  String? _phoneError;
  String? _birthDateError;
  String? selectedDate;
  ImagePicker? imagePicker;
  XFile? _pickedFile;

  late String profileImage;

  String? gender;
  String? _selectedGender;
  final List<String> _genderList = [
    'Male',
    'Female',
  ];

  double itemSize = 392.72727272727275 / 6;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _phoneTextEditingController = TextEditingController();
    // _birthDateTextEditingController = TextEditingController();
    _usernameTextController.text =
        UserPreferenceController().userInformation.name;
    _emailTextController.text =
        UserPreferenceController().userInformation.email;
    _phoneTextEditingController.text =
        UserPreferenceController().userInformation.mobile ?? '';

    _selectedGender = UserPreferenceController().userInformation.gender ?? '';
    selectedDate = UserPreferenceController().userInformation.dob ?? '';

    imagePicker = ImagePicker();
    profileImage = UserPreferenceController().userInformation.avatar ?? '';

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      showSnackBar(
          context: context,
          message: 'Couldn\'t check connectivity status',
          error: true);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      // print(_connectionStatus.name);
    });
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _phoneTextEditingController.dispose();
    super.dispose();
  }

  double imageHeight = 803.6363636363636 / 9.34;
  double editTextSize = 803.6363636363636 / 12.36;
  double buttonSize = 803.6363636363636 / 16;
  double? _progressValue = 0;

  bool firstBuild = true;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    //
    // if (firstBuild) {
    //   firstBuild = false;
    //   if (gender == 'Male') {
    //     _selectedGender = AppLocalizations.of(context)!.gender_male;
    //   } else if (gender == 'Female') {
    //     _selectedGender = AppLocalizations.of(context)!.gender_female;
    //   }
    // }
    // _genderList[0] = AppLocalizations.of(context)!.gender_male;
    // _genderList[1] = AppLocalizations.of(context)!.gender_female;

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
          AppLocalizations.of(context)!.edit_profile,
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
            imageHeight = height / 9.34;
            editTextSize = height / 14;
            buttonSize = height / 16;
            itemSize = height / 12;
          } else {
            imageHeight = height / 5;
            editTextSize = height / 6;
            buttonSize = height / 8;
            itemSize = height / 6;
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: width / 15.1),
            child: ListView(
              children: [
                SizedBox(height: height / 20),

                // Profile Image
                GestureDetector(
                  onTap: selectPhotoFromGallery,
                  onLongPress: capturePhotoFromCamera,
                  child: Container(
                    alignment: Alignment.center,
                    width: width / 4.56,
                    height: imageHeight,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: (_pickedFile != null
                              ? FileImage(
                                  File(_pickedFile!.path),
                                )
                              : profileImage != ''
                                  ? _connectionStatus.name != 'none'
                                      ? NetworkImage(
                                          UserPreferenceController()
                                                  .userInformation
                                                  .avatar ??
                                              '',
                                        )
                                      : AssetImage(
                                          "assets/app_images/profile_image.png")
                                  : AssetImage(
                                      "assets/app_images/profile_image.png"))
                          as ImageProvider,
                    ),
                  ),
                ),
                SizedBox(height: height / 27.7),
                // Name
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: editTextSize,
                  child: TextField(
                    controller: _usernameTextController,
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.name),
                      errorText: _usernameError,
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade300,
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: MissionDistributorColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),

                // Email
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: editTextSize,
                  child: TextField(
                    controller: _emailTextController,
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.email),
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
                ),

                // Phone number
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: editTextSize,
                  child: TextField(
                    controller: _phoneTextEditingController,
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.phone_number),
                      errorText: _phoneError,
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade300,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: Platform.isIOS
                      ? () async {
                          // Cuper

                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => Container(
                                    height: 400,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 400,
                                          child: CupertinoDatePicker(
                                              initialDateTime: DateTime.now(),
                                              onDateTimeChanged: (val) {
                                                setState(() {
                                                  selectedDate = val.toString();
                                                });
                                              }),
                                        ),

                                        // Close the modal
                                        CupertinoButton(
                                          child: const Text('OK'),
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
                            print("Date is not selected");
                          }
                        },
                  child: Container(
                    height: height * 0.07,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                    // margin: EdgeInsets.symmetric(horizontal: 1),
                    child: Text(
                      selectedDate == null
                          ? "Choose your date of birth"
                          : selectedDate.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      // border: Border.fromBorderSide(BorderSide()),
                      color: MissionDistributorColors.textFieldColor,
                    ),
                  ),
                ),
                SizedBox(height: height / 40),

                // Gender
                // GestureDetector(
                //   behavior: HitTestBehavior.opaque,
                //   onTap: () {},
                //   child:
                // SizedBox(
                //   width: double.infinity,
                //   // height: 200,
                //   height: itemSize,
                //   // child: DropdownButtonHideUnderline(
                //   child: DropdownButton(
                //     value: _selectedGender ?? '',
                //     // customButton:
                //     // Row(
                //     //   crossAxisAlignment: CrossAxisAlignment.center,
                //     //   children: [
                //     //     Image.asset(
                //     //       Assets.genderIcon,
                //     //     ),
                //     //     SizedBox(width: width / 19.63),
                //     //     Text(
                //     //       AppLocalizations.of(context)!.gender,
                //     //       style: const TextStyle(fontSize: 17),
                //     //     ),
                //     //     const Spacer(flex: 1),
                //     //     Text(
                //     //       _selectedGender ?? '',
                //     //       style: const TextStyle(
                //     //           fontSize: 13, color: Colors.grey),
                //     //     ),
                //     //     SizedBox(width: width / 28),
                //     //     const Icon(
                //     //       Icons.arrow_forward_ios_rounded,
                //     //       size: 16,
                //     //       color: MissionDistributorColors.primaryColor,
                //     //     ),
                //     //   ],
                //     // ),
                //     items: ['Male', 'Female'].map((item) {
                //       return DropdownMenuItem<String>(
                //         value: item,
                //         child: Text(item),
                //       );
                //     }).toList(),
                //     // isExpanded: true,
                //     onChanged: (value) {
                //       setState(() {
                //         _selectedGender = value as String;
                //         if (_selectedGender == 'ذكر') {
                //           gender = 'Male';
                //         } else if (_selectedGender == 'انثى') {
                //           gender = 'Female';
                //         }
                //       });
                //     },
                //     // buttonHeight: 40,
                //     itemHeight: 40,
                //   ),
                //   // ),
                // ),
                // ),

                SizedBox(height: height / 18.689),

                // Save
                MyElevatedButton(
                  onPressed: () async {
                    await performUpdateUserInformation();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save,
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
                    Navigator.pushNamed(context, Routes.changePasswordScreen);
                  },
                  child: Text(AppLocalizations.of(context)!.change_password),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> performUpdateUserInformation() async {
    // print(_usernameTextController.text);
    // print(_emailTextController.text);
    // print(_);
    // print(_phoneTextEditingController.text);
    if (checkData()) {
      await updateUserInformation(user: await readData());
    }
  }

  bool checkData() {
    if (checkFieldError()) {
      return true;
    }
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.enter_required_data,
        error: true,
        time: 1);
    return false;
  }

  bool checkFieldError() {
    bool username = checkUsername();
    bool phone = checkPhoneNumber();
    bool gender = checkGender();
    bool birthDate = selectedDate != null;
    setState(() {
      _usernameError =
          !username ? AppLocalizations.of(context)!.enter_username : null;
      _phoneError = !phone ? AppLocalizations.of(context)!.phone_number : null;
      // _addressError = !address ? AppLocalizations.of(context)!.enter_address : null;
      _birthDateError =
          !birthDate ? AppLocalizations.of(context)!.enter_birthdate : null;
    });
    if (username && phone && gender && birthDate) {
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

  bool checkPhoneNumber() {
    if (_phoneTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  // bool checkAddress() {
  //   if (_addressTextEditingController.text.isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }

  bool checkGender() {
    if (_selectedGender != null) {
      return true;
    }
    return false;
  }

  bool checkBirthDate() {
    if (selectedDate != null) {
      return true;
    }
    return false;
  }

  Future<User> readData() async {
    User user = User();
    user.name = _usernameTextController.text;
    user.mobile = _phoneTextEditingController.text;
    user.email = _emailTextController.text;
    user.gender = _selectedGender;
    user.dob = selectedDate;

    if (_pickedFile != null) {
      user.avatar = _pickedFile!.path;
    } else {
      user.avatar = null;
    }
    return user;
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }

  Future<String> uploadImage() async {
    // _changeProgressValue(value: null);
    // return ImageGetXController.to.uploadProfileImage(
    //     uploadListener: ({
    //       message,
    //       reference,
    //       required bool status,
    //       required TaskState taskState,
    //     }) {
    //       if (taskState == TaskState.running) {
    //         _changeProgressValue(value: null);
    //       } else if (taskState == TaskState.success) {
    //         _changeProgressValue(value: 1);
    //         showSnackBar(
    //           context: context,
    //           message:
    //               AppLocalizations.of(context)!.image_uploaded_successfully,
    //         );
    //       } else if (taskState == TaskState.error) {
    //         _changeProgressValue(value: 0);
    //         showSnackBar(
    //             context: context,
    //             message: AppLocalizations.of(context)!.image_uploaded_failed,
    //             error: true);
    //       }
    //     },
    //     file: File(_pickedFile!.path));
    return '';
  }

  Future<void> updateUserInformation({required User user}) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: MissionDistributorColors.primaryColor,
        ),
      ),
    );
    AuthApiController().updateProfile(
        filePath: user.avatar,
        updateProfile: ({
          required String message,
          required bool status,
          User? user,
        }) {
          _changeProgressValue(value: status ? 1 : 0);
          print(message);
          print(status);
          if (status) {
            Navigator.pop(context);
            showSnackBar(
                context: context,
                message:
                    AppLocalizations.of(context)!.profile_update_succeeded);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.homeScreen, (route) => false);
          } else {
            showSnackBar(
                context: context,
                message: AppLocalizations.of(context)!.profile_update_failed,
                error: true);
          }
        },
        user: user);
  }

  Future<void> selectPhotoFromGallery() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  Future<void> capturePhotoFromCamera() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }
}

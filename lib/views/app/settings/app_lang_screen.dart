import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controllers/getX/language_change_notifier_getX.dart';
import '../../../core/res/mission_distributor_colors.dart';

class AppLangScreen extends StatefulWidget {
  const AppLangScreen({Key? key}) : super(key: key);

  @override
  State<AppLangScreen> createState() => _AppLangScreenState();
}

class _AppLangScreenState extends State<AppLangScreen> {
  late double width;
  late double height;
  double itemSize = 800 / 6;

  String? _selectedLanguage;
  final _languagesList = ['العربية', 'English'];

  @override
  void initState() {
    super.initState();
    if (LanguageChangeNotifierGetX.to.languageCode == 'ar') {
      _selectedLanguage = 'العربية';
    } else {
      _selectedLanguage = 'English';
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: MissionDistributorColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.application_language,
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
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              itemSize = height / 15;
            } else {
              itemSize = height / 6;
            }
            return Column(
              children: [
                SizedBox(height: height / 20),
                SizedBox(
                  width: double.infinity,
                  height: itemSize,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      customButton: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 12.27,
                          ),
                          const Icon(
                            Icons.language,
                            color: MissionDistributorColors.primaryColor,
                          ),
                          SizedBox(width: width / 19.63),
                          Text(
                            AppLocalizations.of(context)!.lang,
                            style: const TextStyle(
                              fontSize: 17,
                              color: MissionDistributorColors.primaryColor,
                            ),
                          ),
                          const Spacer(flex: 1),
                          Text(
                            _selectedLanguage ?? '',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                          SizedBox(width: width / 28),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: MissionDistributorColors.primaryColor,
                          ),
                          SizedBox(width: width / 10.9),
                        ],
                      ),
                      items: _languagesList.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      isExpanded: true,
                      value: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          print(value);
                          _selectedLanguage = value as String;
                          if (value == 'English') {
                            LanguageChangeNotifierGetX.to
                                .changeLanguage(languageCode: 'en');
                            print("Selected language value is $value");
                          } else if (value == 'العربية') {
                            LanguageChangeNotifierGetX.to
                                .changeLanguage(languageCode: 'ar');
                          }
                        });
                      },
                      buttonHeight: 40,
                      itemHeight: 40,
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

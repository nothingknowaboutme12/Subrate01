import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:subrate/controllers/getX/payment_gateway_getX_controller.dart';
import 'package:subrate/controllers/storage/local/prefs/user_preference_controller.dart';
import 'package:subrate/controllers/storage/network/api/api_settings.dart';
import 'package:subrate/core/res/assets.dart';
import 'package:subrate/core/res/mission_distributor_colors.dart';
import 'package:subrate/core/utils/helpers.dart';
import 'package:subrate/core/widgets/MyElevatedButton.dart';
import 'package:subrate/models/network_link.dart';
import 'package:http/http.dart' as http;
import '../../../models/authorization_header.dart';
import '../../auth/kyc_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int index;
  const PaymentScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with Helpers {
  final PaymentGatewayGetXController _paymentGatWayGetXController =
      Get.put(PaymentGatewayGetXController());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late TextEditingController accountNumber;
  late TextEditingController amount;
  @override
  void initState() {
    accountNumber = TextEditingController();
    amount = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    accountNumber.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MissionDistributorColors.scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Payment",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MissionDistributorColors.primaryColor,
            size: 26,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      "Setup your ",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: MissionDistributorColors.primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: size.width / 5,
                      height: size.height / 15,
                      child: _paymentGatWayGetXController
                              .paymentGatWays[widget.index].image!.isNotEmpty
                          ? Image.network(
                              NetworkLink(
                                      link: _paymentGatWayGetXController
                                              .paymentGatWays[widget.index]
                                              .image ??
                                          '')
                                  .link,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(Assets.payTmWalletImage),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              customtextfield(
                title: "Enter amount",
                valid: (value) {
                  if (value!.isEmpty) {
                    return "Enter amount for withdraw";
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              customtextfield(
                title: "Enter account number",
                controller: accountNumber,
                valid: (value) {
                  if (value!.isEmpty) {
                    return "Enter account number";
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              MyElevatedButton(
                  // height: buttonHeight / 1.4,
                  // width: width / 3,
                  borderRadiusGeometry: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      MissionDistributorColors.primaryColor,
                      MissionDistributorColors.primaryColor,
                    ],
                  ),
                  onPressed: () {
                    performTransection();
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }

  performTransection() async {
    String token = UserPreferenceController().token;

    if (_formkey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
      var response = await http.post(Uri.parse(ApiSettings.sendpay), body: {
        "payment_gateway_id":
            _paymentGatWayGetXController.paymentGatWays[widget.index].id,
        "amount": amount.value,
        "data": accountNumber.value,
      }, headers: {
        HttpHeaders.authorizationHeader:
            AuthorizationHeader(token: token).token,
      });
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBar(context: context, message: "Data is submit sucessfully");
      }
      Navigator.pop(context);
      showSnackBar(context: context, message: response.statusCode.toString());
    }
  }
}

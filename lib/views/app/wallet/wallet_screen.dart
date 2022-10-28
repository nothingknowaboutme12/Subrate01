import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subrate/core/utils/helpers.dart';
import 'package:subrate/views/auth/kyc_screen.dart';

import '../../../app_localizations.dart';
import '../../../controllers/getX/mission_getX_controller.dart';
import '../../../controllers/getX/payment_gateway_getX_controller.dart';
import '../../../core/res/assets.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/res/routes.dart';
import '../../../core/widgets/MyElevatedButton.dart';
import '../../../models/network_link.dart';
import 'payment_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with Helpers {
  late double width;
  late double height;
  double buttonHeight = 803 / 20;
  bool kyccheck = false;

  final Uri _url = Uri.parse('https://flutter.dev');
  bool isGoButtonVisible = true;

  TextStyle textStyle = const TextStyle(
    color: MissionDistributorColors.primaryColor,
    fontSize: 15,
  );
  checking() async {
    final prefs = await SharedPreferences.getInstance();
    kyccheck = prefs.getBool('isDone') as bool;
  }

  @override
  void initState() {
    checking();

    super.initState();
  }

  final PaymentGatewayGetXController _paymentGatWayGetXController =
      Get.put(PaymentGatewayGetXController());
  int selectedPayouts = -1;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MissionDistributorColors.scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.wallet,
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
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            buttonHeight = height / 16;
          } else {
            buttonHeight = height / 8;
          }
          return Obx(() => ListView(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        top: height / 50, start: width / 20, end: width / 20),
                    height: height / 1.1,
                    alignment: AlignmentDirectional.topCenter,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(69),
                        topEnd: Radius.circular(19),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.pushNamed(
                                      context, Routes.rankScreen);
                                });
                              },
                              child: Container(
                                height: height / 6,
                                decoration: BoxDecoration(
                                  color: MissionDistributorColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          Assets.totalCoinsIconWallet,
                                          width: width / 6,
                                          height: height / 15,
                                          fit: BoxFit.fill,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .total_coins,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                end: width / 50),
                                            child: const Divider(
                                              color: Colors.white,
                                              thickness: 3,
                                            ),
                                          ),
                                          Text(
                                            '${MissionGetXController.to.points.value}',
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height / 60,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.pushNamed(
                                      context, Routes.rankScreen);
                                });
                              },
                              child: Container(
                                height: height / 6,
                                decoration: BoxDecoration(
                                  color: MissionDistributorColors.cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          Assets.totalEarningsIconWallet,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .total_earnings,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                end: width / 50),
                                            child: const Divider(
                                              color: Colors.white,
                                              thickness: 3,
                                            ),
                                          ),
                                          Text(
                                            '${MissionGetXController.to.money.value}\$',
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height / 30),
                        Text(
                          '${AppLocalizations.of(context)!.select_option}!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: height / 200),
                        Text(
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: height / 30),
                        Container(
                          height: height / 4.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView(
                            children: [
                              SizedBox(
                                height: height / 6.5,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width / 40,
                                    vertical: height / 140,
                                  ),
                                  child: ListView.builder(
                                    itemCount: _paymentGatWayGetXController
                                        .paymentGatWays.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedPayouts = index;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                          height: height / 15,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width / 70,
                                            vertical: height / 80,
                                          ),
                                          decoration: BoxDecoration(
                                            color: selectedPayouts == index
                                                ? Colors.grey.shade300
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: width / 19,
                                                height: height / 47.5,
                                                margin:
                                                    EdgeInsetsDirectional.only(
                                                  start: width / 40,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: selectedPayouts ==
                                                          index
                                                      ? MissionDistributorColors
                                                          .primaryColor
                                                      : Colors.grey,
                                                ),
                                                child: Container(
                                                  width: width / 47.5,
                                                  height: height / 110,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width / 30),
                                              Text(_paymentGatWayGetXController
                                                  .paymentGatWays[index].name),
                                              const Spacer(),
                                              SizedBox(
                                                width: width / 5,
                                                height: height / 15,
                                                child:
                                                    _paymentGatWayGetXController
                                                            .paymentGatWays
                                                            .isNotEmpty
                                                        ? Image.network(
                                                            NetworkLink(
                                                                    link: _paymentGatWayGetXController
                                                                            .paymentGatWays[index]
                                                                            .image ??
                                                                        '')
                                                                .link,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.asset(Assets
                                                            .payTmWalletImage),
                                              ),
                                              SizedBox(width: width / 30),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: height / 80),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: width / 4),
                                  child: kyccheck
                                      ? MyElevatedButton(
                                          onPressed: () async {
                                            selectedPayouts >= 0
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PaymentScreen(
                                                        index: selectedPayouts,
                                                      ),
                                                    ),
                                                  )
                                                : showSnackBar(
                                                    context: context,
                                                    message:
                                                        "Please select a payment method",
                                                    error: true);
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!.go,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          height: buttonHeight / 1.4,
                                          width: width / 3,
                                          borderRadiusGeometry:
                                              BorderRadius.circular(10),
                                          gradient: const LinearGradient(
                                            colors: [
                                              MissionDistributorColors
                                                  .primaryColor,
                                              MissionDistributorColors
                                                  .primaryColor,
                                            ],
                                          ),
                                        )
                                      : MyElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => KycScreen(
                                                    isSignUP: false,
                                                    wallet: true),
                                              ),
                                            );
                                          },
                                          child: Text("Valide first"),
                                        )),
                            ],
                          ),
                        ),
                        SizedBox(height: height / 15),
                        MyElevatedButton(
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, Routes.statementsScreen);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.statements,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          height: buttonHeight,
                          width: double.infinity,
                          borderRadiusGeometry: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              MissionDistributorColors.primaryColor,
                              MissionDistributorColors.primaryColor,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}

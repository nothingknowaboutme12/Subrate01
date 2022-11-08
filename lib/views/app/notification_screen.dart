// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:subrate/core/utils/helpers.dart';
// import 'package:subrate/models/Lesson/lesson.dart';
// import 'package:subrate/models/Lesson/lesson_api.dart';
// import 'package:subrate/models/notification/notification.dart';
// import 'package:subrate/views/app/Lesson/lesson_detail_screen.dart';
//
// import '../../controllers/getX/app_getX_controller.dart';
// import '../../controllers/storage/local/prefs/user_preference_controller.dart';
// import '../../core/res/assets.dart';
// import 'package:subrate/models/notification/notification.dart' as noti;
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> with Helpers {
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//
//   bool connection = false;
//   List<noti.Notification> notificatonlist = [];
//   doall() async {
//     notificatonlist = await NotificationApi().getnotification();
//     print(notificatonlist.first);
//     print(notificatonlist.first.title);
//     print(notificatonlist.first.description);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     doall();
//     testConnection();
//     initConnectivity();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }
//
// // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initConnectivity() async {
//     late ConnectivityResult result;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException {
//       showSnackBar(
//           context: context,
//           message: 'Couldn\'t check connectivity status',
//           error: true);
//       return;
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       return Future.value(null);
//     }
//
//     return _updateConnectionStatus(result);
//   }
//
//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     if (mounted)
//       setState(() {
//         _connectionStatus = result;
//       });
//   }
//
//   testConnection() async {
//     final ConnectivityResult result = await Connectivity().checkConnectivity();
//     if (result == ConnectivityResult.mobile ||
//         result == ConnectivityResult.wifi) {
//       connection = true;
//     } else {
//       connection = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     Future.delayed(
//       const Duration(milliseconds: 500),
//       () {
//         if (mounted)
//           setState(() {
//             connection;
//           });
//       },
//     );
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Text(
//           "Notificatons",
//           style: const TextStyle(
//             fontSize: 20,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(30),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: CircleAvatar(
//               radius: 16,
//               backgroundImage:
//                   (UserPreferenceController().userInformation.avatar != ''
//                       ? (_connectionStatus.name != 'none' || connection)
//                           ? NetworkImage(UserPreferenceController()
//                                   .userInformation
//                                   .avatar ??
//                               '')
//                           : AssetImage(Assets.profileImage)
//                       : AssetImage(Assets.profileImage)) as ImageProvider,
//             ),
//             onPressed: () {
//               AppGetXController.to
//                   .changeSelectedBottomBarScreen(selectedIndex: 4);
//             },
//           ),
//           SizedBox(width: width / 70),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await doall();
//         },
//         child: notificatonlist.isNotEmpty
//             ? ListView.builder(
//                 itemCount: notificatonlist.length,
//                 itemBuilder: (context, index) {
//                   print("Here is notification id");
//                   print(notificatonlist[index].id);
//                   return Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           if (notificatonlist[index].id != null) {
//                             print("I am in notification block");
//                             Lesson lesson = await LessonApiController()
//                                 .gettasklesson(
//                                     notificatonlist[index].id.toString());
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       LessonDetailScreen(lessson: lesson),
//                                 ));
//                           }
//                         },
//                         child: ListTile(
//                           title: Text(notificatonlist[index].title.toString()),
//                           subtitle: Text(
//                               notificatonlist[index].description.toString()),
//                         ),
//                       ),
//                       Divider(
//                         color: Colors.grey,
//                       )
//                     ],
//                   );
//                 },
//               )
//             : Center(
//                 child: Text(
//                   _connectionStatus.name != 'none'
//                       ? "You don't have any notification"
//                       : 'Not Have Connection, Please Check Your Internet Connection',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

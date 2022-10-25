import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/Task/do_task.dart';
import '../storage/network/api/controllers/do_mission_api_controller.dart';
import 'mission_getX_controller.dart';

class DoMissionGetXController extends GetxController {
  RxList<DoTask> doMissions = <DoTask>[].obs;
  final DoMissionApiController _doMissionApiController =
      DoMissionApiController();

  static DoMissionGetXController get to => Get.find();

  @override
  void onInit() {
    // read();
    // toDoMission();
    // totalPoint();
    super.onInit();
  }

  Future<void> read() async {
    doMissions.value =
        await _doMissionApiController.getDoMissions() as List<DoTask>;
    await MissionGetXController.to.readRemainingMissions();
  }

  // Future toDoMission()async{
  //   toDoMissions.value = 0;
  //   doneMissions.value = 0;
  //   for(DoMission doMission in doMissions.value){
  //     if(doMission.userId != UserPreferenceController().userInformation.id){
  //       toDoMissions.value++;
  //       for(Mission mission in MissionGetXController().missions.value){
  //         if(mission.id == doMission.missionId){
  //           toDoMissionsList.value.add(mission);
  //         }
  //       }
  //     }else{
  //       toDoMissions.value--;
  //       doneMissions.value++;
  //       for(Mission mission in MissionGetXController().missions.value){
  //         if(mission.id == doMission.missionId){
  //           doneMissionsList.value.add(mission);
  //         }
  //       }
  //     }
  //   }
  //
  // }
  /*
      for (Mission mission in MissionGetXController.to.missions.value) {
      for (DoMission doMission in doMissions.value) {
        if (mission.id == doMission.missionId &&
            doMission.userId == UserPreferenceController().userInformation.id) {
          doneMission.value++;
        } else if (mission.id != doMission.missionId ||
            doMission.userId != UserPreferenceController().userInformation.id) {
          toDoMissions.value++;
        }
        // if (doMission.userId != UserPreferenceController().userInformation.id) {
        //   toDoMissions.value++;
        // } else {
        //   doneMission.value++;
        // }
      }
    }
   */

  Future totalPoint() async {
    // await MissionGetXController.to.read();
    // await read();
    // totalPoints.value = 0;
    // for(DoMission doMission in doMissions.value){
    //   String id = doMission.missionId;
    //   for(Mission mission in MissionGetXController.to.missions){
    //     if(mission.id == id){
    //       totalPoints.value += mission.points;
    //       print(totalPoints.value);
    //       print(mission.points);
    //     }
    //   }
    //   // totalPoints.value += doMission.missionId;
    // }
  }

  Future<bool> storeDoMission(
      {required int missionId, required BuildContext context}) async {
    bool result = await _doMissionApiController.storeDoMission(
        missionId: missionId, context: context);
    if (result) {
      read();
      // toDoMission();
      totalPoint();
    }
    return result;
  }

  Future<void> upload({
    required String filePath,
    required ImageUploadResponse imageUploadResponse,
    required DoTask doMission,
  }) async {
    _doMissionApiController.store(
      filePath: filePath,
      doMission: doMission,
      imageUploadResponse: ({
        required String message,
        required bool status,
        DoTask? doMission,
      }) {
        if (status) {
          doMissions.add(doMission!);
        }
        imageUploadResponse(
            status: status, doMission: doMission, message: message);
      },
    );
  }
}

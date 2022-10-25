class DoTask {
  late String id = '';
  late String date;
  late String missionId;
  late String? screenShot;
  late String userId = '';

  DoTask({
    required this.date,
    required this.missionId,
    required this.screenShot,
  });

  DoTask.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    missionId = json['mission_id'].toString();
    screenShot = json.containsKey('screen_shot') ? json['screen_shot'] : '';
    userId = json['user_id'].toString();
    id = json['id'].toString();
  }
}

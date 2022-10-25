class Task {
  late int id;
  late String adminId;
  late String points;
  late String? title;
  late String? description;
  late String link;
  late String deadLine;
  late String createdAt;
  late String updatedAt;
  List<MissionImage> images = [];
  List<String> steps = [];
  late Pivot? pivot;

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminId = json['admin_id'];
    points = json['points'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    deadLine = json['dead_line'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['images'] != null) {
      images = <MissionImage>[];
      for (Map<String, dynamic> image in json['images']) {
        images.add(MissionImage.fromJson(image));
      }
    }
    if (json['steps'] != null) {
      steps = <String>[];
      for (Map<String, dynamic> step in json['steps']) {
        steps.add(step['title']);
      }
    }
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
}

class Pivot {
  late String groupId;
  late String missionId;

  Pivot.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    missionId = json['mission_id'];
  }
}

class MissionImage {
  late int id;
  late String missionId;
  late String name;
  late String createdAt;
  late String updatedAt;

  MissionImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    missionId = json['mission_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

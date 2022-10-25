class Lesson {
  int? id;
  String? title;
  String? description;
  String? link;
  String? image;
  String? type;
  String? category;
  String? created_at;
  String? updated_at;

  Lesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    image = json['image'];
    category = json['category'];
    type = json['type'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}

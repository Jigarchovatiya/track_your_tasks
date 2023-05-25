import 'dart:convert';

ToDoModel toDoModelFromJson(String str) => ToDoModel.fromJson(json.decode(str));

String toDoModelToJson(ToDoModel data) => json.encode(data.toJson());

class ToDoModel {
  String? title;
  String? description;
  String? time;

  ToDoModel({
    this.title,
    this.description,
    this.time,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        title: json["title"],
        description: json["description"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "time": time,
      };
}

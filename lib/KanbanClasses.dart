// To parse this JSON data, do
//
//     final story = storyFromJson(jsonString);

import 'dart:convert';

List<Story> storyFromJson(String str) =>
    List<Story>.from(json.decode(str).map((x) => Story.fromMap(x)));

String storyToJson(List<Story> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Story> storyFromFirebase(var firebaseDocument) {
  return List<Story>.from(
      firebaseDocument.data['stories'].map((e) => Story.fromMap(e)));
}

List<String> initList(Map<String, dynamic> json, String label) {
  var list = List<String>.from(json[label]);
  return list == null ? List() : list;
}

class Story {
  String title;
  List<String> toDo;
  List<String> inProgress;
  List<String> testing;
  List<String> done;

  Story({
    this.title,
    this.toDo,
    this.inProgress,
    this.testing,
    this.done,
  });

  factory Story.fromMap(Map<String, dynamic> json) => Story(
        title: json["title"],
        toDo: initList(json, "to_do"),
        inProgress: initList(json, "in_progress"),
        testing: initList(json, "testing"),
        done: initList(json, "done"),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "to_do": List<dynamic>.from(toDo.map((x) => x)),
        "in_progress": List<dynamic>.from(inProgress.map((x) => x)),
        "testing": List<dynamic>.from(testing.map((x) => x)),
        "done": List<dynamic>.from(done.map((x) => x)),
      };

  Map<String,List<String>> get map {
    return {
      "to_do": toDo,
      "in_progress": inProgress,
      "testing":testing,
      "done": done,
    };
  }
}

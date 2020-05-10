// To parse this JSON data, do
//
//     final story = storyFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

//List<Story> storyFromFirebase(DocumentSnapshot firebaseDocument) {
//  return List<Story>.from(
//      firebaseDocument.data['stories'].map((e) => Story.fromMap(e, reference: firebaseDocument.reference)));
//}

List<String> initList(Map<String, dynamic> json, String label) {
  var list = List<String>.from(json[label]);
  return list == null ? List() : list;
}

class Document {
  List<Story> stories;
  final DocumentReference reference;

  Document.fromSnapshot(DocumentSnapshot snapshot)
      : stories = List<Story>.from(snapshot.data['stories']
      .map((s) => Story.fromMap(s, reference: snapshot.reference))),
        reference = snapshot.reference;

  Map<String, dynamic> toJson() => {
    'stories': List.from(stories.map((s) => s.toJson()))
  };

  void updateRemote() {
    reference.updateData(toJson());
  }

}

class Story {
  String title;
  List<String> toDo;
  List<String> inProgress;
  List<String> testing;
  List<String> done;
  final DocumentReference reference;
  final Document document;

  Story.fromMap(Map<String, dynamic> map, {this.reference, this.document})
      : title = map["title"],
        toDo = initList(map, "to_do"),
        inProgress = initList(map, "in_progress"),
        testing = initList(map, "testing"),
        done = initList(map, "done");

  Map<String, List<String>> get map {
    return {
      "to_do": toDo,
      "in_progress": inProgress,
      "testing": testing,
      "done": done,
    };
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "to_do": List<String>.from(toDo.map((x) => x)),
    "in_progress": List<String>.from(inProgress.map((x) => x)),
    "testing": List<String>.from(testing.map((x) => x)),
    "done": List<String>.from(done.map((x) => x)),
  };

}

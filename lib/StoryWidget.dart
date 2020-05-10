import 'package:flutter/material.dart';
import 'package:kanban_organizer/KanbanClasses.dart';

class StoryWidget extends StatefulWidget {
  Story story;
  final Document doc;

  StoryWidget(this.story, this.doc);

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {

  Map<int, String> sectionList = {
    0: 'to_do',
    1: 'in_progress',
    2: 'testing',
    3: 'done'
  };


  _StoryWidgetState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.story.title),
        ),
        body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: initContainer(Colors.blue, 0),
                ),
                Expanded(
                  flex: 1,
                  child: initContainer(Colors.green, 1),
                ),
                Expanded(
                  flex: 1,
                  child: initContainer(Colors.yellow, 2),
                ),
                Expanded(
                  flex: 1,
                  child: initContainer(Colors.black, 3),
                ),
              ],
            )));
  }

  Widget initContainer(Color color, int section) {
    return Container(
      color: color,
      child: taskView(section),
    );
  }

  Widget taskView(int section) {
    List<String> tasks = widget.story.map[sectionList[section]];
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => moveTaskToNextSection(section, index),
            child: Card(
              child: Text(tasks[index]),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: tasks.length);
  }

  void moveTaskToNextSection(int originSection, int originIndex) {
    List<String> originTaskList = widget.story.map[sectionList[originSection]];
    List<String> arrivalTaskList = widget.story.map[sectionList[(originSection+1)%4]];
    setState(() {
      var task = originTaskList.removeAt(originIndex);
      arrivalTaskList.add(task);
    });

    widget.doc.updateRemote();
  }
}

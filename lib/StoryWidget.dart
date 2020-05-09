import 'package:flutter/material.dart';

class StoryWidget extends StatefulWidget {
  var data;

  StoryWidget(this.data);

  @override
  _StoryWidgetState createState() => _StoryWidgetState(data);
}

class _StoryWidgetState extends State<StoryWidget> {
  var data;

  _StoryWidgetState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(data['title']),
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
                child: initTargetContainer('to_do'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
                child: initTargetContainer('in_progress'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.yellow,
                child: initTargetContainer('testing'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black,
                child: initTargetContainer('done'),
              ),
            ),
          ],
        )));
  }

  Widget initTargetContainer(section) {
    var taskView2 = taskView(section);
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return taskView2;
      },
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          data[section].add(data);
        });
      },
    );
  }

  Widget taskView(section) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Draggable(
            child: Card(
              child: Text(data[section][index]),
            ),
            feedback: Card(
              child: Text(data[section][index]),
            ),
            childWhenDragging: Container(),
            data: [data[section][index]],
            onDragCompleted: null,
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data[section].length
    );
  }
}

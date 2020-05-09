import 'package:flutter/material.dart';

class StoryWidget extends StatefulWidget {
  var data;

  StoryWidget(this.data);

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.data['title']),
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
                child: taskView('to_do'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
                child: taskView('in_progress'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.yellow,
                child: taskView('testing'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black,
                child: taskView('done'),
              ),
            ),
          ],
        )));
  }

  Widget taskView(section) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Card(
            child: Text(widget.data[section][index]),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: widget.data[section].length);
  }
}

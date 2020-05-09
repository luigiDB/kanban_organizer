import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'KanbanClasses.dart';
import 'StoryWidget.dart';

class StoriesWidget extends StatefulWidget {
  @override
  _StoriesWidgetState createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Backlog'),
      ),
      body: Center(
        child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('kanban').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        var document = snapshot.data.documents[1];
        List<Story> stories = storyFromFirebase(document);
        return ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryWidget(stories[index]),
                      )
                  ),
                  child: Card(
                    child: Text(stories[index].title),)
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: stories.length,
        );
      },
    );
  }
}

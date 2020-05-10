import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'KanbanClasses.dart';
import 'StoryWidget.dart';

class StoriesWidget extends StatefulWidget {
  @override
  _StoriesWidgetState createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  Document doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Backlog'),
        ),
        body: Center(child: _buildBody(context)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewStory(context);
          },
          child: Icon(Icons.add),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('kanban').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        doc = Document.fromSnapshot(snapshot.data.documents[1]);
        return ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StoryWidget(doc.stories[index], doc),
                    )),
                child: Card(
                  child: Text(doc.stories[index].title),
                ),
              onLongPress: () {
                setState(() {
                  doc.stories.removeAt(index);
                });
                doc.updateRemote();
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: doc.stories.length,
        );
      },
    );
  }

  void createNewStory(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final myController = TextEditingController();
    showDialog(
      context: context,
      builder: (cntx) {
        return AlertDialog(
          title: Text("New Story"),
          content: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: myController,
                    validator: (value) {
                      if (value.isEmpty)
                        return "Not Valid";
                      else
                        return null;
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        doc.stories.add(Story.empty(myController.text));
                        doc.updateRemote();
                        Navigator.pop(cntx);
                      }
                    },
                    child: Text("Add"),
                  )
                ],
              )),
        );
      },
    );
  }
}

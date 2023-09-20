import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final title = TextEditingController();
  final content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('notes').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              final notes = snapshot.data!.docs;
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index].get('title')),
                    subtitle: Text(notes[index].get('content')),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Column(
                                    children: [
                                      Text('Update Note'),
                                      TextField(
                                        controller: title,
                                        decoration:
                                            InputDecoration(hintText: "Title"),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextField(
                                        controller: content,
                                        decoration: InputDecoration(
                                            hintText: "Content"),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: Colors.red,
                                      child: Text("cancle"),
                                    ),
                                    MaterialButton(
                                      color: Colors.green,
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('notes')
                                            .doc(notes[index].id)
                                            .update({
                                          'title': title.text,
                                          'content': content.text
                                        });
                                        Navigator.pop(context);
                                        title.clear();
                                        content.clear();
                                      },
                                      child: Text('update'),
                                    )
                                  ],
                                ),
                              );
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title:
                                      Text("Do you want to delete this note?"),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: Colors.red,
                                      child: Text("No"),
                                    ),
                                    MaterialButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('notes')
                                            .doc(notes[index].id)
                                            .delete();
                                        Navigator.pop(context);
                                        title.clear();
                                        content.clear();
                                      },
                                      color: Colors.green,
                                      child: Text("Yes"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Column(
                children: [
                  Text('Add Note'),
                  TextField(
                    controller: title,
                    decoration: InputDecoration(hintText: "Title"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: content,
                    decoration: InputDecoration(hintText: "Content"),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                  child: Text("Cancle"),
                ),
                MaterialButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('notes')
                        .add({'title': title.text, 'content': content.text});
                    Navigator.pop(context);
                    title.clear();
                    content.clear();
                  },
                  color: Colors.green,
                  child: Text('Add'),
                )
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

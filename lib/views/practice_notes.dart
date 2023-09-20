// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// class NotesDemo extends StatefulWidget {
//   const NotesDemo({Key? key}) : super(key: key);
//
//   @override
//   State<NotesDemo> createState() => _NotesDemoState();
// }
//
// class _NotesDemoState extends State<NotesDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('notes111').snapshots(),
//         builder: (BuildContext, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//           if(snapshot.hasData){
//             return ListView.builder(itemBuilder: (context, index) => ListTile(
//               title: Text(),
//
//             ),)
//           }else{
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

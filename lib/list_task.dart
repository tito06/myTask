import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ListTask extends StatelessWidget{
   ListTask({super.key});


String? name = FirebaseAuth.instance.currentUser?.displayName;

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref("${FirebaseAuth.instance.currentUser?.displayName}");

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Task List'),
          leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        )),
        
        body: FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
                 
                
            return ListTile(
            
            
              title: (snapshot.value != null) ? Text(databaseRef.child("name").toString()) : Text("No Data"),
              subtitle: Text(snapshot.children.last.value.toString()),
            );
          },
        ),
      ),
    );
  }
  
}
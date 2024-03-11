import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_task/list_task.dart';
import 'package:my_task/register.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreateTask extends StatelessWidget{
   CreateTask({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController task = TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Create Task"),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          )),),
        
        body: Center(
          child: Column(
            children: [
              Text("NAME:"),
               Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child:  TextField(
                controller: name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),  
                      labelText: 'Name',  
                    ),  
              )),

               Text("TASK:"),
               Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child:  TextField(
                controller: task,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),  
                      labelText: 'Task',  
                    ),  
              )),

              Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child :Container(  
              margin: const EdgeInsets.all(0), 
              width: double.infinity, 
              height: 50.0,
              child: ElevatedButton(
                child: const Text('Create',
                 style: TextStyle(fontSize: 20.0,
                  color: Color.fromARGB(254, 255, 255, 255)),),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 154, 51, 232)
                ),
                onPressed: () async{
  
                  final prefs = await SharedPreferences.getInstance();
                  String? userid =prefs.getString("userid");
                  if(FirebaseAuth.instance.currentUser?.uid != null){
                    
                    String? email = FirebaseAuth.instance.currentUser?.uid.toString();
                    String? userName = FirebaseAuth.instance.currentUser?.displayName;

                   await ref.child("$userName").push().set(
                {
                  "name": name.value.text,
                  "task": task.value.text
                });


                Navigator.push(context, MaterialPageRoute(builder: (context)=> ListTask()));
                 
                  } else {
                    print("object");
                  }           
                },
              ))),
             Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child :Container(  
              margin: const EdgeInsets.all(0), 
              width: double.infinity, 
              height: 50.0,
              child: ElevatedButton(
                child: const Text('Sign Out',
                 style: TextStyle(fontSize: 20.0,
                  color: Color.fromARGB(254, 255, 255, 255)),),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 154, 51, 232)
                ),
                onPressed: () {
                 _signOut(); 

                

                },
              )))

            ],
          ),
        ),),
    );
  }


  Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
  
}
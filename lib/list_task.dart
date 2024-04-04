
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ListTask extends StatelessWidget{
   ListTask({super.key});


String? name = FirebaseAuth.instance.currentUser?.displayName;

 // DatabaseReference databaseRef = FirebaseDatabase.instance.ref("${FirebaseAuth.instance.currentUser?.displayName}");

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child("${FirebaseAuth.instance.currentUser?.displayName}");



  @override
  Widget build(BuildContext context) {


        return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 203, 156, 239),
          title: Text('Task List'),
          leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        )),
        
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromARGB(255, 203, 156, 239),
          child: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                 decoration: const BoxDecoration(
                  color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(20.0),
        ),
        
      ),
      child: FirebaseAnimatedList(
          query: databaseRef.orderByChild("date"),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
                 
        final Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;


                
            return CardViewData(context,
            data != null ? data["name"] : "NO DATA",
             data != null? data["task"] : "NO DATA",
             data != null? data["date"]: "No date added",
             data != null? data["time"]: "No time added");
          },
        ),
          ),
        )
        
        
      ),
    ));
  }

    Widget CardViewData(BuildContext context, name, String task, String date, String time){
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      child: ConstrainedBox(
        constraints: (
          BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: 100,
          )
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(name,
              style:const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 22.0

            
              ),),
              Text(task,
              style: const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              ),),
              Text(date,
              style: const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              ),),
              Text(time,
              style: const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              ),)  
            ]),),
      ),
    );
  
  
}

}
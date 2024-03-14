import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:my_task/create_task.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _homePagestate();
  
}


class _homePagestate extends State<HomePage>{


    int _selectedTab = 0;

    String? email = FirebaseAuth.instance.currentUser?.displayName;

    List<String> dataList = [];

   //DatabaseReference databaseRef = FirebaseDatabase.instance.ref("${FirebaseAuth.instance.currentUser?.displayName}");

   DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child("${FirebaseAuth.instance.currentUser?.displayName}");

   


  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
      if(index == 1){
        Navigator.push(context, MaterialPageRoute(builder:(context)=> CreateTask()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

      var name = FirebaseAuth.instance.currentUser?.displayName;
           print(name);

    return Scaffold(
    
      appBar: AppBar(
        leading: SizedBox(
          height: 8.0,
          width: 8.0,
          child: IconButton(onPressed: (){},
         icon: Image.asset('assets/side_menu.png'))
        ),
        backgroundColor:const Color.fromARGB(255, 203, 156, 239),
        actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.circle_outlined),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('This is a Appbar Icon example')));
                },
              ),
            ]
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 203, 156, 239),

        child: SingleChildScrollView(
        child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
          children: [

                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hey, $name",
                    style: const TextStyle(fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),),
                    const Text("you have 7 tasks today.",
                    style: TextStyle(fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),)
                  ]),
                ),
        

             Container(
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

       child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text("Today",
                  
                style:  TextStyle(fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              color: Colors.black87
            
                )),

                 Icon(Icons.calendar_month_outlined)  
                    ],
                  )
                ),
                Expanded(
                  child:  FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
                 
              final Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;

               var date = data!= null ? data["date"] : DateTime.now();

            return 
            
            ListTile(
              
               
              title: (data != null) ? Text("${data["name"]}",
              style:const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              ),) : const Text("No Data",
              style: TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.w900,
              ),),
              subtitle: (data != null) ? Text("${data["task"]}",
              style: const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              ),) : const Text("No Data",
              style: TextStyle(fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,),),
            );
            
          },
        ), )
              ],
            ),

            
             
           )),

          ])),
      ),

        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 203, 156, 239),
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Color.fromARGB(255, 164, 65, 240),
        unselectedItemColor: Color.fromARGB(255, 59, 1, 104),
        items: [
          BottomNavigationBarItem(icon: Image.asset('assets/home.png',
          height: 25,
          width: 25,), label: "Home"),
          BottomNavigationBarItem(icon: Image.asset('assets/add.png',
          height: 25,
          width: 25,), label: "Create Task"),
          BottomNavigationBarItem(
              icon: Image.asset('assets/upcoming.png',
              height: 25,
          width: 25,), label: "Upcomming task"),
         
        ],
      ),
    );
  }

  
  
}
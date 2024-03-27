import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_task/create_task.dart';
import 'package:my_task/list_task.dart';
import 'package:my_task/login.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _homePagestate();
  
}


class _homePagestate extends State<HomePage>{


    int _selectedTab = 0;

    String? email = FirebaseAuth.instance.currentUser?.displayName;


    String? date = DateFormat.yMMMEd().format(DateTime.now());
    var dataDate;

    List<String> dataList = [];

   //DatabaseReference databaseRef = FirebaseDatabase.instance.ref("${FirebaseAuth.instance.currentUser?.displayName}");

   DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child("${FirebaseAuth.instance.currentUser?.displayName}");

   


  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
      if(index == 1){
        Navigator.push(context, MaterialPageRoute(builder:(context)=> CreateTask()));
      } else if( index == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ListTask()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

      var name = FirebaseAuth.instance.currentUser?.displayName;

    return Scaffold(
    
      appBar: AppBar(
        
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
      drawer: Drawer(
        child: ListView(
          children:[
            const DrawerHeader(child: Text("Header")),

            ListTile(
              title: Text('Log Out'),
              onTap: (){
                  _signOut(context);
              },
            )
          ],
        ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(date == DateFormat.yMMMEd().format(DateTime.now()) || date == null ? "TODAY": date!,
                  
                style: const TextStyle(fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              color: Colors.black87
            
                )),

                IconButton(onPressed: (){
                    _selectDate(context);
                },
                 icon: Icon(Icons.calendar_month_outlined))
                    ],
                  )
                ),
                Expanded(
                  child:  FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
                 
              final Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;

              if(data!= null){
                
                 dataDate = data["date"];
                  
               
              }

            return ( dataDate == date)?
             CardViewData(data != null? data["name"] : "NO DATA",
             data != null? data["task"] : "NO DATA",
             data != null? data["date"]: "No date added",
             data != null? data["time"]: "No time added") : const SizedBox();
            
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

  Widget CardViewData(String name, String task, String date, String time){
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      child: ConstrainedBox(
        //width: MediaQuery.of(context).size.width,
        //height: 120,
        constraints: (
          BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: 100,
          )
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(name,
              style:const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            
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

    Future<void> _signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
}

  _selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, picker) {
        return Theme(
          data: ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.dark(
        primary: Colors.deepPurple,
        onPrimary: Colors.white,
        surface: Color.fromARGB(255, 203, 156, 239),
        onSurface: Colors.black),
        dialogBackgroundColor:Colors.green[900],
          ),
           child: picker!,);
      }).then((value){
        if(value != null){
          setState(() {
            String formattedDate = DateFormat.yMMMEd().format(value);

          
            date = formattedDate;
          

          });
        }
      });
      
      
  }

  
  
}
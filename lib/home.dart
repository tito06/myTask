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
    String dataDate= "";

    List<Map<dynamic, dynamic>> sortedData = [];


    var noData = 0;


   DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child("${FirebaseAuth.instance.currentUser?.displayName}");

  void _getDataFromFirebase() {

    databaseRef.once().then((DatabaseEvent dataSnapshot) {
     sortedData.clear();

     Map<dynamic, dynamic> values = dataSnapshot.snapshot.value as Map<dynamic, dynamic>;

     values.forEach((key, value) {
      sortedData.add(value);
     });
           sortedData.sort((a,b){

          // Parse the original date string
    DateFormat originalFormat = DateFormat("E, MMM dd, yyyy");
    DateTime parsedDateA = originalFormat.parse(a['date']);
    DateTime parsedDateB = originalFormat.parse(b['date']);


  // Format the parsed date to the desired format
  DateFormat desiredFormat = DateFormat("yyyy-MM-dd");
  String formattedDateA = desiredFormat.format(parsedDateA);
    String formattedDateB = desiredFormat.format(parsedDateB);



        var dateFormat = DateFormat("yyyy-MM-dd");
        var dateA = dateFormat.parse(formattedDateA);
        var dateB = dateFormat.parse(formattedDateB);
        return dateA.compareTo(dateB);

      });
      setState(() {});
    });
  }


    getDataCount(String date) async {

  
      if(sortedData.isNotEmpty){
     
       for(int i= 0; i< sortedData.length; i++){
        if(sortedData[i]['date'] == date){
          setState(() {
          noData++;

          });
        } 
       }
      
      }
      

      print("noData-> ${noData}");
      return noData;
    }

    @override
    void initState(){
      super.initState();
      noData =0;
      _getDataFromFirebase();
      getDataCount(date!);
    }


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
                    fontWeight: FontWeight.w300),),
                    Text("you have $noData ${(noData==1 || noData == 0)? "task" : "tasks"} ${(dataDate != "")? "": "today" }.",
                    style: const TextStyle(fontSize: 18,
                    fontFamily: 'Montserrat'
                    ),)
                  ]),
                ),
        

             Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
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
              fontWeight: FontWeight.w200,
              color: Colors.black87
            
                )),

                IconButton(onPressed: (){
                    _selectDate(context);
                },
                 icon: const Icon(Icons.calendar_month_outlined))
                    ],
                  )
                ),
                Expanded(
                  child: 
                  
                   FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
                 
              final Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
              if(data!= null){

    
                   data['key'] = snapshot.key;

                 dataDate = data["date"];
                  getDataCount(date.toString());
            }



            return ( dataDate == date)?
             CardViewData(data!) : const SizedBox();
            
          },
        ),
        
        
         )
              ],
            ),

            
             
           )),

          ])),
      ),

        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 203, 156, 239),
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor:const Color.fromARGB(255, 164, 65, 240),
        unselectedItemColor: const Color.fromARGB(255, 59, 1, 104),
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

  Widget CardViewData(Map data){
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
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(data['name'],
              style:const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 22.0
            
              ),),
              Text(data['task'],
              style: const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              ),),
              Text(data['date'],
              style: const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              ),),
              Text(data['time'],
              style: const TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              ),)   
            ]),

            IconButton(onPressed: (){
                databaseRef.child(data['key']).remove();
            }, 
            icon:const Icon(Icons.delete))
            

            ],
          )),
      ),
    );
  }

    Future<void> _signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login()), (route) => false);
}

  _selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
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

            noData = 0;
            
          
            getDataCount(date.toString());

          });
        }
      });
      
      
  }

  
  
}
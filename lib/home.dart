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


   DatabaseReference databaseRef = FirebaseDatabase.instance.ref("${FirebaseAuth.instance.currentUser?.displayName}");


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
        backgroundColor: Color.fromARGB(255, 203, 156, 239),
        title: Text("Hey, ${name}", style: TextStyle(fontSize: 20),),
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
      body: SingleChildScrollView(
        child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                 decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 203, 156, 239),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        
      ),
                child: const Padding(padding: EdgeInsets.all(8),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back",
                    style: TextStyle(fontSize: 20),),
                     Text("you have 7 tasks today.",
                    style: TextStyle(fontSize: 20),)
                  ]),)
              ),


        const  Padding(padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
          child: Text("Today's Task",
              style: TextStyle(fontSize: 20),),
          ),

           SizedBox(
            height: 400,
            child:Padding(padding: EdgeInsets.fromLTRB(0,8,0,0),
            child:   FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
                 
                
            return ListTile(
              
            
              title: (snapshot.value != null) ? Text(snapshot.children.first.value.toString()) : Text("No Data"),
              subtitle: Text(snapshot.children.last.value.toString()),
            );
          },
        ),   
           )),

          const Padding(padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
          child: Text("Upcoming Task",
              style: TextStyle(fontSize: 20),),
          ),
    


          ])),
         bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 203, 156, 239),
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Color.fromARGB(255, 164, 65, 240),
        unselectedItemColor: Color.fromARGB(255, 59, 1, 104),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Create Task"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded), label: "Profile"),
         
        ],
      ),
    );
  }

  
  
}
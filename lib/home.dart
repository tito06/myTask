import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:intl/intl.dart';
import 'package:my_task/create_task.dart';
import 'package:my_task/list_task.dart';
import 'package:my_task/login.dart';
import 'package:my_task/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _homePagestate();
}

class _homePagestate extends State<HomePage> {
  int _selectedTab = 0;

  String? _name;
  String? _profileImageUrl;

  User? user = FirebaseAuth.instance.currentUser;

  String? email = FirebaseAuth.instance.currentUser?.displayName;

  String? date = DateFormat.yMMMEd().format(DateTime.now());
  String dataDate = "";

  List<Map<dynamic, dynamic>> sortedData = [];

  var noData = 0;

  DatabaseReference databaseRef = FirebaseDatabase.instance
      .ref()
      .child("${FirebaseAuth.instance.currentUser?.displayName}");

  Future<void> _getDataFromFirebase() async {
    if (user == null) {
      print('User is not authenticated.');
      return;
    }

    String userId = user!.uid;

    DatabaseReference dbRef = FirebaseDatabase.instance.ref('users/$userId');

    try {
      DataSnapshot snapshot = await dbRef.get();

      if (snapshot.exists) {
        // Cast to a more general Map first
        Map<Object?, Object?> userData =
            snapshot.value as Map<Object?, Object?>;

        // Convert to Map<String, dynamic> safely
        Map<String, dynamic> formattedUserData = userData.map((key, value) {
          return MapEntry(key.toString(), value);
        });

        // Extract the user information
        String userName = formattedUserData['name'] ?? 'Unknown';
        String profileImageUrl = formattedUserData['profileImageUrl'] ?? '';

        // Update state to reflect profile data
        setState(() {
          _name = userName;
          _profileImageUrl = profileImageUrl;
        });
      } else {
        print('No user profile data available.');
      }
    } catch (e) {
      print('Error fetching user profile data: $e');
    }

    databaseRef.once().then((DatabaseEvent dataSnapshot) {
      sortedData.clear();

      Map<dynamic, dynamic> values =
          dataSnapshot.snapshot.value as Map<dynamic, dynamic>;

      values.forEach((key, value) {
        sortedData.add(value);
      });
      sortedData.sort((a, b) {
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
    if (sortedData.isNotEmpty) {
      for (int i = 0; i < sortedData.length; i++) {
        if (sortedData[i]['date'] == date) {
          setState(() {
            noData++;
          });
        }
      }
    }

    print("noData-> $noData");
    return noData;
  }

  @override
  void initState() {
    super.initState();
    noData = 0;
    _getDataFromFirebase();
    getDataCount(date!);
  }

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
      if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateTask()));
      } else if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListTask()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var name = FirebaseAuth.instance.currentUser?.displayName;

    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 174, 218, 246),
                  Color.fromARGB(255, 157, 160, 234)
                ], // Colors for the gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: _profileImageUrl != null
                      ? ClipOval(
                          child: Image.network(
                            _profileImageUrl!,
                            width: 50.0, // Same as container width
                            height: 50.0, // Same as container height
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(child: Icon(Icons.man_2_rounded))),
            ),
          ]),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text("Header")),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                _signOut(context);
              },
            )
          ],
        ),
      ),
      body: BottomBar(
        // Define the floating widget

        // Main content of the screen
        body: (context, controller) => Body(name, controller),
        showIcon: true,
        barColor:
            Colors.transparent, // Make barColor transparent to show gradient
        barDecoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 174, 218, 246),
              Color.fromARGB(255, 157, 160, 234)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Define the navigation tabs
                  GestureDetector(
                    onTap: () => _changeTab(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/home.png',
                          height: 25,
                          width: 25,
                        ),
                        //const Text("Home"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _changeTab(1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/add.png',
                          height: 45,
                          width: 45,
                        ),
                        //const Text("Create Task"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _changeTab(2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/upcoming.png',
                          height: 25,
                          width: 25,
                        ),
                        //const Text("Upcoming Task"),
                      ],
                    ),
                  ),
                ])),
      ),

      // Define the navigation tabs
    );
  }

  Widget Body(String? name, ScrollController controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 174, 218, 246),
            Color.fromARGB(255, 157, 160, 234)
          ], // Colors for the gradient
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey, $_name",
                      style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "you have $noData ${(noData == 1 || noData == 0) ? "task" : "tasks"} ${(dataDate != "") ? "" : "today"}.",
                      style: const TextStyle(
                          fontSize: 18, fontFamily: 'Montserrat'),
                    )
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
                              Text(
                                  date ==
                                              DateFormat.yMMMEd()
                                                  .format(DateTime.now()) ||
                                          date == null
                                      ? "TODAY"
                                      : date!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black87)),
                              IconButton(
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                  icon:
                                      const Icon(Icons.calendar_month_outlined))
                            ],
                          )),
                      Expanded(
                        child: FirebaseAnimatedList(
                          query: databaseRef,
                          itemBuilder: (BuildContext context,
                              DataSnapshot snapshot,
                              Animation<double> animation,
                              int index) {
                            final Map<dynamic, dynamic>? data =
                                snapshot.value as Map<dynamic, dynamic>?;
                            if (data != null) {
                              data['key'] = snapshot.key;

                              dataDate = data["date"];
                              getDataCount(date.toString());
                            }

                            return (dataDate == date)
                                ? CardViewData(data!)
                                : const SizedBox();
                          },
                        ),
                      )
                    ],
                  ),
                )),
          ])),
    );
  }

  Widget CardViewData(Map data) {
    return Card(
      elevation: 50,
      child: ConstrainedBox(
        constraints: (BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: 100,
        )),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'],
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 22.0),
                      ),
                      Text(
                        data['task'],
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        data['date'],
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        data['time'],
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]),
                IconButton(
                    onPressed: () {
                      databaseRef.child(data['key']).remove();
                    },
                    icon: const Icon(Icons.delete))
              ],
            )),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
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
              dialogBackgroundColor: Colors.green[900],
            ),
            child: picker!,
          );
        }).then((value) {
      if (value != null) {
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

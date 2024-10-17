import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_task/home.dart';

class ListTask extends StatefulWidget {
  const ListTask({super.key});

  @override
  State<StatefulWidget> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  String? name = FirebaseAuth.instance.currentUser?.displayName;

  // DatabaseReference databaseRef = FirebaseDatabase.instance.ref("${FirebaseAuth.instance.currentUser?.displayName}");

  DatabaseReference databaseRef = FirebaseDatabase.instance
      .ref()
      .child("${FirebaseAuth.instance.currentUser?.displayName}");

  List<Map<dynamic, dynamic>> sortedData = [];

  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
  }

  void _getDataFromFirebase() {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
          title: const Text('Task List'),
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          )),
      body: Container(
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
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                  ),
                ),
                child: sortedData.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: sortedData.length,
                        itemBuilder: (context, index) {
                          return CardViewData(
                              context,
                              sortedData != null
                                  ? sortedData[index]["name"]
                                  : "NO DATA",
                              sortedData != null
                                  ? sortedData[index]["task"]
                                  : "NO DATA",
                              sortedData != null
                                  ? sortedData[index]["date"]
                                  : "No date added",
                              sortedData != null
                                  ? sortedData[index]["time"]
                                  : "No time added");
                        })),
          )),
    ));
  }

  Widget CardViewData(
      BuildContext context, name, String task, String date, String time) {
    return Card(
      elevation: 10,
      child: ConstrainedBox(
        constraints: (BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: 100,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0),
                ),
                Text(
                  task,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

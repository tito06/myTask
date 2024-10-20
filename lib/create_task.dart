import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:my_task/list_task.dart';
import 'package:my_task/login.dart';
import 'package:my_task/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTask extends StatelessWidget {
  CreateTask({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController task = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.ref();

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
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
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
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 20),
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add new task.",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(5, 30, 0, 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 13.0),
                              child: Container(
                                  height: 70.0,
                                  decoration: const BoxDecoration(
                                    color: Colors
                                        .white, // Background color of the container

                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.0),
                                        bottomRight: Radius.circular(50.0),
                                        bottomLeft: Radius.circular(50)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black, // Shadow color
                                        blurRadius: 5.0, // Shadow blur radius
                                        offset: Offset(0, 2), // Shadow offset
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        controller: name,
                                        decoration: const InputDecoration(
                                          labelText: 'Name',
                                          border: InputBorder.none,
                                        ),
                                      )))),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 13.0),
                              child: Container(
                                  height: 70.0,
                                  decoration: const BoxDecoration(
                                    color: Colors
                                        .white, // Background color of the container

                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.0),
                                        bottomRight: Radius.circular(50.0),
                                        bottomLeft: Radius.circular(50)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black, // Shadow color
                                        blurRadius: 5.0, // Shadow blur radius
                                        offset: Offset(0, 2), // Shadow offset
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        controller: task,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Task',
                                        ),
                                      )))),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 13.0),
                              child: Container(
                                  height: 70.0,
                                  decoration: const BoxDecoration(
                                    color: Colors
                                        .white, // Background color of the container

                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.0),
                                        bottomRight: Radius.circular(50.0),
                                        bottomLeft: Radius.circular(50)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black, // Shadow color
                                        blurRadius: 5.0, // Shadow blur radius
                                        offset: Offset(0, 2), // Shadow offset
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        controller: date,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Date',
                                        ),
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                      )))),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 13.0),
                              child: Container(
                                  height: 70.0,
                                  decoration: const BoxDecoration(
                                    color: Colors
                                        .white, // Background color of the container

                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.0),
                                        bottomRight: Radius.circular(50.0),
                                        bottomLeft: Radius.circular(50)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black, // Shadow color
                                        blurRadius: 5.0, // Shadow blur radius
                                        offset: Offset(0, 2), // Shadow offset
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        controller: time,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Select time',
                                        ),
                                        onTap: () {
                                          showTimePicker(
                                            initialEntryMode:
                                                TimePickerEntryMode.dial,
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            cancelText: "Cancel",
                                            confirmText: "Save",
                                            helpText: "Select time",
                                            builder: (context, Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            false),
                                                child: child!,
                                              );
                                            },
                                          ).then((value) {
                                            if (value != null) {
                                              TimeOfDay setTime = value;
                                              time.text = setTime
                                                  .format(context)
                                                  .toString();
                                            }
                                          });
                                        },
                                      )))),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 13.0),
                              child: Container(
                                  width: double.infinity,
                                  height: 70.0,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 174, 218, 246),
                                          Color.fromARGB(255, 157, 160, 234)
                                        ], // Colors for the gradient
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.0),
                                          bottomLeft: Radius.circular(50.0),
                                          bottomRight: Radius.circular(50.0))),
                                  child: TextButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent),
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      String? userid =
                                          prefs.getString("userid");
                                      if (FirebaseAuth
                                              .instance.currentUser?.uid !=
                                          null) {
                                        String? email = FirebaseAuth
                                            .instance.currentUser?.uid
                                            .toString();
                                        String? userName = FirebaseAuth
                                            .instance.currentUser?.displayName;

                                        await ref
                                            .child("$userName")
                                            .push()
                                            .set({
                                          "name": name.value.text,
                                          "task": task.value.text,
                                          "date": date.value.text,
                                          "time": time.value.text
                                        });

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListTask()));
                                      } else {
                                        print("object");
                                      }
                                    },
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color.fromARGB(
                                              254, 255, 255, 255)),
                                    ),
                                  ))),
                        ],
                      ))
                ],
              ),
            )),
          )),
    );
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
              dialogBackgroundColor: Colors.green[900],
            ),
            child: picker!,
          );
        }).then((value) {
      if (value != null) {
        String formattedDate = DateFormat.yMMMEd().format(value);

        date.text = formattedDate;
      }
    });
  }
}

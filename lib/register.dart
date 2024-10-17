import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_task/home.dart';
import 'package:my_task/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final _auth = FirebaseAuth.instance;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool flag = true;

  String? newUser;

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Stack(children: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                  ),
                ),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Image.asset(
                          'assets/logo_background.png',
                          height: 100,
                          width: 100,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
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
                          child: Center(
                              child: TextField(
                            controller: name,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Color.fromARGB(255, 119, 151, 219)),
                                border: InputBorder.none,
                                label: Text("Name")),
                          )),
                        )),
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
                          child: Center(
                              child: TextField(
                            controller: age,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Color.fromARGB(255, 119, 151, 219)),
                                border: InputBorder.none,
                                label: Text("Age")),
                          )),
                        )),
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
                          child: Center(
                              child: TextField(
                            controller: email,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Color.fromARGB(255, 119, 151, 219)),
                                border: InputBorder.none,
                                label: Text("Email")),
                          )),
                        )),
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
                          child: Center(
                              child: TextField(
                            controller: password,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Color.fromARGB(255, 119, 151, 219)),
                                border: InputBorder.none,
                                label: Text("Password")),
                          )),
                        )),
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
                          child: Center(
                              child: TextField(
                            controller: confirmPassword,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Color.fromARGB(255, 119, 151, 219)),
                                border: InputBorder.none,
                                label: Text("Confirm Password")),
                          )),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 13.0),
                        child: Container(
                            margin: const EdgeInsets.all(0),
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
                            // Corner radius
                            child: InkWell(
                              onTap: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();

                                if (email.value.text.isNotEmpty &&
                                    password.value.text.isNotEmpty) {
                                  try {
                                    await createUser(context, email.value.text,
                                        password.value.text, name.value.text);
                                    if (newUser != null) {
                                      setState() {
                                        prefs.setString(
                                            "userid", newUser.toString());
                                      }

                                      if (context.mounted) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()));
                                      }
                                    } else {
                                      print("user is null");
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              },
                              child: const Center(
                                  child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                            ))),
                    const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: Divider(
                          height: 1.0,
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 13.0),
                        child: Container(
                            margin: const EdgeInsets.all(0),
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
                            // Corner radius
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                },
                                child: const Center(
                                    child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.white),
                                )))))
                  ],
                ))))
      ]),
    );
  }

  Future<String?> createUser(
      BuildContext context, String email, String password, String name) async {
    try {
      /*   await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        newUser = value.user?.uid.toString();
      });

      await FirebaseAuth.instance.currentUser?.updateDisplayName(name); */

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? newUser = userCredential.user;

      if (newUser != null) {
        await newUser.updateDisplayName(name);

        return newUser.uid;
      }
    } on FirebaseAuthException catch (e) {
      // Show the SnackBar with the specific error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('error : ${e.toString()}')));
    }
    return null;
  }
}

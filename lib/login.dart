import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_task/create_task.dart';
import 'package:my_task/home.dart';
import 'package:my_task/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();

  final _auth = FirebaseAuth.instance;

  TextStyle defaultStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 18.0,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold);
  TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
  );

  String? userCheck;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();

    passwordVisible = true;
  }

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
            padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
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
                padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
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
                            height: 200,
                            width: 200,
                          )),
                      const SizedBox(
                        height: 50.0,
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
                                      color:
                                          Color.fromARGB(255, 119, 151, 219)),
                                  border: InputBorder.none,
                                  label: Text("Email")),
                            )),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 13.0),
                          child: Container(
                              width: double.infinity,
                              height: 70.0,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(50.0)),
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
                                  controller: pass,
                                  obscureText: passwordVisible,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.lock,
                                          color: Color.fromARGB(
                                              255, 119, 151, 219)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            color: const Color.fromARGB(
                                                255, 119, 151, 219),
                                            passwordVisible
                                                ? Icons.visibility
                                                : Icons
                                                    .visibility_off_outlined),
                                        onPressed: () {
                                          setState(() {
                                            passwordVisible = !passwordVisible;
                                          });
                                        },
                                      ),
                                      border: InputBorder.none,
                                      label: const Text("Password")),
                                ),
                              ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: RichText(
                                  text:
                                      TextSpan(style: defaultStyle, children: [
                                TextSpan(
                                    text: "Forgot password?",
                                    style: linkStyle,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {})
                              ])))
                        ],
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
                              borderRadius: BorderRadius.circular(10),
                              child: const Center(
                                  child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white),
                              )),
                              onTap: () async {
                                if (name.value.text.isEmpty ||
                                    pass.value.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Email or Password is empty"),
                                    backgroundColor: Colors.red,
                                  ));
                                } else {
                                  try {
                                    await loginUser(
                                        name.value.text, pass.value.text);
                                    if (userCheck != null) {
                                      if (context.mounted) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()));
                                      } else {
                                        print("user ha ha");
                                      }
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              },
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                          child: RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                  children: [
                                const TextSpan(
                                    text: "Don't have an account?  "),
                                TextSpan(
                                    text: "SIGNUP",
                                    style: linkStyle,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Register()));
                                      })
                              ]))),
                    ]))),
          )
        ]));
  }

  Future<String?> loginUser(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value.user?.uid);
        userCheck = value.user?.uid.toString();
      });
    } catch (e) {
      print(e);
    }

    return null;
  }
}

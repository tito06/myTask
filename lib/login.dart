import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_task/create_task.dart';
import 'package:my_task/home.dart';
import 'package:my_task/register.dart';


class Login extends StatefulWidget{
  const Login({super.key});
  
  @override
  State<StatefulWidget> createState() => _LoginState();

  
}



class _LoginState extends State<Login>{

  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();  

    final _auth = FirebaseAuth.instance;

  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
  TextStyle linkStyle = TextStyle(color: Colors.blue);

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
      appBar: AppBar(),
      body: Center(
      child: SingleChildScrollView (
        child : Column (
        mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Image.asset(
                'assets/main_logo.png',
                height: 250,
                width: 250,
              ),

          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child:
          TextField(
            controller: name,
            decoration:const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined,
                      color: Color.fromARGB(255, 154, 51, 232)),
              border: OutlineInputBorder(),
              label: Text("Email")
            ),
          )), 

          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child:
          TextField(
            controller: pass,
            obscureText: passwordVisible, 
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done, 
            decoration:  InputDecoration(
              prefixIcon: const Icon(Icons.lock,
                    color: Color.fromARGB(255, 154, 51, 232)),
                    suffixIcon: IconButton(
                     icon: Icon(color: Color.fromARGB(255, 154, 51, 232),passwordVisible ?
                      Icons.visibility: Icons.visibility_off_outlined),
                     onPressed: (){
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                     },),
              border:const OutlineInputBorder(),
              label:const Text("Password")
            ),
          )), 

          Padding(padding: EdgeInsets.fromLTRB(215, 4, 4, 8),
              child: RichText(text: TextSpan(style: defaultStyle,
              children: [
                TextSpan(text: "Forgot password?",
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                ..onTap = () {
                  
                }
                )
              ]))),

          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child :
          Container(  
              margin: EdgeInsets.all(0),
              width: double.infinity,
              height: 50.0,  
              child: ElevatedButton(  
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 154, 51, 232),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)  
                  ),
                ),
                child: const Text('LOGIN',  style: TextStyle(fontSize: 20.0,
                  color: Color.fromARGB(254, 255, 255, 255)),),  
                onPressed: () async {
                  if(name.value.text.isEmpty || pass.value.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Email or Password is empty"),
                        backgroundColor: Colors.red,
                        ));
                  } else {
                  try{
                await loginUser(name.value.text, pass.value.text);
                  if(userCheck != null){
                    if(context.mounted){
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context) => HomePage()));
                    }else {
                    print("user ha ha");
                  }

                  } 
                  } catch(e){
                    print(e);
                  }
                  }

                },  
              ))),

            Padding(padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: RichText(text: TextSpan(style: defaultStyle,
              children: [
               const TextSpan(text: "Don't have an account?  "),
                TextSpan(text: "SIGNUP",
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Register()) );
                }
                )
              ]))), 

        ])),
    )
    );
  }

  Future<String?> loginUser(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password)
      .then((value){
        print(value.user?.uid);
        userCheck = value.user?.uid.toString();
      });
    
    } catch(e){
        print(e);
    }

      return null ;

  }
}
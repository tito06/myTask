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

  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 18.0,fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold);
  TextStyle linkStyle = TextStyle(color: Colors.blue, fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,);

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
      backgroundColor: const Color.fromARGB(255, 203, 156, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 203, 156, 239),
      ),
      body: Center(
      child:   Container(
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
      child:       SingleChildScrollView (
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
              Container(  
              width: double.infinity, 
              height: 50.0,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20)
                  ),
        
              ),


              
          child : TextField(
            controller: name,
            decoration:const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined,
                      color: Color.fromARGB(255, 154, 51, 232)),
              border: OutlineInputBorder(),
              label: Text("Email")
            ),
          ))), 

          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child:Container(  
              width: double.infinity, 
              height: 50.0,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20)
                  ),
        
              ),
         child: TextField(
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
          ))), 

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
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 154, 51, 232),
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20)
                  ),
        
              ),  
              child: ElevatedButton(  
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 154, 51, 232),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)  
                  ),
                ),
                child: const Text('LOGIN',  style: TextStyle(fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                  color: Colors.white),),  
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
                    Navigator.pushReplacement(context,
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
              child: RichText(text: TextSpan(style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
              children: [
               const TextSpan(text: "Don't have an account?  "),
                TextSpan(text: "SIGNUP",
                
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Register()) );
                }
                )
              ]))), 

        ]))),
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
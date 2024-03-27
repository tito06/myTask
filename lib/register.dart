
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_task/create_task.dart';
import 'package:my_task/helper.dart';
import 'package:my_task/home.dart';
import 'package:my_task/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget{
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
  return  Scaffold(
    backgroundColor: const Color.fromARGB(255, 203, 156, 239),

    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 203, 156, 239),
      title:const Text("REGISTER",
      style: TextStyle(color: Colors.white,
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w900,
      fontSize: 25.0),),
    ),
    body: SingleChildScrollView(
      child:  Container(
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
      child:       Column(
    
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children:[
           Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child:  TextField(
                controller: name,
                keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_2_rounded,
                      color: Color.fromARGB(255, 154, 51, 232)),
                      border: OutlineInputBorder(),  
                      labelText: 'Name',  
                    ),  
              )),

      Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child:  TextField(
                controller: age,
                keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_2_rounded,
                      color: Color.fromARGB(255, 154, 51, 232)),
                      border: OutlineInputBorder(),  
                      labelText: 'Age',  
                    ),  
              )),

                Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child:  TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_2_rounded,
                      color: Color.fromARGB(255, 154, 51, 232)),
                      border: OutlineInputBorder(),  
                      labelText: 'Email',  
                    ),  
              )),

               Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child:TextField(
                controller: password,
                keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(  
                    prefixIcon: Icon(Icons.lock,
                    color: Color.fromARGB(255, 154, 51, 232)),
                      border: OutlineInputBorder(),  
                      labelText: 'Password',  
                    ),  
              )),

               Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child: TextField(
                controller: confirmPassword,
                keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(  
                     prefixIcon: Icon(Icons.lock,
                    color: Color.fromARGB(255, 154, 51, 232)),
                      border: OutlineInputBorder(),  
                      labelText: 'Confirm Password',  
                    ),  
              )),


              Padding(padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13.0),
              child :Container(  
              margin: const EdgeInsets.all(0), 
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
                
                child: const Text('Register',
                 style: TextStyle(fontSize: 20.0,
                 fontFamily: 'Montserrat',
                 fontWeight: FontWeight.bold ,
                  color: Colors.white),),  
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 154, 51, 232)
                ),
                onPressed: () async {
                  final prefs =await SharedPreferences.getInstance();
              
                  if(email.value.text.isNotEmpty && password.value.text.isNotEmpty){
                  try{
                  await createUser(email.value.text, password.value.text, name.value.text);
                  if(newUser != null){
                    setState(){
                        prefs.setString("userid",  newUser.toString());
                    }
                    if(context.mounted){
                      
                        Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>  HomePage()));
                    }
                  } else {
                    print("user is null");

                  }
                      
                  }catch(e){
                    print(e);
                  }
                 
                  }
                         
                },  
              ))),
           const Padding(padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              child:  Divider(
                height: 1.0,
              )),

              Padding(padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 13.0),
             child: Container(  
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
              child:  ElevatedButton(  
                child:  Text('Login', style: TextStyle(
                fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white),), 
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 154, 51, 232)
                ),
                   
                onPressed: ()  {
                  
                        Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>  Login()));
                    }
                  
                  
              )))

      ],
    

  ) )
      
      
),
  );
    
  }

    Future<String?> createUser( String email, String password, String name) async{
    try{

      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value){
        
        newUser = value.user?.uid.toString();

        
      });
      
      await  FirebaseAuth.instance.currentUser?.updateDisplayName(name);
    }
    catch(e){
      print(e);
    }
    return null ;
  }
  
}
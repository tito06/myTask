import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _profileState();
}

class _profileState extends State<Profile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void submitForm() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('User is not authenticated.');
      return;
    }

    if (_imageFile != null) {
      try {
        String userId = user.uid;
        String fileName = 'uploads/$userId/${DateTime.now()}.png';
        Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
        await storageRef.putFile(_imageFile!);

        String downloadUrl = await storageRef.getDownloadURL();
        String userName = name.text;
        String userEmail = email.text;
        String userAge = age.text;

        DatabaseReference dbRef =
            FirebaseDatabase.instance.ref('users/${userId}');
        await dbRef.set({
          'name': userName,
          'age': userAge,
          'email': userEmail,
          'profileImageUrl': downloadUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')));
      } catch (e) {
        print('Error uploading image: $e');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to updated Profile successfully!')));
      }
    }
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
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Text("My Profile"),
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
          child: Container(
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      // Circular Container
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: _imageFile != null
                              ? ClipOval(
                                  child: Image.file(
                                    _imageFile!,
                                    width: 120.0, // Same as container width
                                    height: 120.0, // Same as container height
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Text('No image selected'),
                        ),
                      ),

                      // Positioned Camera Button at Bottom Right Corner
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt, // Camera icon
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 13.0),
                      child: Container(
                        height: 70.0,
                        decoration: const BoxDecoration(
                          color:
                              Colors.white, // Background color of the container

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
                          color:
                              Colors.white, // Background color of the container

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
                          color:
                              Colors.white, // Background color of the container

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
                  ElevatedButton(
                    onPressed: submitForm, // Call submitForm on button press
                    child: Text('Submit'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

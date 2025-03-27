import 'dart:convert';

import 'package:career_guidance/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career Guidance',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Career Guidance'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> chooseImage() async {
    File? uploadimage;
    Future<void> chooseImage() async {
      final choosedimage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      //set source: ImageSource.camera to get image from camera
      setState(() {
        uploadimage = File(choosedimage!.path);
      });
    }
  }

  final _formKey = GlobalKey<FormState>(); // Add a global key for the form
  TextEditingController fnamecontroller = new TextEditingController();
  TextEditingController lnamecontroller = new TextEditingController();
  TextEditingController placecontroller = new TextEditingController();
  TextEditingController postcontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController pincontroller = new TextEditingController();
  TextEditingController phncontroller = new TextEditingController();
  TextEditingController unamecontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();

  final RegExp nameRegExp = RegExp(r'^[A-Za-z ]{2,25}$');
  final RegExp lnameRegExp = RegExp(r'^[A-Za-z ]{1,25}$');
  final RegExp placeRegExp = RegExp(r'^[A-Za-z0-9 ]{2,25}$');
  final RegExp postRegExp = RegExp(r'^[A-Za-z0-9 ]{2,25}$');
  final RegExp pinRegExp = RegExp(r'^[0-9]{6}$');
  final RegExp emailRegExp =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,25}$');
  final RegExp _phoneReguser = RegExp(r'^[6789]\d{9}$');
  final RegExp UnameRegExp = RegExp(r'^.{4,25}$');
  final RegExp passwordRegExp =
      RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$');

  XFile? _image; // Use XFile from image_picker package

  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Photo Library'),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Career Guidance"),
      ),
      body: WillPopScope(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/rating1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xffdbd8cd),
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      File(_image!.path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 8),
                      child: TextFormField(
                        controller: fnamecontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                            labelStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your firstname';
                          } else if (!nameRegExp.hasMatch(value)) {
                            return 'Name must be between 2 and 25 characters, including uppercase and lowercase letters';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 8),
                      child: TextFormField(
                        controller: lnamecontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Last Name',
                            labelStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your lastname';
                          } else if (!lnameRegExp.hasMatch(value)) {
                            return 'Name must be between 1 and 25 characters, including uppercase and lowercase letters';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 8),
                      child: TextFormField(
                        controller: placecontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Place',
                            labelStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your place';
                          } else if (!placeRegExp.hasMatch(value)) {
                            return 'Must consist of letters with more than 3 characters.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 8),
                      child: TextFormField(
                        controller: postcontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Post',
                            labelStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your post';
                          } else if (!postRegExp.hasMatch(value)) {
                            return 'Post may consist of alphabets and numbers.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 8),
                      child: TextFormField(
                        controller: pincontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Pin',
                            labelStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your pin';
                          } else if (!pinRegExp.hasMatch(value)) {
                            return 'Must consist of exactly 6 numeric digits.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 8),
                      child: TextFormField(
                        controller: phncontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone no';
                          } else if (!_phoneReguser.hasMatch(value)) {
                            return 'Enter 10 digit valid phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 8),
                      child: TextFormField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!emailRegExp.hasMatch(value)) {
                            return 'Must contain characters with @ and .';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 8),
                      child: TextFormField(
                        controller: unamecontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          } else if (!UnameRegExp.hasMatch(value)) {
                            return 'Username must contain atleast 4 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 8),
                      child: TextFormField(
                        obscureText: true,
                        controller: passcontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          } else if (!passwordRegExp.hasMatch(value)) {
                            return 'Include 8 characters with a [0-9],[A-Z] & [a-z] ';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            print("Not validated");
                          } else if (_image == null) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Please select an image.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          } else {
                            final sh = await SharedPreferences.getInstance();
                            String fname = fnamecontroller.text.toString();
                            String lname = lnamecontroller.text.toString();
                            String place = placecontroller.text.toString();
                            String post = postcontroller.text.toString();
                            String pin = pincontroller.text.toString();
                            String phn = phncontroller.text.toString();
                            String email = emailcontroller.text.toString();
                            String passwd = passcontroller.text.toString();
                            String uname = unamecontroller.text.toString();
                            String url = sh.getString("url").toString();
                            final bytes = File(_image!.path).readAsBytesSync();
                            String base64Image = base64Encode(bytes);
                            print("img_pan : $base64Image");
                            print("okkkkkkkkkkkkkkkkk");
                            var data = await http
                                .post(Uri.parse(url + "registration"), body: {
                              'fname': fname,
                              'lname': lname,
                              'place': place,
                              'post': post,
                              'pin': pin,
                              'phone': phn,
                              'file': base64Image,
                              'email': email,
                              'username': uname,
                              'password': passwd,
                            });
                            var jasondata = json.decode(data.body);
                            String status = jasondata['task'].toString();
                            if (status == "ok") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Successfully Registered'),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            } else {
                              print("error");
                            }
                          }
                        },
                        child: Text('REGISTER'))
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => login()));
          return true;
        },
      ),
    );
  }
}

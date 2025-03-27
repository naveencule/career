import 'dart:convert';
import 'package:career_guidance/fp.dart';
import 'package:flutter/material.dart';
import 'package:career_guidance/home.dart';
import 'package:career_guidance/register.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), backgroundColor: Colors.cyan),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/doubt.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: WillPopScope(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          // filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          // filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          },
                          child: Text("Signup",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              print("Not validated");
                            } else {
                              final sh = await SharedPreferences.getInstance();
                              String Uname = usernameController.text.toString();
                              String Passwd =
                                  passwordController.text.toString();
                              String url = sh.getString("url").toString();
                              print("okkkkkkkkkkkkkkkkk");
                              var data = await http
                                  .post(Uri.parse(url + "logincode"), body: {
                                'username': Uname,
                                "password": Passwd,
                              });
                              var jasondata = json.decode(data.body);
                              String status = jasondata['task'].toString();
                              if (status == "ok") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Welcome'),
                                    duration: Duration(seconds: 4),
                                  ),
                                );
                                String lid = jasondata['lid'].toString();
                                sh.setString("lid", lid);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => home()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Invalid Username or Password'),
                                    duration: Duration(seconds: 4),
                                  ),
                                );
                                print("error");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.cyan,
                          ),
                          child: const Text("Login"),
                        ),
                      ),
                     
                    ]), Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordScreen()));
                            },
                            child: Text("Forgot Password ?",style: TextStyle(fontWeight: FontWeight.bold))),
                      )
                  ],
                ),
              ),
            ),
            onWillPop: () async {
              SystemNavigator.pop();
              return true;
            },
          ),
        ),
      ),
    );
  }
}

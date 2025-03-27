import 'package:flutter/material.dart';
import 'package:career_guidance/login.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ipset extends StatefulWidget {
  const ipset({super.key});

  @override
  State<ipset> createState() => _ipsetstate();
}

class _ipsetstate extends State<ipset> {
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  final RegExp ipRegExp =
      RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}'
          r'(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');

  final TextEditingController ipController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("CAREER App"),
      ),
      body: WillPopScope(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/complaint.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(2),
                          child: TextFormField(
                            controller: ipController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "IP Address",
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: "Enter a valid ip address",
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your IP';
                              } else if (!ipRegExp.hasMatch(value)) {
                                return 'IP must be a valid one';
                              }
                              return null;
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              print("Not validated");
                            } else {
                              String ip = ipController.text.toString();
                              final sh = await SharedPreferences.getInstance();
                              sh.setString("url", "http://" + ip + ":5000/");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            }
                          },
                          child: const Text("Set"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
          // Navigator.push(

          //     context, MaterialPageRoute(builder: (context) => FirstPage()));
          // return true;
        },
      ),
    );
  }
}

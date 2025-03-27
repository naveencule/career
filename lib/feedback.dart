import 'dart:convert';

import 'package:career_guidance/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewFeedbackpage extends StatefulWidget {
  @override
  NewFeedbackpageState createState() => NewFeedbackpageState();
}

class NewFeedbackpageState extends State<NewFeedbackpage> {
  final TextEditingController _feedbackController = TextEditingController();



  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ask a New one"),
      ),
      body: Container( decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade400, Colors.blue.shade900],
            ),
          ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _feedbackController,
                decoration: InputDecoration(
                  hintText: "Enter your Feedback...",
                ),
              ),
              ElevatedButton(
                onPressed: ()async {
                  final sh = await SharedPreferences.getInstance();
                  String feed=_feedbackController.text.toString();
                  // String Passwd=passwordController.text.toString();
                  String url = sh.getString("url").toString();
                  String lid = sh.getString("lid").toString();
                  print("okkkkkkkkkkkkkkkkk");
                  var data = await http.post(
                      Uri.parse(url+"addfeed"),
                      body: {'feed':feed,
                        'lid':lid,
      
                      });
                  var jasondata = json.decode(data.body);
                  String status=jasondata['task'].toString();
                  if(status=="ok")
                  {
      
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => home()));
      
                  }
                  else{
                    print("error");
      
                  }
                },
                child: Text("Submit "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
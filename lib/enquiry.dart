import 'dart:convert';

import 'package:career_guidance/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EnquiryPage extends StatefulWidget {
  @override
  _EnquiryPageState createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<EnquiryPage> {
  List<String> ccid_ = [];
  List<String> date_ = [];
  List<String> reply_ = [];
  List<String> enquiry_ = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    List<String> ccid = [];
    List<String> date = [];
    List<String> reply = [];
    List<String> enquiry = [];

    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "viewenqreply";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsondata = json.decode(data.body);

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        ccid.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        reply.add(arr[i]['reply'].toString());
        enquiry.add(arr[i]['enquiry'].toString());
      }
      setState(() {
        ccid_ = ccid;
        date_ = date;
        reply_ = reply;
        enquiry_ = enquiry;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enquiries"),
      ),
      body: WillPopScope(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade400, Colors.blue.shade900],
            ),
          ),
          child: ccid_.isEmpty
              ? Center(
                  child: Text(
                    'No Enquiries Yet',
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: ccid_.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {},
                      title: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Column(
                                  children: [
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.loose,
                                          child: Row(
                                            children: [Text(" Date")],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(
                                            children: [Text(date_[index])],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.loose,
                                          child: Row(
                                            children: [Text("Enquiry")],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(
                                            children: [
                                              Expanded(child: Text(enquiry_[index]))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.loose,
                                          child: Row(
                                            children: [Text("Reply")],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(
                                            children: [Expanded(child: Text(reply_[index]))],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                margin: EdgeInsets.all(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        onWillPop: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => home()));
          return true;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewenquiryPage(
                onSubmit: () {
                  // Reload enquiries after submitting a new one
                  load();
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NewenquiryPage extends StatefulWidget {
  final VoidCallback onSubmit; // Callback function

  NewenquiryPage({required this.onSubmit});

  @override
  _NewenquiryPageState createState() => _NewenquiryPageState();
}

class _NewenquiryPageState extends State<NewenquiryPage> {
  final TextEditingController _enquiryController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  void dispose() {
    _enquiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write a New enquiry"),
      ),
      body: WillPopScope(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/status.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _enquiryController,
                    decoration: InputDecoration(
                      hintText: "Enter your enquiry...",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your enquiry..';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        print("Not validated");
                      } else {
                        final sh = await SharedPreferences.getInstance();
                        String enquiry = _enquiryController.text.toString();
                        String url = sh.getString("url").toString();
                        String lid = sh.getString("lid").toString();
                        var data =
                            await http.post(Uri.parse(url + "enqadd"), body: {
                          'enquiry': enquiry,
                          'lid': lid,
                        });
                        var jasondata = json.decode(data.body);
                        String status = jasondata['task'].toString();
                        if (status == "ok") {
                          // Call the callback function to reload enquiries
                          widget.onSubmit();
                          // Show success message and navigate back
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Successfully Send'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.pop(context);
                          });
                        } else {
                          print("error");
                        }
                      }
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EnquiryPage()));
          return true;
        },
      ),
    );
  }
}

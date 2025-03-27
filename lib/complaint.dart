import 'dart:convert';

import 'package:career_guidance/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<String> ccid_ = [];
  List<String> date_ = [];
  List<String> reply_ = [];
  List<String> complaint_ = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    List<String> ccid = [];
    List<String> date = [];
    List<String> reply = [];
    List<String> complaint = [];

    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "viewreply";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        ccid.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        reply.add(arr[i]['reply'].toString());
        complaint.add(arr[i]['complaint'].toString());
      }
      setState(() {
        ccid_ = ccid;
        date_ = date;
        reply_ = reply;
        complaint_ = complaint;
      });
      print(status);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaints"),
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
          child: ccid_.isEmpty // Check if the list of complaints is empty
              ? Center(
                  child: Text(
                    'No Complaints Yet',
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
                                            children: [Text("Complaint")],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child:
                                                      Text(complaint_[index]))
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
                                            children: [
                                              Expanded(
                                                  child: Text(reply_[index]))
                                            ],
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
              builder: (context) => NewComplaintPage(
                onSubmit: () {
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

class NewComplaintPage extends StatefulWidget {
  final VoidCallback onSubmit;

  NewComplaintPage({required this.onSubmit});

  @override
  _NewComplaintPageState createState() => _NewComplaintPageState();
}

class _NewComplaintPageState extends State<NewComplaintPage> {
  final TextEditingController _complaintController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write a New Complaint"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/status.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: WillPopScope(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _complaintController,
                    decoration: InputDecoration(
                      hintText: "Enter your complaint...",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your complaint..';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        print("Not validated");
                      } else {
                        final sh = await SharedPreferences.getInstance();
                        String complaint = _complaintController.text.toString();
                        String url = sh.getString("url").toString();
                        String lid = sh.getString("lid").toString();
                        var data = await http
                            .post(Uri.parse(url + "complaintadd"), body: {
                          'complaint': complaint,
                          'lid': lid,
                        });
                        var jasondata = json.decode(data.body);
                        String status = jasondata['task'].toString();
                        if (status == "ok") {
                          widget.onSubmit();
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
          onWillPop: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FirstPage()));
            return true;
          },
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FirstPage(),
  ));
}

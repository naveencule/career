import 'dart:convert';

import 'package:career_guidance/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class noti extends StatefulWidget {
  @override
  _notiState createState() => _notiState();
}

class _notiState extends State<noti> {
  // Lists to store enquirys and their replies

  List<String> ccid_ = <String>[];
  List<String> date_ = <String>[];
  List<String> staff_ = <String>[];

  List<String> noti_ = <String>[];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    List<String> ccid = <String>[];
    List<String> date = <String>[];
    List<String> staff = <String>[];
    List<String> noti = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "viewenoti";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsondata = json.decode(data.body);

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        ccid.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        staff.add(arr[i]['staff'].toString());
        noti.add(arr[i]['noti'].toString());
      }
      setState(() {
        ccid_ = ccid;
        date_ = date;
        staff_ = staff;
        noti_ = noti;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
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
                    'No Notifications Yet',
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
                                        SizedBox(width: 50),
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
                                        SizedBox(width: 50),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.loose,
                                          child: Row(
                                            children: [Text("Notification")],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Expanded(
                                                      child:
                                                          Text(noti_[index])))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(height: 16),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(width: 50),
                                    //     Flexible(
                                    //       flex: 2,
                                    //       fit: FlexFit.loose,
                                    //       child: Row(
                                    //         children: [Text("Staff")],
                                    //       ),
                                    //     ),
                                    //     Flexible(
                                    //       flex: 3,
                                    //       fit: FlexFit.loose,
                                    //       child: Row(
                                    //         children: [
                                    //           Expanded(
                                    //               child:
                                    //                   Expanded(child: Text(staff_[index])))
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
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
    );
  }
}

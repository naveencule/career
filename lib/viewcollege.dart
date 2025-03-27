import 'dart:convert';
import 'package:career_guidance/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:career_guidance/viewcourses.dart';

class viewcollegepagePage extends StatefulWidget {
  const viewcollegepagePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<viewcollegepagePage> createState() => _viewcollegepagePage();
}

class _viewcollegepagePage extends State<viewcollegepagePage> {
  // int _counter = 0;

  _viewcollegepagePage() {
    view_college();
  }

  List<String> cid_ = <String>[];
  List<String> cname_ = <String>[];
  List<String> cphoto_ = <String>[];
  List<String> caddress_ = <String>[];
  List<String> cphone_ = <String>[];
  List<String> cemail_ = <String>[];

  Future<void> view_college() async {
    List<String> cid = <String>[];
    List<String> cname = <String>[];
    List<String> cphoto = <String>[];
    List<String> caddress = <String>[];
    List<String> cemail = <String>[];
    List<String> cphone = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();
      // String lid= pref.getString("lid").toString();

      String url = ip + "viewcollege";
      print(url);
      print("=========================");

      var data = await http.post(Uri.parse(url), body: {});
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      print(arr);

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        print("okkkkkkkkkkkkkkkkkkkkkkkk");
        cid.add(arr[i]['id'].toString());
        cname.add(arr[i]['name'].toString());
        cphoto.add(ip + arr[i]['image'].toString());
        caddress.add(arr[i]['place'].toString() +
            "\n" +
            arr[i]['post'].toString() +
            "\n" +
            arr[i]['pin'].toString());
        cphone.add(arr[i]['phone'].toString());
        cemail.add(arr[i]['email'].toString());
        print("ppppppppppppppppppp");
      }

      setState(() {
        cid_ = cid;
        cname_ = cname;
        cphoto_ = cphoto;
        caddress_ = caddress;
        cemail_ = cemail;
        cphone_ = cphone;
      });

      print(cid_.length);
      print("+++++++++++++++++++++");
      print(status);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
            title: new Text(
              "Colleges",
              style: new TextStyle(color: Colors.white),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, home);
                // Navigator.pushNamed(context, '/home');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const  MyHomePage(title: '',)),);
                print("Hello");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ThirdScreen()),
                // );
              },
            )),
        body: WillPopScope(
          child: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade900],
          ),
        ),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              // padding: EdgeInsets.all(5.0),
              // shrinkWrap: true,
              itemCount: cid_.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onLongPress: () {
                    print("long press" + index.toString());
                  },
                  title: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 500,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),

                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: Image.network(
                                        cphoto_[index],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),

                                      Flexible(
                                          flex: 2,
                                          fit: FlexFit.loose,
                                          child: Row(children: [Text("Name")])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(
                                              children: [Expanded(child: Text(cname_[index]))])),

                                      // Text("Place"),
                                      // Text(place_[index])
                                    ],
                                  ),

                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),

                                      Flexible(
                                          flex: 2,
                                          fit: FlexFit.loose,
                                          child:
                                              Row(children: [Text("Address")])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(children: [
                                            Expanded(child: Text(caddress_[index]))
                                          ])),

                                      // Text("Place"),
                                      // Text(place_[index])
                                    ],
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),

                                      Flexible(
                                          flex: 2,
                                          fit: FlexFit.loose,
                                          child:
                                              Row(children: [Text("Phone")])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(children: [
                                            Text(cphone_[index])
                                          ])),

                                      // Text("Place"),
                                      // Text(place_[index])
                                    ],
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),

                                      Flexible(
                                          flex: 2,
                                          fit: FlexFit.loose,
                                          child:
                                              Row(children: [Text("Email")])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(children: [
                                            Expanded(child: Text(cemail_[index]))
                                          ])),

                                      // Text("Place"),
                                      // Text(place_[index])
                                    ],
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),

                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setString('cid', cid_[index]);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      viewcoursesPage(
                                                        title: 'vc',
                                                      )),
                                            );
                                          },
                                          child: Text('COURSES'),
                                        ),
                                      ],
                                    ),
                                  )

                                  // Column(
                                  //     mainAxisAlignment: MainAxisAlignment.start,
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children:[
                                  //   Text('Title'),
                                  //   Text('Subtitle')
                                  // ])
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
                      )),
                );
              },
            ),
          ),
          onWillPop: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => home()));
            return true;
          },
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

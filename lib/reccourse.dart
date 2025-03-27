import 'dart:convert';
import 'package:career_guidance/home.dart';
import 'package:career_guidance/reccollege.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class courserec extends StatefulWidget {
  const courserec({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<courserec> createState() => _courserecState();
}

class _courserecState extends State<courserec> {
  // int _counter = 0;

  _courserecState() {
    load();
  }

  List<String> ccid_ = <String>[];
  List<String> date_ = <String>[];
  List<String> details_ = <String>[];
  List<String> cname_ = <String>[];

  Future<void> load() async {
    List<String> ccid = <String>[];
    List<String> date = <String>[];
    List<String> details = <String>[];
    List<String> cname = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String course = pref.getString("course").toString();
      String ip = pref.getString("url").toString();
      // String lid= pref.getString("lid").toString();

      String url = ip + "viewreccourses";
      print(url);
      var data = await http.post(Uri.parse(url), body: {'course': course});

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      print(arr);

      print(arr.length);

      // List<String> schid_ = <String>[];
      // List<String> date_ = <String>[];
      // List<String> type_ = <String>[];

      for (int i = 0; i < arr.length; i++) {
        ccid.add(arr[i]['id'].toString());
        date.add(arr[i]['college'].toString());
        details.add(arr[i]['details'].toString());
        cname.add(arr[i]['name'].toString());
      }
      setState(() {
        ccid_ = ccid;
        date_ = date;
        details_ = details;
        cname_ = cname;
      });
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
              "Recommended Courses",
              style: new TextStyle(color: Colors.white),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                // Navigator.pop(context,home());
                // Navigator.pushNamed(context, '/home');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const  MyHomePage(title: '',)),);
                // print("Hello");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => home()),
                );
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
                            height: 195,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 16,
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
                                          child: Row(children: [Text("Course")])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child:
                                              Row(children: [Expanded(child: Text(cname_[index]))])),
          
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
                                          child: Row(children: [Text("Details")])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(
                                              children: [Expanded(child: Text(details_[index]))])),
          
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
                                          child: Row(children: [Text("College")])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child:
                                              Row(children: [Expanded(child: Text(date_[index]))])),
                                    ],
                                  ),
                                  Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences.getInstance();
                                          prefs.setString('clgid', ccid_[index]);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewCollegePage2(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'About college',
                                          style: TextStyle(
                                            color: Colors
                                                .blue, // Set the text color to blue to make it look like a link
                                            decoration: TextDecoration
                                                .underline, // Add underline decoration
                                          ),
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
                      )),
                );
              },
            ),
          ), onWillPop: () async {
          // Navigate back to the previous page
          Navigator.pop(context, home());
          return true;
        },
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

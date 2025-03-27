import 'dart:convert';
import 'package:career_guidance/uploadcv.dart';
import 'package:career_guidance/viewcompany.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class viewjobsPage extends StatefulWidget {
  const viewjobsPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<viewjobsPage> createState() => _viewjobsPageState();
}

class _viewjobsPageState extends State<viewjobsPage> {
  // int _counter = 0;

  _viewjobsPageState() {
    load();
  }

  List<String> ccid_ = <String>[];
  List<String> date_ = <String>[];
  List<String> details_ = <String>[];
  List<String> qualification_ = <String>[];
  List<String> cname_ = <String>[];
  List<String> no_ = <String>[];

  Future<void> load() async {
    List<String> ccid = <String>[];
    List<String> date = <String>[];
    List<String> details = <String>[];
    List<String> cname = <String>[];
    List<String> qualification = <String>[];
    List<String> no = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String vid = pref.getString("ccid").toString();
      String ip = pref.getString("url").toString();
      // String lid= pref.getString("lid").toString();

      String url = ip + "viewjobs";
      print(url);
      var data = await http.post(Uri.parse(url), body: {'cid': vid});

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
        date.add(arr[i]['date'].toString());
        details.add(arr[i]['details'].toString());
        cname.add(arr[i]['name'].toString());
        qualification.add(arr[i]['qualification'].toString());
        no.add(arr[i]['no'].toString());
      }
      setState(() {
        ccid_ = ccid;
        date_ = date;
        details_ = details;
        cname_ = cname;
        qualification_ = qualification;
        no_ = no;
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
              "View All Jobs",
              style: new TextStyle(color: Colors.white),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => viewcompanypagePage(
                              title: 'ft',
                            )));
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
                            height: 250,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Column(
                                children: [
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
                                          child: Row(children: [
                                            Expanded(child: Text(cname_[index]))
                                          ])),

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
                                          child: Row(
                                              children: [Text("Last Date")])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(
                                              children: [Text(date_[index])])),

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
                                          child: Row(children: [
                                            Text("Qualification")
                                          ])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(children: [
                                            Expanded(
                                                child:
                                                    Text(qualification_[index]))
                                          ])),

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
                                          child: Row(
                                              children: [Text("Vaccancies")])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(children: [
                                            Expanded(child: Text(no_[index]))
                                          ])),

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
                                              Row(children: [Text("Details")])),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.loose,
                                          child: Row(children: [
                                            Expanded(
                                                child: Text(details_[index]))
                                          ])),

                                      // Text("Place"),
                                      // Text(place_[index])
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      String jid = ccid_[index].toString();
                                      prefs.setString('jid', ccid_[index]);

                                      final pref =
                                          await SharedPreferences.getInstance();
                                      String ip =
                                          pref.getString("url").toString();
                                      String lid =
                                          pref.getString("lid").toString();
                                      String url = ip + "jobcheck";
                                      print(url);
                                      var data = await http.post(Uri.parse(url),
                                          body: {'jid': jid, 'lid': lid});

                                      var jasondata = json.decode(data.body);
                                      String status =
                                          jasondata['task'].toString();
                                      if (status == "ok") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FileUploadScreen()),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Already Applied'),
                                            duration: Duration(seconds: 4),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text('Apply Now'),
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
                    ));
              },
            ),
          ),
          onWillPop: () async {
            Navigator.pop(
                context,
                viewcompanypagePage(
                  title: 'kj',
                ));
            return true;
          },
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

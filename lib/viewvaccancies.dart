import 'dart:convert';
// import 'dart:math';
import 'package:career_guidance/uploadcv.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class viewvaccanciesPage extends StatefulWidget {
  const viewvaccanciesPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<viewvaccanciesPage> createState() => _viewvaccanciesPageState();
}

class _viewvaccanciesPageState extends State<viewvaccanciesPage> {
  // int _counter = 0;

  _viewvaccanciesPageState() {
    load();
  }

  List<String> jid_ = <String>[];
  List<String> date_ = <String>[];
  List<String> details_ = <String>[];
  List<String> noofvy_ = <String>[];
  List<String> type_ = <String>[];

  Future<void> load() async {
    List<String> jid = <String>[];
    List<String> date = <String>[];
    List<String> details = <String>[];
    List<String> noofvy = <String>[];
    List<String> type = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String vid = pref.getString("jid").toString();
      String ip = pref.getString("url").toString();
      // String lid= pref.getString("lid").toString();

      String url = ip + "viewvaccancies";
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
        jid.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        details.add(arr[i]['details'].toString());
        type.add(arr[i]['name'].toString());
        noofvy.add(arr[i]['noofvaccancy'].toString());
      }
      setState(() {
        jid_ = jid;
        date_ = date;
        details_ = details;
        type_ = type;
        noofvy_ = noofvy;
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
              "View All Vaccancies",
              style: new TextStyle(color: Colors.white),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, '/home');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const  MyHomePage(title: '',)),);
                print("Hello");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ThirdScreen()),
                // );
              },
            )),
        body: Container(decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            // padding: EdgeInsets.all(5.0),
            // shrinkWrap: true,
            itemCount: jid_.length,
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
                                        child:
                                            Row(children: [Text("Last Date")])),
                                    Flexible(
                                        flex: 3,
                                        fit: FlexFit.loose,
                                        child:
                                            Row(children: [Text(date_[index])])),
        
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
                                        child: Row(children: [Text("Type")])),
                                    Flexible(
                                        flex: 3,
                                        fit: FlexFit.loose,
                                        child:
                                            Row(children: [Text(type_[index])])),
        
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
                                          Text("No of Vaccancies")
                                        ])),
                                    Flexible(
                                        flex: 3,
                                        fit: FlexFit.loose,
                                        child: Row(
                                            children: [Text(noofvy_[index])])),
        
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
                                  width: 10.0,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('jid', jid_[index]);
        
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FileUploadScreen()),
                                    );
                                  },
                                  child: Text('APPLY NOW'),
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
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: [],
                          ),
                        )
                      ],
                    )),
              );
            },
          ),
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

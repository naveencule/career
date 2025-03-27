import 'dart:convert';
import 'package:career_guidance/reccourse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewCollegePage2 extends StatefulWidget {
  const ViewCollegePage2({Key? key});

  @override
  State<ViewCollegePage2> createState() => _ViewCollegePage2State();
}

class _ViewCollegePage2State extends State<ViewCollegePage2> {
  List<String> cid_ = [];
  List<String> cname_ = [];
  List<String> cphoto_ = [];
  List<String> caddress_ = [];
  List<String> cphone_ = [];
  List<String> cemail_ = [];

  @override
  void initState() {
    super.initState();
    view_college();
  }

  Future<void> view_college() async {
    List<String> cid = [];
    List<String> cname = [];
    List<String> cphoto = [];
    List<String> caddress = [];
    List<String> cemail = [];
    List<String> cphone = [];

    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();
      String clgid = pref.getString("clgid").toString();

      String url = ip + "viewreccollege";
      print(url);

      var data = await http.post(Uri.parse(url), body: {"clgid": clgid});
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      // for (int i = 0; i < arr.length; i++) {
      cid.add(arr['id'].toString());
      cname.add(arr['name'].toString());
      cphoto.add(ip + arr['image'].toString());
      caddress.add(arr['place'].toString() +
          "\n" +
          arr['post'].toString() +
          "\n" +
          arr['pin'].toString());
      cphone.add(arr['phone'].toString());
      cemail.add(arr['email'].toString());
      // }

      setState(() {
        cid_ = cid;
        cname_ = cname;
        cphoto_ = cphoto;
        caddress_ = caddress;
        cemail_ = cemail;
        cphone_ = cphone;
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
        title: Text(
          "Colleges",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, courserec);
          },
        ),
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
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
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
                              SizedBox(height: 5),
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
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.loose,
                                    child: Row(children: [Text("Name")]),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.loose,
                                    child: Row(children: [Expanded(child: Text(cname_[index]))]),
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
                                    child: Row(children: [Text("Address")]),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.loose,
                                    child:
                                        Row(children: [Expanded(child: Text(caddress_[index]))]),
                                  ),
                                ],
                              ),
                              SizedBox(height: 9),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.loose,
                                    child: Row(children: [Text("Phone")]),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.loose,
                                    child:
                                        Row(children: [Text(cphone_[index])]),
                                  ),
                                ],
                              ),
                              SizedBox(height: 9),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.loose,
                                    child: Row(children: [Text("Email")]),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.loose,
                                    child:
                                        Row(children: [Expanded(child: Text(cemail_[index]))]),
                                  ),
                                ],
                              ),
                              SizedBox(height: 9),
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
          Navigator.pop(context, courserec(title: 'lk',));
          return true;
        },
      ),
    );
  }
}

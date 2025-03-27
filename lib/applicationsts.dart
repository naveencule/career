import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppStatusPage extends StatefulWidget {
  @override
  _AppStatusPageState createState() => _AppStatusPageState();
}

class _AppStatusPageState extends State<AppStatusPage> {
  List<String> companies = [];
  List<String> dates = [];
  List<String> positions = [];
  List<String> statuses = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "appsts";
      var response = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsonData = json.decode(response.body);
      var data = jsonData["data"];

      List<String> tempCompanies = [];
      List<String> tempDates = [];
      List<String> tempPositions = [];
      List<String> tempStatuses = [];

      for (var item in data) {
        tempCompanies.add(item['company'].toString());
        tempDates.add(item['date'].toString());
        tempPositions.add(item['position'].toString());
        tempStatuses.add(item['status'].toString());
      }

      setState(() {
        companies = tempCompanies;
        dates = tempDates;
        positions = tempPositions;
        statuses = tempStatuses;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Status"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade400, Colors.blue.shade900],
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: companies.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white.withOpacity(0.8), // Custom card color with opacity
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.business, color: Colors.blue), // Custom icon
                          SizedBox(width: 10),
                          Text(
                            "Company: ${companies[index]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.work, color: Colors.blue), // Custom icon
                          SizedBox(width: 10),
                          Text(
                            "Position: ${positions[index]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.date_range, color: Colors.blue), // Custom icon
                          SizedBox(width: 10),
                          Text(
                            "Applied Date: ${dates[index]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green), // Custom icon
                          SizedBox(width: 10),
                          Text(
                            "Status: ${statuses[index]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AppStatusPage(),
  ));
}

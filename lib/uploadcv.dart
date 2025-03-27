import 'dart:convert';
import 'package:career_guidance/viewcompany.dart';
import 'package:career_guidance/viewjobs.dart';
import 'package:http/http.dart' as http;
import 'package:career_guidance/home.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileUploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload CV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FilePickerDemo(),
    );
  }
}

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  File? _selectedFile;
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print("--------------------------------------------");
      print('Error picking file: $e');
      print("--------------------------------------------");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => viewjobsPage(title: 'se',)));
            }),
        title: Text('Send Your CV'),
      ),
      body: WillPopScope(
        // child: Container(decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('assets/status.jpgg'),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade400, Colors.blue.shade900],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _pickFile,
                  child: Text('Select PDF File'),
                ),
                SizedBox(height: 20),
                if (_selectedFile != null)
                  Text(
                    'Selected File: ${_selectedFile!.path.split('/').last}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    print(_selectedFile);
                    print("gffgfgftfgfdg");
                    final sh = await SharedPreferences.getInstance();
                    // String Passwd=passwordController.text.toString();
                    String lid = sh.getString("lid").toString();
                    String jid = sh.getString("jid").toString();
                    String url = sh.getString("url").toString();
                    final bytes = File(_selectedFile!.path).readAsBytesSync();
                    String base64Image = base64Encode(bytes);
                    print("+++++++___________________" + url + "uploadresume");
                    var data =
                        await http.post(Uri.parse(url + "uploadresume"), body: {
                      'file': base64Image,
                      'lid': lid,
                      'vid': jid,
                    });
                    print("++++++++++++++++++++++++++");
                    print(data.body);
                    var jasondata = json.decode(data.body);
                    String status = jasondata['task'].toString();

                    if (status == "ok") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Applied'),
                          duration: Duration(seconds: 1),
                        ),
                      );

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => viewcompanypagePage(
                                    title: 'dr',
                                  )));
                      // Fluttertoast.showToast(
                      //   msg: "This is a toast message",
                      //   toastLength: Toast
                      //       .LENGTH_SHORT, // Duration for which the toast message will be shown
                      //   gravity: ToastGravity
                      //       .BOTTOM, // Location where the toast message will be displayed
                      //   backgroundColor:
                      //       Colors.black, // Background color of the toast message
                      //   textColor:
                      //       Colors.white, // Text color of the toast message
                      // );
                      print(
                          "{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{|}{}{}{}{}{}{}}");

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Applied'),
                      //     duration: Duration(seconds: 2),
                      //   ),
                      // );

                      // Future.delayed(Duration(seconds: 2), () {
                      //   Navigator.pop(context, viewcompanypagePage(title: 'hu',));
                      // });
                    } else if (status == "okk") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => home()));
                    } else {
                      print("error");
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
            // ),
          ),
        ),
        onWillPop: () async {
          // Navigate back to the previous page
          Navigator.pop(context);
          return true;
        },
      ),
    );
  }
}

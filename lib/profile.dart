import 'dart:convert';
import 'package:career_guidance/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String phone = "";
  String email = "";
  String address = "";
  String photo = "";

  @override
  void initState() {
    super.initState();
    viewProfile();
  }

  Future<void> viewProfile() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();
      String lid = pref.getString("lid").toString();

      String url = ip + "profile";
      print(url);
      print("=========================");

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      print(jsondata); // Print the API response for debugging

      // Access profile fields directly from jsondata
      if (jsondata != null) {
        setState(() {
          name = jsondata['name'].toString();
          phone = jsondata['phone'].toString();
          email = jsondata['email'].toString();
          address = jsondata['address'].toString();
          photo = ip + jsondata['photo'].toString(); // Update image URL
        });
      } else {
        print("No profile data found in the response");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Background color set to black
      child: Scaffold(
        appBar: AppBar(
          title: Text("Career Guidance"),
          backgroundColor: Colors.cyan,
          elevation: 0,
        ),drawer: Drawerclass(),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    ),
                  ),
                  padding: EdgeInsets.all(70),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EnlargedImagePage(
                                  imageUrl: photo,
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            backgroundImage: NetworkImage(photo),
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildProfileInfo("Name", name),
                        _buildProfileInfo("Email", email),
                        _buildProfileInfo("Phone", phone),
                        _buildProfileInfo("Address", address),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label + ":",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EnlargedImagePage extends StatelessWidget {
  final String imageUrl;

  const EnlargedImagePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Close the page when tapping on the image
        },
        child: Center(
          child: Hero(
            tag: 'student_image',
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}


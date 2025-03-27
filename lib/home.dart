import 'package:career_guidance/applicationsts.dart';
import 'package:career_guidance/complaint.dart';
import 'package:career_guidance/drawer.dart';
import 'package:career_guidance/enquiry.dart';
import 'package:career_guidance/prediction.dart';
import 'package:career_guidance/rating.dart';
import 'package:career_guidance/test.dart';
import 'package:career_guidance/viewcollege.dart';
import 'package:career_guidance/viewcompany.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => homeState();
}

class homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Colors.cyan,
          title: const Text("Career Guidance"),
        ),
        drawer: const Drawerclass(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/status.jpg'), // Background image path
              fit: BoxFit.cover,
            ),
          ),
          child: WillPopScope(
            child: SafeArea(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => viewcollegepagePage(
                                            title: 'ii',
                                          )));
                            },
                            child: Image.asset(
                              'assets/collegeandcourses.jpg',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Colleges",style: TextStyle(color: Colors.white),)
                        ],
                      )),
                      SizedBox(
                        width: 55,
                      ),
                      Container(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => viewcompanypagePage(
                                      title: 'ft',
                                    ),
                                  ));
                            },
                            child: Image.asset(
                              'assets/companybg.jpg',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Companies",style: TextStyle(color: Colors.white))
                        ],
                      ))
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EnquiryPage()));
                            },
                            child: Image.asset(
                              'assets/enquiry.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Enquiries",style: TextStyle(color: Colors.white))
                        ],
                      )),
                      SizedBox(
                        width: 55,
                      ),
                      Container(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RatingPage(),
                                  ));
                            },
                            child: Image.asset(
                              'assets/feedbackrating.jpg',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Feedback",style: TextStyle(color: Colors.white)),
                        ],
                      ))
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FirstPage(),
                                  ));
                            },
                            child: Image.asset(
                              'assets/complaintbg.jpg',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Complaints",style: TextStyle(color: Colors.white))
                        ],
                      )),
                      SizedBox(
                        width: 55,
                      ),
                      Container(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FileUploadScreen2(),
                                  ));
                            },
                            child: Image.asset(
                              'assets/careerprediction.jpg',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("   Career \nPrediction",style: TextStyle(color: Colors.white)),
                        ],
                      ))
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => rec(),
                                  ));
                            },
                            child: Image.asset(
                              'assets/recomofcourses.jpg',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Reccommend \n      Course",style: TextStyle(color: Colors.white))
                        ],
                      )),
                      SizedBox(
                        width: 55,
                      ),
                      Container(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppStatusPage(),
                                  ));
                            },
                            child: Image.asset(
                              'assets/application view.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Application \n     Status",style: TextStyle(color: Colors.white)),
                        ],
                      ))
                    ],
                  ),
                  // Add your column children here
                ],
              ),
            ),
            onWillPop: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => home()));
              return true;
            },
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => home()));
        return true;
      },
    );
  }
}

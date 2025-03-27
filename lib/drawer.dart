import 'package:career_guidance/applicationsts.dart';
import 'package:career_guidance/notification.dart';
import 'package:career_guidance/prediction.dart';
import 'package:career_guidance/profile.dart';
import 'package:career_guidance/test.dart';
import 'package:career_guidance/viewcollege.dart';
import 'package:career_guidance/viewcompany.dart';
import 'package:flutter/material.dart';

import 'package:career_guidance/complaint.dart';
import 'package:career_guidance/enquiry.dart';
import 'package:career_guidance/home.dart';
import 'package:career_guidance/rating.dart';
import 'package:flutter/services.dart';

class Drawerclass extends StatefulWidget {
  const Drawerclass({Key? key}) : super(key: key);

  @override
  State<Drawerclass> createState() => _DrawerclassState();
}

class _DrawerclassState extends State<Drawerclass> {
  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Exit'),
          content: Text('Do you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/status.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Text(
                "Career Guidance",
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
            ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home),
              ),
              title: const Text("Home"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const home()));
              },
            ),
            // ListTile(
            //   leading: IconButton(
            //       onPressed: () {},
            //       icon: const Icon(Icons.account_balance_sharp)),
            //   title: const Text("Colleges & courses"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => viewcollegepagePage(
            //                   title: 'vv',
            //                 )));
            //   },
            // ),
            // ListTile(
            //   leading: IconButton(
            //       onPressed: () {},
            //       icon: const Icon(Icons.account_balance_wallet)),
            //   title: const Text("Career Prediction"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => FileUploadScreen2()));
            //   },
            // ),
            // ListTile(
            //   leading: IconButton(
            //       onPressed: () {},
            //       icon: const Icon(Icons.add_business_outlined)),
            //   title: const Text("Companies & Jobs"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => viewcompanypagePage(
            //                   title: 'co',
            //                 )));
            //   },
            // ),
            // ListTile(
            //   leading:
            //       IconButton(onPressed: () {}, icon: const Icon(Icons.create)),
            //   title: const Text("Enquiries & Replies"),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => EnquiryPage()),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: IconButton(
            //       onPressed: () {}, icon: const Icon(Icons.assignment)),
            //   title: const Text("Course Recommendation"),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => rec()),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: IconButton(
            //       onPressed: () {}, icon: const Icon(Icons.star_border)),
            //   title: const Text("Send Rating & Feedback"),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => RatingPage()),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: IconButton(
            //       onPressed: () {}, icon: const Icon(Icons.feedback)),
            //   title: const Text("Complaints & Replies"),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => FirstPage()),
            //     );
            //   },
            // ),
            ListTile(
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notification_add)),
              title: const Text("Notifications"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => noti()),
                );
              },
            ),
            ListTile(
              leading:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
            // ListTile(
            //   leading:
            //       IconButton(onPressed: () {}, icon: const Icon(Icons.check_circle)),
            //   title: const Text("Application Status"),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => AppStatusPage()),
            //     );
            //   },
            // ),
            ListTile(
              leading:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
              title: const Text("Logout"),
              onTap: () async {
                bool? shouldLogout = await showExitConfirmationDialog(context);
                if (shouldLogout ?? false) {
                  // Handle logout action here
                  // For now, pop to the previous screen
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

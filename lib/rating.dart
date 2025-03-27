import 'package:flutter/material.dart';
import 'package:career_guidance/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _rating = 0.0;
  TextEditingController reviewController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  void _sendRating() async {
    final sh = await SharedPreferences.getInstance();
    String review = reviewController.text;
    String url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();

    // Check if rating is provided
    if (_rating == 0.0) {
      _showAlertDialog("Rating Required", "Please select a rating.");
      return; // Exit if rating is not provided
    }

    // Check if form is valid
    if (!_formKey.currentState!.validate()) {
      return; // Exit if the form is not valid
    }

    var data = await http.post(
      Uri.parse(url + "andrating"),
      body: {
        'rating': _rating.toString(),
        'lid': lid,
        'review': review,
      },
    );

    var jsonData = json.decode(data.body);
    String status = jsonData['task'].toString();
    if (status == "ok") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thanks for your Rating and Feedback'),
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context, home());
      });
    } else {
      print("error");
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Give Rating"),
      ),
      body: WillPopScope(
        child: Container(decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/feedback.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Add Rating:",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        RatingBar(
                          initialRating: _rating,
                          onRatingChanged: (newRating) {
                            setState(() {
                              _rating = newRating;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: reviewController,
                          decoration: InputDecoration(
                            hintText: "Enter your feedback",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your feedback';
                            }
                            return null; // Return null if the input is valid
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _sendRating();
                          },
                          child: Text("Submit Rating"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context, home());
          return true;
        },
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  final double initialRating;
  final ValueChanged<double> onRatingChanged;

  RatingBar({required this.initialRating, required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final filled = index < initialRating;
        return GestureDetector(
          onTap: () => onRatingChanged(index + 1.0),
          child: Icon(
            filled ? Icons.star : Icons.star_border,
            size: 40,
            color: Colors.amber,
          ),
        );
      }),
    );
  }
}

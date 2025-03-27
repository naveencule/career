import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:career_guidance/reccourse.dart';

void main() {
  runApp(rec());
}

class rec extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mark Your Interest'),
          backgroundColor: Colors.blue,
        ),
        body: InterestQuestions(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class InterestQuestions extends StatefulWidget {
  @override
  _InterestQuestionsState createState() => _InterestQuestionsState();
}

class _InterestQuestionsState extends State<InterestQuestions> {
  final List<String> socialQuestions = [
    "1. Do you like to make a positive difference in society through your studies?",
    "2. Are you good at analyzing problems and finding solutions related to social issues?",
    "3. Do you like a field where you can learn more about human behavior & society?",
  ];

  final List<String> computerQuestions = [
    "4. Are you passionate about problem-solving & finding solutions to technical challenges?",
    "5. Do you have a knack for logical thinking and enjoy coding or programming?",
    "6. Are you interested in a career that offers opportunities to work on innovative projects and stay up-to-date with the latest technological advancements?",
  ];

  final List<String> medicineQuestions = [
    "7. Are you interested in the natural world and how things work?",
    "8. Do you have a passion for making a positive impact through scientific discoveries?",
    "9. Do you have a passion for helping others & ensuring their wellbeing?",
  ];

  final List<String> commerceQuestions = [
    "10. Do you have a passion for analyzing markets, managing finance & driving business growth?",
    "11. Are you interested in managing financial data?",
    "12. Are you interested in problem-solving within the realm of e-commerce?",
  ];

  final List<String> literatureQuestions = [
    "13. Are you deeply passionate about understanding different cultures, histories, and perspectives through the lens of literature?",
    "14. Do you possess a keen analytical mind and enjoy unraveling the layers of meaning in literary texts, poetry, and prose?",
    "15. Do you find joy in exploring the complexities of language and literature, and delving into the depths of human expression?",
  ];

  int _questionIndex = 0;
  int _totalSocialStars = 0;
  int _totalComputerStars = 0;
  int _totalMedicineStars = 0;
  int _totalCommerceStars = 0;
  int _totalLiteratureStars = 0;

  Map<String, int> _totalStars = {
    'Social': 0,
    'Computer': 0,
    'Medicine': 0,
    'Commerce': 0,
    'Literature': 0,
  };

  List<List<bool>> _starsSelected =
      List.generate(15, (index) => [false, false, false]);

  bool get isStarSelected {
    // Check if any star is selected
    return _starsSelected
        .any((starList) => starList.any((selected) => selected));
  }

 @override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blue.shade400, Colors.blue.shade900],
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            getCurrentQuestion(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                _selectStar(0);
              },
              child: Icon(
                _starsSelected[_questionIndex][0]
                  ? Icons.star
                  : Icons.star_border,
                color: _starsSelected[_questionIndex][0]
                  ? Colors.amber
                  : null,
                size: 40.0,
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectStar(1);
              },
              child: Icon(
                _starsSelected[_questionIndex][1]
                  ? Icons.star
                  : Icons.star_border,
                color: _starsSelected[_questionIndex][1]
                  ? Colors.amber
                  : null,
                size: 40.0,
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectStar(2);
              },
              child: Icon(
                _starsSelected[_questionIndex][2]
                  ? Icons.star
                  : Icons.star_border,
                color: _starsSelected[_questionIndex][2]
                  ? Colors.amber
                  : null,
                size: 40.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0), // Added space between star rating and button
        _questionIndex == 14
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: isStarSelected
                      ? () async {
                          // Handle submission
                          print("Total Social stars: $_totalSocialStars");
                          print("Total Computer stars: $_totalComputerStars");
                          print("Total Medicine stars: $_totalMedicineStars");
                          print("Total Commerce stars: $_totalCommerceStars");
                          print("Total Literature stars: $_totalLiteratureStars");

                          _totalStars['Social'] = _totalSocialStars;
                          _totalStars['Computer'] = _totalComputerStars;
                          _totalStars['Medicine'] = _totalMedicineStars;
                          _totalStars['Commerce'] = _totalCommerceStars;
                          _totalStars['Literature'] = _totalLiteratureStars;

                          // Find the list with the maximum stars
                          String listName = _totalStars.entries
                              .reduce((a, b) => a.value > b.value ? a : b)
                              .key;
                          print("List with maximum stars: $listName");
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('course', listName.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => courserec(title: 'ds'),
                            ),
                          );
                        }
                      : null,
                  child: Text('Submit'),
                ),
              )
            : ElevatedButton( // Navigation button
                onPressed: isStarSelected &&
                    _starsSelected[_questionIndex].any((star) => star)
                    ? () {
                        setState(() {
                          _questionIndex = (_questionIndex + 1) % 15;
                        });
                      }
                    : null,
                child: Text(
                  'Next Question',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
      ],
    ),
  );
}

  String getCurrentQuestion() {
    return [
      ...socialQuestions,
      ...computerQuestions,
      ...medicineQuestions,
      ...commerceQuestions,
      ...literatureQuestions,
    ][_questionIndex];
  }

  void _selectStar(int index) {
    setState(() {
      if (index == 0) {
        _starsSelected[_questionIndex] = [true, false, false];
      } else if (index == 1) {
        _starsSelected[_questionIndex] = [true, true, false];
      } else {
        _starsSelected[_questionIndex] = [true, true, true];
      }
      _updateTotalStars();
    });
  }

  void _updateTotalStars() {
    _totalSocialStars = _starsSelected
        .sublist(0, 3)
        .expand((element) => element)
        .where((selected) => selected)
        .length;
    _totalComputerStars = _starsSelected
        .sublist(3, 6)
        .expand((element) => element)
        .where((selected) => selected)
        .length;
    _totalMedicineStars = _starsSelected
        .sublist(6, 9)
        .expand((element) => element)
        .where((selected) => selected)
        .length;
    _totalCommerceStars = _starsSelected
        .sublist(9, 12)
        .expand((element) => element)
        .where((selected) => selected)
        .length;
    _totalLiteratureStars = _starsSelected
        .sublist(12, 15)
        .expand((element) => element)
        .where((selected) => selected)
        .length;
  }
}

// ignore_for_file: depend_on_referenced_packages, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:emailjs/emailjs.dart' as emailjs;
import '\\widgets\\gradientButton.dart';
//import 'package:firebase_functions_interop/firebase_functions_interop.dart' as functions;

//final config = functions.getFunctions().config;

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum QuestionType { text, radio, dropdown, multipleFields }

class NutritionReport1 {
  int proteinNormalMin;
  int proteinNormalMax;
  int proteinGrowthMin;
  int proteinGrowthMax;
  int carbsMin;
  int carbsMax;
  int bmr;

  NutritionReport1(
      this.proteinNormalMin,
      this.proteinNormalMax,
      this.proteinGrowthMin,
      this.proteinGrowthMax,
      this.carbsMin,
      this.carbsMax,
      this.bmr);
}

class SubQuestion {
  // for multiple questions in the same page
  final String text;
  final QuestionType type;
  final List<String>? options;

  SubQuestion(this.text, this.type, {this.options});
}

class Question {
  final String text;
  final QuestionType type;
  final List<String>? options;
  final List<SubQuestion>?
      subQuestions; // for multiple questions in the same page

  Question(this.text, this.type, {this.options, this.subQuestions});
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  final List<Question> _questions = [
    Question(
      "What is your gender?",
      QuestionType.radio,
      options: ["Male", "Female"],
    ),
    Question(
      "How old are you?",
      QuestionType.text,
    ),
    Question(
      "What is your height? (in cm)",
      QuestionType.text,
    ),
    Question(
      "What is your weight? (in kg)",
      QuestionType.text,
    ),
    Question(
      "Your body fat percentage",
      QuestionType.radio,
      options: ["8%", "15%", "20%", "25%", "35%"],
    ),
    Question(
      "How active are you?",
      QuestionType.radio,
      options: [
        "Not Active",
        "Lightly Active",
        "Moderately Active",
        "Very Active",
        "Extremely Active"
      ],
    ),
    Question(
      "What is your goal?",
      QuestionType.radio,
      options: [
        "Lose weight and get shredded to the bones.",
        "Gain lean Muscle and get big."
      ],
    ),
    Question(
      "Provide the following details:",
      QuestionType.multipleFields,
      subQuestions: [
        SubQuestion("First Name", QuestionType.text),
        SubQuestion("Last Name", QuestionType.text),
        SubQuestion("Phone Number", QuestionType.text),
        SubQuestion("Email", QuestionType.text),
        SubQuestion("Confirm Email", QuestionType.text),
      ],
    ),
    Question(
      "Nutrition Report",
      QuestionType.text,
    ),
  ];
  int _currentQuestionIndex = 0;
  final Map<int, dynamic> _answers = {};
  final Map<int, bool> _isValid = {};
  final Map<int, bool> _isEmailValid = {};
  final NutritionReport1 _rep = NutritionReport1(0, 0, 0, 0, 0, 0, 0);
  int flag = 0;

  Future<int> sendEmail() async {
    Map<String, dynamic> templateParams = {
      'gender': _answers[0],
      'age': _answers[1],
      'height': _answers[2],
      'weight': _answers[3],
      'fat': _answers[4],
      'activity': _answers[5],
      'goal': _answers[6],
      'firstName': (_answers[7] as Map)[0],
      'lastName': (_answers[7] as Map)[1],
      'phone': (_answers[7] as Map)[2],
      'email': (_answers[7] as Map)[3],
      'proteinNormalMin': _rep.proteinNormalMin,
      'proteinNormalMax': _rep.proteinNormalMax,
      'proteinGrowthMin': _rep.proteinGrowthMin,
      'proteinGrowthMax': _rep.proteinGrowthMax,
      'carbsMin': _rep.carbsMin,
      'carbsMax': _rep.carbsMax,
      'bmr': _rep.bmr,
    };

    try {
      await emailjs.send(
        'khayalfit',
        'khayalfit',
        templateParams,
        emailjs.Options(
          publicKey: 'PXoai66gXALOP5zUd',
          privateKey: dotenv.env['PRIVATE_KEY']!,
          //privateKey: config.x.private_key!,
        ),
      );
      //print('SUCCESS!');
      return 1;
    } catch (error) {
      //print('$error');
      return 2;
    }
  }

  // Future<void> sendEmail() async {
  //   final smtpServer = SmtpServer(
  //     dotenv.env['SMTP_SERVER']!,
  //     port: int.parse(dotenv.env['SMTP_PORT']!),
  //     username: dotenv.env['SMTP_USERNAME']!,
  //     password: dotenv.env['SMTP_PASSWORD']!,
  //   );
  //   final message = Message()
  //     ..from = const Address('testerkhayalapp@outlook.com', 'khayalergy')
  //     ..recipients = [ 'khayalfit@gmail.com', 'testerkhayalapp@outlook.com']
  //     ..subject = 'Questionnaire Data'
  //     ..text = 'Gender: ${_answers[0]}\n'
  //         'Age: ${_answers[1]}\n'
  //         'Height: ${_answers[2]} cm\n'
  //         'Weight: ${_answers[3]} kg\n'
  //         'Body Fat Percentage: ${_answers[4]}\n'
  //         'Activity Level: ${_answers[5]}\n'
  //         'Goal: ${_answers[6]}\n'
  //         'First Name: ${(_answers[7] as Map)[0]}\n'
  //         'Last Name: ${(_answers[7] as Map)[1]}\n'
  //         'Phone Number: ${(_answers[7] as Map)[2]}\n'
  //         'Email: ${(_answers[7] as Map)[3]}\n'
  //         'Protein Intake for Normal Health: ${_rep.proteinNormalMin} - ${_rep.proteinNormalMax} grams\n'
  //         'Protein Intake for Growth: ${_rep.proteinGrowthMin} - ${_rep.proteinGrowthMax} grams\n'
  //         'Carbs Intake: ${_rep.carbsMin} - ${_rep.carbsMax} grams\n'
  //         'Fats Intake: 15% - 35% of daily calories intake\n'
  //         'BMR: ${_rep.bmr} calories\n';
  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ${sendReport.toString()}');
  //     flag = 1;
  //   } on MailerException catch (e) {
  //     flag = 2;
  //     print('Error sending email: ${e.message}');
  //   }
  // }

  void _nextQuestion() {
    //next button
    if ((_validateCurrentQuestion() == "truetrue") ||
        (_validateCurrentQuestion() == "truefalse")) {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      if (_validateCurrentQuestion() == "falsefalse" ||
          _validateCurrentQuestion() == "falsetrue") {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Alert'),
              content: const Text('Please fill in all the fields.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Theme.of(context).colorScheme.secondary),
                  ),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _previousQuestion() {
    //back button
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _calculateReport() {
    final weight = int.parse(_answers[3]);
    final height = int.parse(_answers[2]);
    final age = int.parse(_answers[1]);
    final gender = _answers[0];

    _rep.proteinGrowthMin = (weight * 1.76).toInt();
    _rep.proteinGrowthMax = (weight * 2.2).toInt();
    _rep.proteinNormalMin = (weight * 0.88).toInt();
    _rep.proteinNormalMax = (weight * 1.1).toInt();
    _rep.carbsMin = (weight * 2.2).toInt();
    _rep.carbsMax = (weight * 3.85).toInt();
    if (gender == "Male") {
      _rep.bmr = (10 * weight + 6.25 * height - 5 * age + 5).toInt();
    } else {
      _rep.bmr = (10 * weight + 6.25 * height - 5 * age - 161).toInt();
    }
  }

  void _submitAnswers() {
    // submit button
    if (_validateCurrentQuestion() == "truetrue") {
      _calculateReport();
      var flag = sendEmail();
      flag.then((value) {
        if (value == 1) {
          //print(_answers);
          if (_currentQuestionIndex < _questions.length) {
            setState(() {
              _currentQuestionIndex++;
            });
          }
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Thank You'),
                content: const Text('Your data has been received.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).colorScheme.secondary),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Error sending the email.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).colorScheme.secondary),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          //print('Error sending email!!');
        }
      });
      //sendEmail is commented as there is a monthly qouta for the emails provided by EmailJS
      
    } else {
      if (_validateCurrentQuestion() == "falsefalse" ||
          _validateCurrentQuestion() == "falsetrue") {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Alert'),
              content: const Text('Please fill in all the fields.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Theme.of(context).colorScheme.secondary),
                  ),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        if (_validateCurrentQuestion() == "truefalse") {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text('Email and Confirm Email do not match.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).colorScheme.secondary),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  String _validateCurrentQuestion() {
    // to check that all questions are answered
    final question = _questions[_currentQuestionIndex];
    bool isValid = false;
    bool isEmailValid = false;

    if (question.type == QuestionType.text) {
      final answer = _answers[_currentQuestionIndex];
      isValid = answer != null && answer.isNotEmpty;
    } else if (question.type == QuestionType.radio) {
      final answer = _answers[_currentQuestionIndex];
      isValid = answer != null;
    } else if (question.type == QuestionType.dropdown) {
      final answer = _answers[_currentQuestionIndex];
      isValid = answer != null;
    } else if (question.type == QuestionType.multipleFields) {
      final answers = _answers[_currentQuestionIndex] as Map?;
      if (answers == null) {
        isValid = false;
      } else {
        isValid = question.subQuestions!.every((subQuestion) {
          final subAnswer =
              answers[question.subQuestions!.indexOf(subQuestion)];
          return subAnswer != null &&
              (subAnswer is String ? subAnswer.isNotEmpty : subAnswer != null);
        });
        if (isValid &&
            (answers.values.elementAt(3) != (answers.values.elementAt(4)))) {
          // to check that email and confirm email are identical
          isEmailValid = false;
        } else {
          if (isValid) isEmailValid = true;
        }
      }
    }

    setState(() {
      _isValid[_currentQuestionIndex] = isValid;
      _isEmailValid[_currentQuestionIndex] = isEmailValid;
    });
    return isValid.toString() + isEmailValid.toString();
  }

  void _saveAnswer(int index, dynamic answer) {
    // saving the answer for every question
    _answers[index] = answer;
  }

  void _saveSubAnswer(int questionIndex, int subQuestionIndex, dynamic answer) {
    //saving the answers for a page that has multiple questions in it
    if (_answers[questionIndex] == null) {
      _answers[questionIndex] = {};
    }
    (_answers[questionIndex] as Map)[subQuestionIndex] = answer;
  }

  Widget _buildDecoratedText(String text, {bool isStatic = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      // gradient: const LinearGradient(
      //   colors: [
      //     Color.fromARGB(255, 156, 151, 151),
      //     Color.fromARGB(255, 200, 200, 200),
      //   ],
      //   begin: Alignment.topLeft,
      //   end: Alignment.bottomRight,
      // ),
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 0,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex != _questions.length - 1) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          title: const Text('Questionnaire'),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            constraints: const BoxConstraints(
              maxWidth: 500,
              maxHeight: 450,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(
                  20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.5), // add a shadow effect
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final question = _questions[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      question.text,
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (question.type == QuestionType.text)
                      TextField(
                        onChanged: (value) => _saveAnswer(index, value),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          labelText: 'Your Answer',
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    if (question.type == QuestionType.radio)
                      ...question.options!.map((option) {
                        return Column(
                          children: [
                            RadioListTile(
                              title: Text(option),
                              value: option,
                              activeColor: Colors.black,
                              groupValue: _answers[index],
                              onChanged: (value) =>
                                  setState(() => _saveAnswer(index, value)),
                            ),
                          ],
                        );
                        // ignore: unnecessary_to_list_in_spreads
                      }).toList(),
                    if (question.type == QuestionType.multipleFields &&
                        question.subQuestions != null)
                      Expanded(
                        child: ListView.builder(
                          itemCount: question.subQuestions!.length,
                          itemBuilder: (context, subIndex) {
                            final subQuestion =
                                question.subQuestions![subIndex];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    subQuestion.text,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 8),
                                  if (subQuestion.text == 'Phone Number')
                                    TextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (value) => _saveSubAnswer(
                                          index, subIndex, value),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        labelText: subQuestion.text,
                                      ),
                                    )
                                  else
                                    TextField(
                                      onChanged: (value) => _saveSubAnswer(
                                          index, subIndex, value),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        labelText: subQuestion.text,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (_currentQuestionIndex > 0 &&
                            _currentQuestionIndex < _questions.length - 2)
                          Center(
                            child: SizedBox(
                              width: 150,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: _previousQuestion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  minimumSize: const Size(150, 40),
                                  maximumSize: const Size(150, 40),
                                ),
                                child: const Text('Back'),
                              ),
                            ),
                          ),
                        if (_currentQuestionIndex == _questions.length - 2)
                          // Center(
                          //   child: SizedBox(
                          //     width: 150,
                          //     height: 40,
                          //     child: ElevatedButton(
                          //       onPressed: _previousQuestion,
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: Theme.of(context).colorScheme.secondary,
                          //         minimumSize: const Size(150, 40),
                          //         maximumSize: const Size(150, 40),
                          //       ),
                          //       child: const Text('Back'),
                          //     ),
                          //   ),
                          // ),
                          Center(
                            child: SizedBox(
                              width: 150, 
                              height: 40,
                              child: ElevatedButton(
                                onPressed: _submitAnswers,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  minimumSize: const Size(150, 40),
                                  maximumSize: const Size(150, 40),
                                ),
                                child: const Text('Submit'),
                              ),
                            ),
                          ),
                        if (_currentQuestionIndex < _questions.length - 2)
                           ElevatedButton(
                                onPressed: _nextQuestion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  minimumSize: const Size(150, 40),
                                  maximumSize: const Size(150, 40),
                                ),
                                child: const Text('Next'),
                              ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Nutrition Report'),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            constraints: const BoxConstraints(
              maxWidth: 500,
              maxHeight: 450,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Your Nutrition Report',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                   _buildDecoratedText(
                'Protein Intake for Normal Health: ${_rep.proteinNormalMin} - ${_rep.proteinNormalMax} grams'),
                        _buildDecoratedText(
                'Protein Intake for Growth: ${_rep.proteinGrowthMin} - ${_rep.proteinGrowthMax} grams'),
                        _buildDecoratedText(
                'Carbs Intake: ${_rep.carbsMin} - ${_rep.carbsMax} grams'),
                        _buildDecoratedText(
                'Fats Intake: 15% - 35% of daily calories intake', isStatic: true),
                        _buildDecoratedText('BMR: ${_rep.bmr} calories'),
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          minimumSize: const Size(120, 40),
                          maximumSize: const Size(120, 40),
                        ),
                        child: const Text('OK'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

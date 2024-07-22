// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  Future<void> sendEmail() async {
    final smtpServer = SmtpServer(
      dotenv.env['SMTP_SERVER']!,
      port: int.parse(dotenv.env['SMTP_PORT']!),
      username: dotenv.env['SMTP_USERNAME']!,
      password: dotenv.env['SMTP_PASSWORD']!,
      ignoreBadCertificate: true,
    );
    final message = Message()
      ..from = const Address('testingkhayalapp@outlook.com', 'khayalergy')
      ..recipients = ['testingkhayalapp@outlook.com', 'khayalfit@gmail.com']
      ..subject = 'Questionnaire Data'
      ..text = 'Gender: ${_answers[0]}\n'
          'Age: ${_answers[1]}\n'
          'Height: ${_answers[2]} cm\n'
          'Weight: ${_answers[3]} kg\n'
          'Body Fat Percentage: ${_answers[4]}\n'
          'Activity Level: ${_answers[5]}\n'
          'Goal: ${_answers[6]}\n'
          'First Name: ${(_answers[7] as Map)[0]}\n'
          'Last Name: ${(_answers[7] as Map)[1]}\n'
          'Phone Number: ${(_answers[7] as Map)[2]}\n'
          'Email: ${(_answers[7] as Map)[3]}\n'
          'Protein Intake for Normal Health: ${_rep.proteinNormalMin} - ${_rep.proteinNormalMax} grams\n'
          'Protein Intake for Growth: ${_rep.proteinGrowthMin} - ${_rep.proteinGrowthMax} grams\n'
          'Carbs Intake: ${_rep.carbsMin} - ${_rep.carbsMax} grams\n'
          'Fats Intake: 15% - 35% of daily calories intake\n'
          'BMR: ${_rep.bmr} calories\n';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } on MailerException catch (e) {
      print('Error sending email: $e');
    }
  }

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
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).colorScheme.secondary),
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
      print(_answers);
      _calculateReport();
      sendEmail();
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
                  backgroundColor: WidgetStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary),
                ),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
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
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).colorScheme.secondary),
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
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.secondary),
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

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex != _questions.length - 1) {
      return Scaffold(
        // to show the questionnaire
        appBar: AppBar(
          title: const Text('Questionnaire'),
        ),
        body: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _questions.length,
          itemBuilder: (context, index) {
            final question = _questions[index];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  if (question.type == QuestionType.radio)
                    ...question.options!.map((option) {
                      return RadioListTile(
                        title: Text(option),
                        value: option,
                        activeColor: Colors.black,
                        groupValue: _answers[index],
                        onChanged: (value) =>
                            setState(() => _saveAnswer(index, value)),
                      );
                      // ignore: unnecessary_to_list_in_spreads
                    }).toList(),
                  // if (question.type == QuestionType.dropdown)
                  //   DropdownButton<String>(
                  //     value: _answers[index],
                  //     onChanged: (value) =>
                  //         setState(() => _saveAnswer(index, value)),
                  //     items: question.options!.map((String option) {
                  //       return DropdownMenuItem<String>(
                  //         value: option,
                  //         child: Text(option),
                  //       );
                  //     }).toList(),
                  //   ),
                  if (question.type == QuestionType.multipleFields &&
                      question.subQuestions != null)
                    Expanded(
                      child: ListView.builder(
                        itemCount: question.subQuestions!.length,
                        itemBuilder: (context, subIndex) {
                          final subQuestion = question.subQuestions![subIndex];
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
                                if (subQuestion.text ==
                                    'Phone Number') // to make sure phone number is entered in digits only
                                  TextField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) =>
                                        _saveSubAnswer(index, subIndex, value),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      labelText: subQuestion.text,
                                    ),
                                  )
                                else
                                  TextField(
                                    onChanged: (value) =>
                                        _saveSubAnswer(index, subIndex, value),
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
                  if (_currentQuestionIndex <
                      _questions.length -
                          2) // to show next button if there are more questions
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondary),
                      ),
                      child: const Text('Next'),
                    )
                  else if (_currentQuestionIndex !=
                      _questions.length -
                          1) // to show submit button if there are no more questions and not at the report page
                    ElevatedButton(
                      onPressed: _submitAnswers,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondary),
                      ),
                      child: const Text('Submit'),
                    ),
                  if (_currentQuestionIndex >
                      0) // to show back button if there are previous questions
                    ElevatedButton(
                      onPressed: _previousQuestion,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondary),
                      ),
                      child: const Text('Back'),
                    ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      // to show the report page
      return Scaffold(
        appBar: AppBar(
          title: const Text('Nutrition Report'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Your Nutrition Report',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Protein Intake for Normal Health: ${_rep.proteinNormalMin} - ${_rep.proteinNormalMax} grams',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Protein Intake for Growth: ${_rep.proteinGrowthMin} - ${_rep.proteinGrowthMax} grams',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Carbs Intake: ${_rep.carbsMin} - ${_rep.carbsMax} grams',
              style: const TextStyle(fontSize: 18),
            ),
            const Text(
              'Fats Intake: 15% - 35% of daily calories intake',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'BMR: ${_rep.bmr} calories',
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
              ),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

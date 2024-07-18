import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum QuestionType { text, radio, dropdown, multipleFields }

class SubQuestion {
  final String text;
  final QuestionType type;
  final List<String>? options;

  SubQuestion(this.text, this.type, {this.options});
}

class Question {
  final String text;
  final QuestionType type;
  final List<String>? options;
  final List<SubQuestion>? subQuestions;

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
      "What is your age range?",
      QuestionType.radio,
      options: ["18-23", "24-29", "30-35", "36-41", "42-47", "48-53", "54+"],
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
    // Question(
    //   "What is your age range?",
    //   QuestionType.dropdown,
    //   options: ["18-25", "26-35", "36-45", "46+"],
    // ),
  ];
  int _currentQuestionIndex = 0;
  Map<int, dynamic> _answers = {};
  Map<int, bool> _isValid = {};

  void _nextQuestion() {
  if (_validateCurrentQuestion()) {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submitAnswers() {
    if (_validateCurrentQuestion()) {
      print(_answers);
    }
  }

    bool _validateCurrentQuestion() {
    final question = _questions[_currentQuestionIndex];
    bool isValid = false;

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
          final subAnswer = answers[question.subQuestions!.indexOf(subQuestion)];
          return subAnswer != null && (subAnswer is String ? subAnswer.isNotEmpty : subAnswer != null);
        });
      }
    }

    setState(() {
      _isValid[_currentQuestionIndex] = isValid;
    });

    return isValid;
  }

  void _saveAnswer(int index, dynamic answer) {
    _answers[index] = answer;
  }

  void _saveSubAnswer(int questionIndex, int subQuestionIndex, dynamic answer) {
    if (_answers[questionIndex] == null) {
      _answers[questionIndex] = {};
    }
    (_answers[questionIndex] as Map)[subQuestionIndex] = answer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
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
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                if (question.type == QuestionType.text)
                  TextField(
                    onChanged: (value) => _saveAnswer(index, value),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Answer',
                    ),
                  ),
                if (question.type == QuestionType.radio)
                  ...question.options!.map((option) {
                    return RadioListTile(
                      title: Text(option),
                      value: option,
                      groupValue: _answers[index],
                      onChanged: (value) =>
                          setState(() => _saveAnswer(index, value)),
                    );
                  }).toList(),
                if (question.type == QuestionType.dropdown)
                  DropdownButton<String>(
                    value: _answers[index],
                    onChanged: (value) =>
                        setState(() => _saveAnswer(index, value)),
                    items: question.options!.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
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
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 8),
                                if (subQuestion.text == 'Phone Number')
                                TextField(
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  onChanged: (value) =>
                                      _saveSubAnswer(index, subIndex, value),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: subQuestion.text,
                                  ),
                                )
                                else
                                TextField(
                                  onChanged: (value) =>
                                      _saveSubAnswer(index, subIndex, value),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: subQuestion.text,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 20),
                if (_currentQuestionIndex < _questions.length - 1)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Text('Next'),
                  )
                else
                  ElevatedButton(
                    onPressed: _submitAnswers,
                    child: Text('Submit'),
                  ),
                if (_currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: _previousQuestion,
                    child: Text('Back'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

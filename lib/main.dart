import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;

  List<Question> questions = [
    Question('My name is Sumit.', true),
    Question('I am a working professional.', false),
    Question('This is for Oisis Internship.', true),
    Question('You live in india.', true),
  ];

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = questions[currentQuestionIndex].answer;

    if (userAnswer == correctAnswer) {
      setState(() {
        score++;
      });
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Quiz Completed'),
            content: Text('Your score: $score/${questions.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Restart Quiz'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              questions[currentQuestionIndex].questionText,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                checkAnswer(true);
              },
              child: const Text('True'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text('False'),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final bool answer;

  Question(this.questionText, this.answer);
}

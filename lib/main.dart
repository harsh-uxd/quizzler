import 'package:flutter/material.dart';
import 'quiz-brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF252525),
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // List<String> questions = [
  //   'You can lead a cow downstairs but not upstairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.',
  // ];
  //
  //
  // List<bool> answers = [
  //   false,
  //   true,
  //   true,
  // ];
  //
  // Question q1 = Question(
  //   q: 'You can lead a cow downstairs but not upstairs.',
  //   a: false,
  // );

  QuizBrain quizBrain = QuizBrain();

  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      if (quizBrain.finished() == true) {
        Alert(
          context: context,
          title: 'FINISHED',
          desc: 'You\'ve reached the end of the quiz!',
        ).show();
        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (userAnswer == correctAnswer) {
          print("User got it right");
          scoreKeeper.add(
            Icon(
              Icons.check_box_rounded,
              color: Color(0xFF26BD82),
            ),
          );
        } else {
          print("User got it wrong!");
          scoreKeeper.add(
            Icon(
              Icons.close_rounded,
              color: Color(0xFFFF5956),
            ),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: scoreKeeper,
          ),
        ),
        Expanded(
          flex: 5,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(25),
            child: Text(
              quizBrain.getQuestion(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          )),
        ),
        Expanded(
          child: FlatButton(
            color: Color(0xFF26BD82),
            onPressed: () {
              checkAnswer(true);
            },
            child: Text(
              "TRUE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 5,
              ),
            ),
          ),
        ),
        Expanded(
          child: FlatButton(
            color: Color(0xFFFF5956),
            onPressed: () {
              checkAnswer(false);
            },
            child: Text(
              "FALSE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

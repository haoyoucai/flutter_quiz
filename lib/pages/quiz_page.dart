import 'package:flutter/material.dart';
import 'package:flutter_app/model/Question.dart';
import 'package:flutter_app/model/Quiz.dart';
import 'package:flutter_app/pages/score_page.dart';
import 'package:flutter_app/ui/answer_button.dart';
import 'package:flutter_app/ui/correct_wrong_overlay.dart';
import 'package:flutter_app/ui/question_text.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Elon Musk is human", false),
    new Question("Pizza is healthy", false),
    new Question("Flutter is awesome", true)
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    print(answer);
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      print(answer);
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(children: <Widget>[
          new AnswerButton(true, () => handleAnswer(true)),
          new QuestionText(questionText, questionNumber),
          new AnswerButton(false, () => handleAnswer(false))
        ]),
        overlayShouldBeVisible == true
            ? new CorrectWrongOverlay(isCorrect, () {
                if (quiz.length <= questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ScorePage(quiz.score, quiz.length)),
                      (Route route) => route == null);
                  return;
                }
                currentQuestion = quiz.nextQuestion;
                setState(() {
                  questionNumber = quiz.questionNumber;
                  questionText = currentQuestion.question;
                  overlayShouldBeVisible = false;
                });
              })
            : new Container()
      ],
    );
  }
}

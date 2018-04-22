import 'package:flutter/material.dart';
import '../utils/question.dart';
import '../utils/quiz.dart';
import '../ui/answer_button.dart';
import '../ui/question_text.dart';
import '../ui/correct_wrong_overlay.dart';
import './score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> with SingleTickerProviderStateMixin {

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question('Elon Musk is Human', false),
    new Question('Pizza is healthy', false),
    new Question('Flutter is awesome', true)
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool visibleOverlay = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState((){
      visibleOverlay = true;
    });
  }

  void gotoScorePage(BuildContext context, Quiz quiz){
    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
      builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)
    ), ModalRoute.withName('/'));
  }

  void overlayCallback(BuildContext context){
    if (quiz.length == questionNumber) gotoScorePage(context, quiz);
    currentQuestion = quiz.nextQuestion;
    this.setState((){
      visibleOverlay = false;
      questionText = currentQuestion.question;
      questionNumber = quiz.questionNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column( // Main Page
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false))
          ],
        ),
        visibleOverlay == true ? new CorrectWrongOverlay(isCorrect, () => overlayCallback(context)) : new Container()
      ],
    );
  }
}
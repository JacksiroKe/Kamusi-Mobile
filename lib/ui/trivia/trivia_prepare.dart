import 'package:anisi_controls/anisi_controls.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/app_database.dart';
import '../../../data/models/trivia.dart';
import '../../../data/models/trivia_quiz.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';
import 'quiz_screen.dart';

class TriviaPrepare extends StatefulWidget {
  final Trivia trivia;
  const TriviaPrepare({Key? key, required this.trivia}) : super(key: key);

  @override
  TriviaPrepareState createState() => TriviaPrepareState();
}

class TriviaPrepareState extends State<TriviaPrepare> {
  AppDatabase db = AppDatabase();
  AsInformer? informer = AsInformer.setUp(
      1,
      AppStrings.gettingReady,
      AppColors.primaryColor,
      Colors.transparent,
      Colors.white,
      10) as AsInformer?;

  late Future<Database> dbFuture;
  List<TriviaQuiz> questions = [];

  int quizCount = 0;
  var triviaWords;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initBuild(context));
  }

  /// Run anything that needs to be run immediately after Widget build
  void initBuild(BuildContext context) async {
    informer!.show();
    //triviaWords = widget.trivia.questions.split(" ");
    quizCount = triviaWords.length;
    requestData();
  }

  void requestData() async {
    /*String wordIDs = widget.trivia.questions.replaceAll(" ", ", ");

    dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TriviaQuiz>> itemListFuture = db.getTriviaEntries(widget.trivia.level, wordIDs);
      itemListFuture.then((resultList) {
        setState(() {
          questions = resultList;
          nextAction();
        });
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: informer,
    );
  }

  Future<void> nextAction() async {
    informer!.hide();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                QuizScreen(trivia: widget.trivia, questions: questions)));
  }
}

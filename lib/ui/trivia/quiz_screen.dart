import 'dart:async';

import 'package:anisi_controls/anisi_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:kamusi/utils/styles/app_colors.dart';

import '../../../data/models/trivia.dart';
import '../../../data/models/trivia_quiz.dart';
import '../../../utils/strings/strings.dart';
import 'finish_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<TriviaQuiz> questions;
  final Trivia trivia;

  const QuizScreen({Key? key, required this.questions, required this.trivia})
      : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);

  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late TriviaQuiz question;

  @override
  Widget build(BuildContext context) {
    question = widget.questions[_currentIndex];

    return WillPopScope(
      onWillPop: (() => onBackPressed(context)) as Future<bool> Function(),
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(
            "Trivia: " +
                widget.trivia.description +
                " - Msl " +
                widget.questions.length.toString(),
          ),
          elevation: 0,
        ),
        body: mainBody(),
      ),
    );
  }

  Widget mainBody() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            height: 200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              quizBody(),
              SizedBox(height: 20),
              quizOptions(),
              quizActions(),
            ],
          ),
        )
      ],
    );
  }

  Widget quizBody() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white70,
          child: Text("${_currentIndex + 1}"),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Text(
            HtmlUnescape().convert(widget.questions[_currentIndex].title!),
            softWrap: true,
            style: MediaQuery.of(context).size.width > 800
                ? _questionStyle.copyWith(fontSize: 30.0)
                : _questionStyle,
          ),
        ),
      ],
    );
  }

  Widget quizOptions() {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /*...question.options!.map(
            (option) => RadioListTile(
              title: Text(
                HtmlUnescape().convert("$option"),
                style: MediaQuery.of(context).size.width > 800
                    ? TextStyle(fontSize: 30.0)
                    : null,
              ),
              groupValue: _answers[_currentIndex],
              value: option,
              onChanged: (value) {
                setState(() {
                  _answers[_currentIndex] = option;
                });
              },
            ),
          ),*/
        ],
      ),
    );
  }

  Widget quizActions() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: RaisedButton(
          color: AppColors.baseColor,
          onPressed: _nextSubmit,
          child: Padding(
            child: Text(
              _currentIndex == (widget.questions.length - 1)
                  ? AppStrings.submit.toUpperCase()
                  : AppStrings.next.toUpperCase(),
              style: TextStyle(fontSize: 30),
            ),
            padding: const EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }

  void _nextSubmit() {
    //playKamusiAudio();
    if (_answers[_currentIndex] == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppStrings.selectAnswer),
      ));
      return;
    }
    if (_currentIndex < (widget.questions.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => FinishScreen(
              trivia: widget.trivia,
              questions: widget.questions,
              answers: _answers)));
    }
  }

  Future<bool?> onBackPressed(BuildContext context) async {
    return Alert(
      context: context,
      alertTitle: AppStrings.justaMinute,
      alertMessage: AppStrings.areYouleaving,
      buttons: [
        AlertButton(
          text: AppStrings.yes.toUpperCase(),
          onPressed: () => Navigator.pop(context, true),
        ),
        AlertButton(
          text: AppStrings.no.toUpperCase(),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    ).show();
  }
}

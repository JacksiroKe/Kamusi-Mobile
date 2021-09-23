import 'package:anisi_controls/anisi_controls.dart';
import 'package:flutter/material.dart';
import 'package:kamusi/cubit/cubit.dart';
import 'package:kamusi/data/base/event_object.dart';
import 'package:kamusi/services/futures.dart';

import '../../../data/models/models.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';
import '../quiz_screen.dart';

// ignore: must_be_immutable
class TriviaOptionsLimitBody extends StatelessWidget {
  final TriviaCat category;
  TriviaOptionsLimitBody(this.category);

  int? level, limit;
  bool? processing = false;
  List<TriviaQuiz> questions = [];
  AsLoader? loader = AsLoader.setUp(AppColors.primaryColor) as AsLoader?;

  @override
  Widget build(BuildContext context) {
    limit = KamusiCubit.get(context).triviaLimit;
    level = KamusiCubit.get(context).triviaLevel;

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing: 16.0,
        spacing: 16.0,
        children: <Widget>[
          SizedBox(width: 0.0),
          ActionChip(
            label: Text("10"),
            labelStyle:
                TextStyle(color: limit == 10 ? Colors.white : Colors.black),
            backgroundColor:
                limit == 10 ? AppColors.baseColor : AppColors.secondaryColor,
            onPressed: () => KamusiCubit.get(context).onTriviaSetLimit(10),
          ),
          ActionChip(
            label: Text("20"),
            labelStyle:
                TextStyle(color: limit == 20 ? Colors.white : Colors.black),
            backgroundColor:
                limit == 20 ? AppColors.baseColor : AppColors.secondaryColor,
            onPressed: () => KamusiCubit.get(context).onTriviaSetLimit(20),
          ),
          ActionChip(
            label: Text("30"),
            labelStyle:
                TextStyle(color: limit == 30 ? Colors.white : Colors.black),
            backgroundColor:
                limit == 30 ? AppColors.baseColor : AppColors.secondaryColor,
            onPressed: () => KamusiCubit.get(context).onTriviaSetLimit(30),
          ),
          ActionChip(
            label: Text("40"),
            labelStyle:
                TextStyle(color: limit == 40 ? Colors.white : Colors.black),
            backgroundColor:
                limit == 40 ? AppColors.baseColor : AppColors.secondaryColor,
            onPressed: () => KamusiCubit.get(context).onTriviaSetLimit(40),
          ),
          ActionChip(
            label: Text("50"),
            labelStyle:
                TextStyle(color: limit == 50 ? Colors.white : Colors.black),
            backgroundColor:
                limit == 50 ? AppColors.baseColor : AppColors.secondaryColor,
            onPressed: () => KamusiCubit.get(context).onTriviaSetLimit(50),
          ),
        ],
      ),
    );
  }

  void startTrivia(BuildContext context) async {
    processing = true;
    loader!.show();

    EventObject eventObject = await getQuestions(category.id!, level!, limit!);

    switch (eventObject.id) {
      case EventConstants.requestSuccessful:
        {
          questions = TriviaQuiz.fromData(
              eventObject.object as List<Map<String, dynamic>>);
          nextAction(context);
        }
        break;

      case EventConstants.requestUnsuccessful:
        {
          processing = false;
          loader!.hide();
        }
        break;

      case EventConstants.noInternetConnection:
        {
          processing = false;
          loader!.hide();
        }
        break;
    }
  }

  Future<void> nextAction(BuildContext context) async {
    Trivia trivial =
        new Trivia(category.number, category.title, questions.length, level);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(trivia: trivial, questions: questions),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:anisi_controls/anisi_controls.dart';

import '../services/app_futures.dart';
import '../data/base/event_object.dart';
import '../services/app_settings.dart';
import '../data/app_database.dart';
import '../data/models/trivia.dart';
import '../data/models/trivia_cat.dart';
import '../data/models/trivia_quiz.dart';
import '../utils/colors.dart';
import '../utils/api_utils.dart';
import '../utils/app_utils.dart';
import '../views/trivia/quiz_screen.dart';

class TriviaOptions extends StatefulWidget {
  final TriviaCat category;
  const TriviaOptions({Key key, this.category}) : super(key: key);

  @override
  TriviaOptionsState createState() => TriviaOptionsState();
}

class TriviaOptionsState extends State<TriviaOptions> {
  AsLoader loader = AsLoader.setUp(ColorUtils.primaryColor);
  AppDatabase db = AppDatabase();
  Future<Database> dbFuture;

  int level, limit;
  bool processing;
  List<TriviaQuiz> questions = [];

  @override
  void initState() {
    super.initState();
    limit = 10;
    level = 1;
    processing = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => initBuild(context));
  }

  /// Method to run anything that needs to be run immediately after Widget build
  void initBuild(BuildContext context) async {
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FadeInImage(
                image:
                    NetworkImage(ApiConstants.baseUrl + widget.category.icon),
                placeholder: AssetImage(AppStrings.appIcon),
                height: 30,
                width: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            AppStrings.triviaCartegory + widget.category.title.toUpperCase(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
        body: mainBody(),
      ),
    );
  }

  Widget mainBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(AppStrings.triviaQuizInstruction,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          limitBox(),
          Divider(),
          Text(AppStrings.triviaLevelInstruction,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          levelBox(),
          Divider(),
          processing
            ? Container()
            : RaisedButton(
                child: Text(
                  AppStrings.triviaStart.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                onPressed: startTrivia,
                color: Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.black
                    : ColorUtils.baseColor,
              ),
          loader,
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget limitBox() {
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
            labelStyle: TextStyle(
                color: limit == 10 ? ColorUtils.white : ColorUtils.black),
            backgroundColor: limit == 10
                ? Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.black
                    : ColorUtils.baseColor
                : Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.white2
                    : ColorUtils.secondaryColor,
            onPressed: () => setLimit(10),
          ),
          ActionChip(
            label: Text("20"),
            labelStyle: TextStyle(
                color: limit == 20 ? ColorUtils.white : ColorUtils.black),
            backgroundColor: limit == 20
                ? Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.black
                    : ColorUtils.baseColor
                : Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.white2
                    : ColorUtils.secondaryColor,
            onPressed: () => setLimit(20),
          ),
          ActionChip(
            label: Text("30"),
            labelStyle: TextStyle(
                color: limit == 30 ? ColorUtils.white : ColorUtils.black),
            backgroundColor: limit == 30
                ? Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.black
                    : ColorUtils.baseColor
                : Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.white2
                    : ColorUtils.secondaryColor,
            onPressed: () => setLimit(30),
          ),
          ActionChip(
            label: Text("40"),
            labelStyle: TextStyle(
                color: limit == 40 ? ColorUtils.white : ColorUtils.black),
            backgroundColor: limit == 40
                ? Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.black
                    : ColorUtils.baseColor
                : Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.white2
                    : ColorUtils.secondaryColor,
            onPressed: () => setLimit(40),
          ),
          ActionChip(
            label: Text("50"),
            labelStyle: TextStyle(
                color: limit == 50 ? ColorUtils.white : ColorUtils.black),
            backgroundColor: limit == 50
                ? Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.black
                    : ColorUtils.baseColor
                : Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.white2
                    : ColorUtils.secondaryColor,
            onPressed: () => setLimit(50),
          ),
        ],
      ),
    );
  }

  Widget levelBox() {
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
            label: Text("Kiwango 1"),
            labelStyle: TextStyle(
                color: level == 1 ? ColorUtils.white : ColorUtils.black),
            backgroundColor: level == 1
                ? Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.black
                    : ColorUtils.baseColor
                : Provider.of<AppSettings>(context).isDarkMode
                    ? ColorUtils.white2
                    : ColorUtils.secondaryColor,
            onPressed: () => setlevel(1),
          ),
        ],
      ),
    );
  }

  setLimit(int value) {
    setState(() {
      limit = value;
    });
  }

  setlevel(int value) {
    setState(() {
      level = value;
    });
  }

  void startTrivia() async {
    setState(() {
      processing = true;
      loader.showWidget();
    });
    
    EventObject eventObject = await getQuestions(widget.category.id, level, limit);

    switch (eventObject.id) {
      case EventConstants.requestSuccessful:
        {
          setState(() {
            questions = TriviaQuiz.fromData(eventObject.object);
            nextAction();
          });
        }
        break;

      case EventConstants.requestUnsuccessful:
        {
          setState(() {
            processing = false;
            loader.hideWidget();
          });
        }
        break;

      case EventConstants.noInternetConnection:
        {
          setState(() {
            processing = false;
            loader.hideWidget();
          });
        }
        break;
    }
  }

  Future<void> nextAction() async {
    Trivia trivial = new Trivia(widget.category.number, widget.category.title, questions.length, level);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(trivia: trivial, questions: questions),
      ),
    );
  }
}

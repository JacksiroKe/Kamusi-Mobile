import 'package:anisi_controls/anisi_controls.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/app_database.dart';
import '../../../data/models/models.dart';
import '../../../services/app_core.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';
import 'quiz_screen.dart';
import 'trivia_subscription.dart';

class TriviaList extends StatefulWidget {
  @override
  TriviaListState createState() => TriviaListState();
}

class TriviaListState extends State<TriviaList> {
  AsLoader? loader = AsLoader.setUp(AppColors.primaryColor) as AsLoader?;
  AsInformer? notice = AsInformer.setUp(3, AppStrings.nothing, Colors.red,
      Colors.transparent, Colors.white, 10) as AsInformer?;

  AppDatabase db = AppDatabase();

  late Future<Database> dbFuture;
  List<Trivia> items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initBuild(context));
  }

  /// Run anything that needs to be run immediately after Widget build
  void initBuild(BuildContext context) async {
    bool isMet = await AppCore.isTriviaTrialDeadlineMet();

    if (isMet != null)
      loadListView();
    else
      showModalBottomSheet(
        context: context,
        builder: (sheetContext) => BottomSheet(
          builder: (_) => TriviaSubscription(),
          onClosing: () {},
        ),
      );
  }

  void loadListView() async {
    dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Trivia>> itemListFuture = db.getTriviaList();
      itemListFuture.then((resultList) {
        setState(() {
          items = resultList;
          if (items.length == 0)
            notice!.show();
          else
            notice!.hide();
        });
      });
    });
  }

  void requestQuestionData(Trivia trivia) async {
    /*String wordIDs = trivia.questions.replaceAll(" ", ", ");
    List<TriviaQuiz> questions = [];

    dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TriviaQuiz>> itemListFuture = db.getTriviaEntries(trivia.level, wordIDs);
      itemListFuture.then((resultList) {
        setState(() {
          questions = resultList;
          nextAction(trivia, questions);
        });
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.triviaListPage),
        elevation: 10,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              initBuild(context);
            },
          ),
          menuPopup()
        ],
      ),
      body: mainBody(),
    );
  }

  Widget menuPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Container(),
            /*child: Consumer<Settings>(builder: (context, Settings settings, _) {
              return ListTile(
                onTap: () {},
                title: Text(AppStrings.darkMode),
                trailing: Switch(
                  onChanged: (bool value) => settings.setDarkMode(value),
                  value: settings.isDarkMode,
                ),
              );
            }),*/
          ),
        ],
        onCanceled: () {},
        onSelected: (value) {
          //selectedMenu(value, context);
        },
        icon: Icon(
            Theme.of(context).platform == TargetPlatform.iOS
                ? Icons.more_horiz
                : Icons.more_vert,
            color: Colors.white),
      );

  Widget mainBody() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: triviaItem,
            ),
          ),
          Container(
            height: 200,
            child: notice,
          ),
          Container(
            height: 200,
            child: Center(
              child: loader,
            ),
          ),
        ],
      ),
    );
  }

  Widget triviaItem(BuildContext context, int index) {
    Trivia trivia = items[index];
    return Container();
    /*var questions = trivia.questions.split(" ");
    String level = "Rahisi";
    if (trivia.level == 'medium') level = "Wastani";
    else if (trivia.level == 'hard') level = "Ngumu";

    return Column(
      children: [
        ListTile(
          leading: Image.asset(AppStrings.appIcon, height: 40, width: 40),
          title: Text(
            trivia.id.toString() + ". " + trivia.description.toUpperCase() + " - Maswali " + questions.length.toString(),
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            "Kiwango: " + level + "; Alama: " + trivia.score.toString()  + "; Muda: " + trivia.time,
            style: TextStyle(fontSize: 15),
          ),
          onTap: () {
            requestQuestionData(trivia);
          }
        ),
        Divider(height: 1),
      ],
    );*/
  }

  Future<void> nextAction(Trivia trivia, List<TriviaQuiz> questions) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => QuizScreen(trivia: trivia, questions: questions)));
  }
}

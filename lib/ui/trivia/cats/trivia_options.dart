import 'package:anisi_controls/anisi_controls.dart';
import 'package:flutter/material.dart';

import '../../../cubit/cubit.dart';
import '../../../data/models/models.dart';
import '../../../ui/trivia/cats/trivia.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';

// ignore: must_be_immutable
class TriviaOptions extends StatelessWidget {
  final TriviaCat category;
  TriviaOptions(this.category);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return true;
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
                image: NetworkImage(ApiConstants.baseUrl + category.icon!),
                placeholder: AssetImage(AppStrings.appIcon),
                height: 25,
                width: 25,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            AppStrings.triviaCartegory + category.title!.toUpperCase(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
        //body: TriviaOptionsBody(category),
        body: Center(
          child: Container(
            height: 200,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              boxShadow: [BoxShadow(blurRadius: 5)],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.warning, color: Colors.red, size: 50),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Text(
                        AppStrings.stillnotready,
                        style: TextStyle(color: Colors.red, fontSize: 18),
                        softWrap: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TriviaOptionsBody extends StatelessWidget {
  final TriviaCat category;
  TriviaOptionsBody(this.category);

  int? level, limit;
  bool? processing = false;
  List<TriviaQuiz> questions = [];
  AsLoader? loader = AsLoader.setUp(AppColors.primaryColor) as AsLoader?;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            AppStrings.triviaQuizInstruction,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          TriviaOptionsLimitBody(category),
          Divider(),
          Text(
            AppStrings.triviaLevelInstruction,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          levelBox(context),
          Divider(),
          processing!
              ? Container()
              : RaisedButton(
                  child: Text(
                    AppStrings.triviaStart.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  onPressed: () {
                    processing = true;
                    loader!.show();
                  },
                  color: AppColors.baseColor,
                ),
          loader!,
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget levelBox(BuildContext context) {
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
            labelStyle:
                TextStyle(color: level == 1 ? Colors.white : Colors.black),
            backgroundColor:
                level == 1 ? AppColors.baseColor : AppColors.secondaryColor,
            onPressed: () => KamusiCubit.get(context).onTriviaSetLimit(1),
          ),
        ],
      ),
    );
  }
}

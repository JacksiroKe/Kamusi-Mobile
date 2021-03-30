enum Type { multiple, boolean }

class TriviaQuiz {
  Type type;
  int id, level;
  String title;
  String answer;
  List<dynamic> options;

  TriviaQuiz(
      {this.id, this.type, this.level, this.title, this.answer, this.options});

  TriviaQuiz.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        level = data["level"],
        title = data["title"],
        answer = data["answer"],
        options = data["options"];

  static List<TriviaQuiz> fromData(List<Map<String, dynamic>> data) {
    List<TriviaQuiz> questions = List<TriviaQuiz>();
    for (int i = 1; i < data.length; i++) {
      TriviaQuiz quiz = new TriviaQuiz();
      quiz.id = int.tryParse(data[i]["id"].toString());
      quiz.title = data[i]["title"].toString();
      quiz.answer = data[i]["answer"].toString();
      quiz.level = int.tryParse(data[i]["level"].toString());

      quiz.options = List<dynamic>();

      quiz.options.add(data[i]["option1"].toString());
      quiz.options.add(data[i]["option2"].toString());
      quiz.options.add(data[i]["option3"].toString());
      quiz.options.add(data[i]["option4"].toString());

      if (data[i]["option5"].toString().isNotEmpty)
        quiz.options.add(data[i]["option5"].toString());

      if (data[i]["option6"].toString().isNotEmpty)
        quiz.options.add(data[i]["option6"].toString());

      if (data[i]["option7"].toString().isNotEmpty)
        quiz.options.add(data[i]["option7"].toString());

      if (data[i]["option8"].toString().isNotEmpty)
        quiz.options.add(data[i]["option8"].toString());

      if (data[i]["option9"].toString().isNotEmpty)
        quiz.options.add(data[i]["option9"].toString());

      if (data[i]["option10"].toString().isNotEmpty)
        quiz.options.add(data[i]["option10"].toString());

      quiz.options.shuffle();

      questions.add(quiz);
    }
    return questions;
  }
}

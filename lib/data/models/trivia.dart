class Trivia {
  int? _id;
  int? _triviaid;
  int? _category;
  int? _level;
  String? _description;
  int? _questions;
  int? _score;
  String? _time;

  Trivia(this._category, this._description, this._questions, this._level);

  int get id => _id ?? 0;
  int get triviaid => _triviaid!;
  int get category => _category!;
  String get description => _description!;
  int get questions => _questions!;
  int get level => _level!;
  int get score => _score!;
  String get time => _time!;

  set id(int newId) {
    this._id = newId;
  }

  set triviaid(int newTriviaid) {
    this._triviaid = newTriviaid;
  }

  set category(int newCategory) {
    this._category = newCategory;
  }

  set description(String newDescription) {
    this._description = newDescription;
  }

  set questions(int newQuestions) {
    this._questions = newQuestions;
  }

  set level(int newLevel) {
    this._level = newLevel;
  }

  set score(int newScore) {
    this._score = newScore;
  }

  set time(String newTime) {
    this._time = newTime;
  }

  // Convert a Data object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['triviaid'] = _triviaid;
    map['category'] = _category;
    map['description'] = _description;
    map['questions'] = _questions;
    map['level'] = _level;
    map['score'] = _score;
    map['time'] = _time;

    return map;
  }

  // Extract a Data object from a Map object
  Trivia.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._triviaid = map['triviaid'];
    this._category = map['category'];
    this._description = map['description'];
    this._questions = map['questions'];
    this._level = map['level'];
    this._score = map['score'];
    this._time = map['time'];
  }
}

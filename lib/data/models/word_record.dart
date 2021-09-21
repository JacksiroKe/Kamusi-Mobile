class WordRecord {
  int? _id;
  String? _title;
  String? _meaning;
  String? _synonyms;
  String? _conjugation;
  int? _views;
  int? _isfav;
  String? _posted;

  WordRecord(this._title, this._meaning, this._synonyms, this._conjugation, this._posted);

  int get id => _id ?? 0;
  String get title => _title!;
  String get meaning => _meaning!;
  String get synonyms => _synonyms!;
  String get conjugation => _conjugation!;
  int get views => _views!;
  int get isfav => _isfav!;
  String get posted => _posted!;

  set id(int newId) {
    this._id = newId;
  }

  set title(String newTitle) {
    this._title = newTitle;
  }

  set meaning(String newMeaning) {
    this._meaning = newMeaning;
  }

  set synonyms(String newSynonyms) {
    this._synonyms = newSynonyms;
  }

  set conjugation(String newConjugation) {
    this._conjugation = newConjugation;
  }

  set views(int newViews) {
    this._views = newViews;
  }

  set isfav(int newIsfav) {
    this._isfav = newIsfav;
  }

  set posted(String newPosted) {
    this._posted = newPosted;
  }

  // Convert a Data object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['meaning'] = _meaning;
    map['synonyms'] = _synonyms;
    map['conjugation'] = _conjugation;
    map['views'] = _views;
    map['isfav'] = _isfav;
    map['posted'] = _posted;

    return map;
  }

  // Extract a Data object from a Map object
  WordRecord.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._meaning = map['meaning'];
    this._synonyms = map['synonyms'];
    this._conjugation = map['conjugation'];
    this._views = map['views'];
    this._isfav = map['isfav'];
    this._posted = map['posted'];
  }
}

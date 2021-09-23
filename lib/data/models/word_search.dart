class WordSearch {
  int? _id;
  int? _wordid;
  String? _created;

  WordSearch(
    this._wordid,
    this._created,
  );

  int get id => _id ?? 0;
  int get wordid => _wordid!;
  String get created => _created!;

  set id(int newId) {
    this._id = newId;
  }

  set wordid(int newwordid) {
    this._wordid = newwordid;
  }

  set created(String newcreated) {
    this._created = newcreated;
  }

  // Convert a Data object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['wordid'] = _wordid;
    map['created'] = _created;

    return map;
  }

  // Extract a Data object from a Map object
  WordSearch.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._wordid = map['wordid'];
    this._created = map['created'];
  }
}

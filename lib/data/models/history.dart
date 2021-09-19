class History {
  int? _id;
  int? _itemid;
  String? _type;
  String? _posted;

  History(
    this._itemid,
    this._type,
    this._posted,
  );

  int get id => _id ?? 0;
  int get itemid => _itemid!;
  String get type => _type!;
  String get posted => _posted!;

  set id(int newId) {
    this._id = newId;
  }

  set itemid(int newItemid) {
    this._itemid = newItemid;
  }

  set type(String newType) {
    this._type = newType;
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
    map['itemid'] = _itemid;
    map['type'] = _type;
    map['posted'] = _posted;

    return map;
  }

  // Extract a Data object from a Map object
  History.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._itemid = map['itemid'];
    this._type = map['type'];
    this._posted = map['posted'];
  }
}

class Annoucement {
  String _id;
  String _userId;
  String _title;
  String _description;
  DateTime _dueDate;
  // String _dueDate;

  Annoucement(this._id, this._userId, this._title, this._description, this._dueDate);

  Annoucement.map(dynamic obj) {
    this._id = obj['id'];
    this._userId = obj['userId'];
    this._title = obj['title'];
    this._description = obj['description'];
    this._dueDate = obj['dueDate'].toDate();
    // this._dueDate = obj['dueDate'];
  }

  String get id => _id;
  String get title => _title;
  String get description => _description;
  // String get dueDate => _dueDate;
  DateTime get dueDate => _dueDate;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['userId'] = _userId;
    map['title'] = _title;
    map['description'] = _description;
    map['dueDate'] = _dueDate; //.toString();

    return map;
  }

  Annoucement.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._userId = map['userId'];
    this._title = map['title'];
    this._description = map['description'];
    this._dueDate = map['dueDate'];
  }
}
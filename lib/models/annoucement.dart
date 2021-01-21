import 'package:intl/intl.dart';

class Annoucement {
  String _id;
  String _userId;
  String _title;
  String _description;
  DateTime _dueDate;

  Annoucement(this._userId, this._title, this._description, this._dueDate);

  Annoucement.map(dynamic obj) {
    this._id = obj['id'];
    this._userId = obj['userId'];
    this._title = obj['title'];
    this._description = obj['description'];
    this._dueDate = obj['dueDate'].toDate();
  }

  String get id => _id;
  String get userId => _userId;
  String get title => _title;
  String get description => _description;
  DateTime get dueDate => _dueDate;
  set id(String id) => this._id = id;
  set userId(String userId) => this._userId = userId;
  set title(String title) => this._title = title;
  set description(String description) => this._description = description;
  set dueDate(DateTime dueDate) => this._dueDate = dueDate;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['userId'] = _userId;
    map['title'] = _title;
    map['description'] = _description;
    map['dueDate'] = _dueDate;

    return map;
  }

  Annoucement.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._userId = map['userId'];
    this._title = map['title'];
    this._description = map['description'];
    this._dueDate = map['dueDate'];
  }

  String formatedDate() {
    return new DateFormat("y.M.d H:m").format(_dueDate);
  }
}
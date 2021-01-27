import 'package:covid19_app/models/address.dart';
import 'package:intl/intl.dart';

class Annoucement {
  String _id;
  String _userId;
  String _title;
  String _description;
  DateTime _dueDate;
  AddressModel _address;
  List<String> _volunteers;
  bool _confirmed;
  bool _delivered;
  bool _received;

  Annoucement(this._userId, this._title, this._description, this._dueDate,
      this._address, [this._volunteers = const [], this._confirmed = false, this._received = false, this._delivered = false]);

  Annoucement.map(dynamic obj) {
    this._id = obj['id'];
    this._userId = obj['userId'];
    this._title = obj['title'];
    this._description = obj['description'];
    this._dueDate = obj['dueDate'].toDate();
    this._address = AddressModel.map(obj['address']);
    this._volunteers = obj['volunteers'].cast<String>();
    this._confirmed = obj['confirmed'];
    this._delivered = obj['delivered'];
    this._received = obj['received'];
  }

  String get id => _id;
  String get userId => _userId;
  String get title => _title;
  String get description => _description;
  DateTime get dueDate => _dueDate;
  List get volunteers => _volunteers;
  AddressModel get address => _address;
  bool get confirmed => _confirmed;
  bool get delivered => _delivered;
  bool get received => _received;

  set id(String id) => this._id = id;
  set userId(String userId) => this._userId = userId;
  set title(String title) => this._title = title;
  set description(String description) => this._description = description;
  set dueDate(DateTime dueDate) => this._dueDate = dueDate;
  set address(AddressModel address) => this._address = address;
  set volunteers(List<String> volunteers) => this._volunteers = volunteers;
  set confirmed(bool confirmed) => this._confirmed = confirmed;
  set received(bool received) => this._received = received;
  set delivered(bool delivered) => this._delivered = delivered;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['userId'] = _userId;
    map['title'] = _title;
    map['description'] = _description;
    map['dueDate'] = _dueDate;
    map['address'] = _address.toMap();
    map['volunteers'] = _volunteers;
    map['confirmed'] = _confirmed;
    map['delivered'] = _delivered;
    map['received'] = _received;

    return map;
  }

  Annoucement.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._userId = map['userId'];
    this._title = map['title'];
    this._description = map['description'];
    this._dueDate = map['dueDate'];
    this._address = AddressModel.fromMap(map['address']);
    this._volunteers = map['volunteers'].cast<String>();
    this._confirmed = map['confirmed'];
    this._delivered = map['delivered'];
    this._received = map['received'];
  }

  String formatedDate() {
    return new DateFormat("y/M/d, H:m").format(_dueDate);
  }

  Annoucement clone() {
    Annoucement annoucement = Annoucement(
        _userId.substring(0),
        _title.substring(0),
        _description.substring(0),
        DateTime(_dueDate.year, _dueDate.month, _dueDate.day, _dueDate.hour, _dueDate.minute, _dueDate.second, _dueDate.millisecond, _dueDate.microsecond),
        _address.clone());
    annoucement.id = _id.substring(0);
    annoucement.volunteers = List.from(_volunteers);
    annoucement.confirmed = _confirmed;

    return annoucement;
  }

  @override
  String toString() {
    return 'Annoucement{_id: $_id, _userId: $_userId, _title: $_title, _description: $_description, _dueDate: $_dueDate, _address: $_address, _volunteers: $_volunteers, _confirmed: $_confirmed}';
  }
}

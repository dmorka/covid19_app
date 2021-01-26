class VolunteerModel {
  String _id;
  String _firstName;
  // String _phoneNumber;
  List<bool> _recommendations;

  VolunteerModel(this._id, this._firstName, this._recommendations);

  VolunteerModel.map(dynamic obj) {
    this._id = obj['id'];
    this._firstName = obj['firstName'];
    // this._phoneNumber = obj['phoneNumber'];
    this._recommendations = obj['recommendations'].cast<bool>();
  }

  set id(id) => this._id = id;
  set firstName(firstName) => this._firstName = firstName;
  // set phoneNumber(phoneNumber) => this._phoneNumber = phoneNumber;
  set recommendations(recommendations) => this._recommendations;
  String get id => _id;
  String get firstName => _firstName;
  // String get phoneNumber => _phoneNumber;
  List<bool> get recommendations => _recommendations;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['firstName'] = this._firstName;
    // map['phoneNumber'] = this._phoneNumber;
    map['recommendations'] = this._recommendations;

    return map;
  }

  VolunteerModel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstName = map['firstName'];
    // this._phoneNumber = map['phoneNumber'];
    this._recommendations = map['recommendations'].cast<bool>();
  }
}

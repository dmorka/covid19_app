class UserModel {
  static final RegExp isValidZip = new RegExp(r"^$|\d{2}-\d{3}");
  String _id;
  String _firstName;
  String _lastName;
  String _city;
  String _zipCode;
  String _street;
  String _apartmentNumber;

  UserModel(this._id, this._firstName, this._lastName, this._city,
      this._zipCode, this._street, this._apartmentNumber);

  UserModel.map(dynamic obj) {
    this._zipCode = obj['zipCode'];
    this._id = obj['id'];
    this._firstName = obj['firstName'];
    this._lastName = obj['lastName'];
    this._city = obj['city'];
    this._street = obj['street'];
    this._apartmentNumber = obj['apartmentNumber'];
  }

  String get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get city => _city;
  String get zipCode => _zipCode;
  String get street => _street;
  String get apartmentNumber => _apartmentNumber;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['firstName'] = this._firstName;
    map['lastName'] = this._lastName;
    map['city'] = this._city;
    map['street'] = this._street;
    map['apartmentNumber'] = this._apartmentNumber;
    map['zipCode'] = this._zipCode;

    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    if (!isValidZip.hasMatch(map['zipCode'])) {
      throw new ArgumentError("Zip code invalid format!");
    }
    this._zipCode = map['zipCode'];
    this._id = map['id'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._city = map['city'];
    this._street = map['street'];
    this._apartmentNumber = map['apartmentNumber'];
  }
}

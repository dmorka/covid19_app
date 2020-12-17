class UserModel {
  static final RegExp isValidZip = new RegExp(r"^$|\d{2}-\d{3}");
  static final RegExp isValidPhone = new RegExp(r"^[\+]?[(]?[0-9]{2}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
  String _id;
  String _firstName;
  String _lastName;
  String _city;
  String _zipCode;
  String _street;
  String _apartmentNumber;
  String _phoneNumber;

  UserModel(this._id, this._firstName, this._lastName, this._city,
      this._zipCode, this._street, this._apartmentNumber, this._phoneNumber);

  UserModel.map(dynamic obj) {
    this._zipCode = obj['zipCode'];
    this._id = obj['id'];
    this._firstName = obj['firstName'];
    this._lastName = obj['lastName'];
    this._city = obj['city'];
    this._street = obj['street'];
    this._apartmentNumber = obj['apartmentNumber'];
    this._phoneNumber = obj['phoneNumber'];
  }

  set id(id) => this._id = id;
  set firstName(firstName) => this._firstName = firstName;
  set lastName(lastName) => this._lastName = lastName;
  set city(city) => this._city = city;
  set zipCode(zipCode) => this._zipCode = zipCode;
  set street(street) => this._street = street;
  set apartmentNumber(apartmentNumber) => this._apartmentNumber = apartmentNumber;
  set phoneNumber(phoneNumber) => this._phoneNumber = phoneNumber;
  String get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get city => _city;
  String get zipCode => _zipCode;
  String get street => _street;
  String get apartmentNumber => _apartmentNumber;
  String get phoneNumber => _phoneNumber;

  String getAddress() {
    return "$_street $_apartmentNumber\n$_zipCode $_city";
  }
  String getName() {
    return "$_firstName $_lastName";
  }

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
    map['phoneNumber'] = this._phoneNumber;

    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    if (!isValidZip.hasMatch(map['zipCode'])) {
      throw new ArgumentError("Zip code invalid format!");
    }
    if (!isValidPhone.hasMatch(map['phoneNumber'])) {
      throw new ArgumentError("Phone number invalid format!");
    }
    this._zipCode = map['zipCode'];
    this._id = map['id'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._city = map['city'];
    this._street = map['street'];
    this._apartmentNumber = map['apartmentNumber'];
    this._phoneNumber = map['phoneNumber'];
  }
}

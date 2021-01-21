import 'package:covid19_app/models/address.dart';

class UserModel {
  static final RegExp isValidPhone =
      new RegExp(r"^[\+]?[(]?[0-9]{2}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
  String _id;
  String _firstName;
  String _lastName;
  AddressModel _address;
  String _phoneNumber;

  UserModel(this._id, this._firstName, this._lastName, this._phoneNumber,
      this._address);

  UserModel.map(dynamic obj) {
    this._id = obj['id'];
    this._firstName = obj['firstName'];
    this._lastName = obj['lastName'];
    this._phoneNumber = obj['phoneNumber'];
    this._address = AddressModel.map(obj['address']);
  }

  set id(id) => this._id = id;
  set firstName(firstName) => this._firstName = firstName;
  set lastName(lastName) => this._lastName = lastName;
  set phoneNumber(phoneNumber) => this._phoneNumber = phoneNumber;
  set address(address) => this._address = address;
  String get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phoneNumber => _phoneNumber;
  AddressModel get address => _address;

  String getFullName() {
    return "$_firstName $_lastName";
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['firstName'] = this._firstName;
    map['lastName'] = this._lastName;
    map['phoneNumber'] = this._phoneNumber;
    map['address'] = this._address.toMap();

    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    if (!isValidPhone.hasMatch(map['phoneNumber'])) {
      throw new ArgumentError("Phone number invalid format!");
    }
    this._id = map['id'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._phoneNumber = map['phoneNumber'];
    this._address = AddressModel.fromMap(map['address']);
  }
}

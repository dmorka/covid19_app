class AddressModel {
  static final RegExp isValidZip = new RegExp(r"^$|\d{2}-\d{3}");
  String _city;
  String _zipCode;
  String _street;
  String _apartmentNumber;

  AddressModel(this._city, this._zipCode, this._street, this._apartmentNumber);

  AddressModel.map(dynamic obj) {
    this._city = obj['city'];
    this._zipCode = obj['zipCode'];
    this._street = obj['street'];
    this._apartmentNumber = obj['apartmentNumber'];
  }

  String get apartmentNumber => _apartmentNumber;
  String get street => _street;
  String get zipCode => _zipCode;
  String get city => _city;
  set city(city) => this._city = city;
  set zipCode(zipCode) => this._zipCode = zipCode;
  set street(street) => this._street = street;
  set apartmentNumber(apartmentNumber) =>
      this._apartmentNumber = apartmentNumber;

  String getFullAddress() {
    return "$_street $_apartmentNumber, $_zipCode $_city";
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['city'] = this._city;
    map['street'] = this._street;
    map['apartmentNumber'] = this._apartmentNumber;
    map['zipCode'] = this._zipCode;

    return map;
  }

  AddressModel.fromMap(Map<String, dynamic> map) {
    if (!isValidZip.hasMatch(map['zipCode'])) {
      throw new ArgumentError("Zip code invalid format!");
    }
    this._zipCode = map['zipCode'];
    this._city = map['city'];
    this._street = map['street'];
    this._apartmentNumber = map['apartmentNumber'];
  }
}

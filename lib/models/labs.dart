class CovidLaboratoriesModel {
  final String name;
  final String fullAddress;
  final String addressStreet;
  final String addressNumber;
  final String addressCity;
  final String phoneNum;
  final String website;

  CovidLaboratoriesModel(
      {this.name,
        this.fullAddress,
        this.addressStreet,
        this.addressNumber,
        this.addressCity,
        this.phoneNum,
        this.website});

  factory CovidLaboratoriesModel.fromJson(Map<String, dynamic> json) {
    var p = json['properties'];
    return CovidLaboratoriesModel(
      name: p['NAZWA'],
      fullAddress: p['ADRES_PELN'],
      addressStreet: p['ULICA'],
      addressNumber: p['NR'],
      addressCity: p['Miejscowos'], // not a typo
      phoneNum: p['telefon'],
      website: p['WWW']
    );
  }
}
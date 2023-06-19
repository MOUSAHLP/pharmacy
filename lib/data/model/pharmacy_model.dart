class PharmacyModel {
  String? pharmacyName;
  String? pharmacyPlace;
  String? pharmacyNumber;
  String? pharmacistName;

  PharmacyModel(
      {this.pharmacyName,
      this.pharmacyPlace,
      this.pharmacyNumber,
      this.pharmacistName});

  PharmacyModel.fromJson(Map<String, dynamic> json) {
    pharmacyName = json['pharmacyName'];
    pharmacyPlace = json['pharmacyPlace'];
    pharmacyNumber = json['pharmacyNumber'];
    pharmacistName = json['pharmacistName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pharmacyName'] = pharmacyName;
    data['pharmacyPlace'] = pharmacyPlace;
    data['pharmacyNumber'] = pharmacyNumber;
    data['pharmacistName'] = pharmacistName;
    return data;
  }
}

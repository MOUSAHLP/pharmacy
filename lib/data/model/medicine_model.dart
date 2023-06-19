class MedicineModel {
  int? id;
  String? name;
  String? price;
  String? company;
  String? notes;

  MedicineModel({this.id, this.name, this.price, this.notes, this.company});

  MedicineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    company = json['company'];
    notes = json['notes'];
  }

  // Map<MedicineModel,int> fromJsonList(Map<MedicineModel, int> json) {
  //   Map<MedicineModel,int> list = {};
  //   for (var element in json) {
  //     list.add(MedicineModel.fromJson(element));
  //   }
  //   print(list);
  //   return list;
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['company'] = company;
    data['notes'] = notes;
    return data;
  }
}

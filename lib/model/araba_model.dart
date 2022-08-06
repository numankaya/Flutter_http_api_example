import 'dart:convert';

Araba arabaFromMap(String str) => Araba.fromMap(json.decode(str));

String arabaToMap(Araba data) => json.encode(data.toMap());

class Araba {
  Araba({
    required this.carName,
    required this.country,
    required this.year,
    required this.model,
  });

  final String carName;
  final String country;
  final int year;
  final List<Model> model;

  factory Araba.fromMap(Map<String, dynamic> json) => Araba(
        carName: json["car_name"],
        country: json["country"],
        year: json["year"],
        model: List<Model>.from(json["model"].map((x) => Model.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "car_name": carName,
        "country": country,
        "year": year,
        "model": List<dynamic>.from(model.map((x) => x.toMap())),
      };
}

class Model {
  Model({
    required this.modelName,
    required this.price,
    required this.fuel,
  });

  final String modelName;
  final int price;
  final bool fuel;

  factory Model.fromMap(Map<String, dynamic> json) => Model(
        modelName: json["model_name"],
        price: json["price"],
        fuel: json["fuel"],
      );

  Map<String, dynamic> toMap() => {
        "model_name": modelName,
        "price": price,
        "fuel": fuel,
      };
}

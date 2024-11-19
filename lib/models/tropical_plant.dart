// To parse this JSON data, do
//
//     final tropicalPlant = tropicalPlantFromJson(jsonString);

import 'dart:convert';

List<TropicalPlant> tropicalPlantFromJson(String str) =>
    List<TropicalPlant>.from(
        json.decode(str).map((x) => TropicalPlant.fromJson(x)));

String tropicalPlantToJson(List<TropicalPlant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TropicalPlant {
  String model;
  String pk;
  Fields fields;

  TropicalPlant({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory TropicalPlant.fromJson(Map<String, dynamic> json) => TropicalPlant(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String name;
  int price;
  String description;
  int weight;
  DateTime createdAt;

  Fields({
    required this.user,
    required this.name,
    required this.price,
    required this.description,
    required this.weight,
    required this.createdAt,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        weight: json["weight"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "description": description,
        "weight": weight,
        "created_at": createdAt.toIso8601String(),
      };
}

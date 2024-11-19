import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalModel {
  String id;
  String name;
  String breed;
  String category;
  String gender;
  String image;
  int age;
  int amount;
  String description;
  bool isFavorite; // New property to track favorite status

  AnimalModel({
    required this.name,
    required this.description,
    required this.breed,
    required this.image,
    required this.age,
    required this.amount,
    required this.category,
    required this.id,
    required this.gender,
    this.isFavorite = false, // Default value set to false
  });

  // to convert the json to object model
  factory AnimalModel.fromJson(Map<String, dynamic> json, String id) {
    return AnimalModel(
      id: id,
      name: json["name"] ?? "",
      breed: json["breed"] ?? "",
      description: json["desc"] ?? "no description",
      image: json["image"] ?? "",
      age: json["age"] ?? 0,
      amount: json["amount"] ?? 0,
      category: json["category"] ?? "",
      gender: json["gender"] ?? "",
      isFavorite: json["isFavorite"] ?? false, // Load favorite status from JSON
    );
  }

  // Convert List<QueryDocumentSnapshot> to List<ProductModel>
  static List<AnimalModel> fromJsonList(List<QueryDocumentSnapshot> list) {
    return list
        .map(
            (e) => AnimalModel.fromJson(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  // Method to convert AnimalModel to JSON format
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "breed": breed,
      "desc": description,
      "image": image,
      "age": age,
      "amount": amount,
      "category": category,
      "gender": gender,
      "isFavorite": isFavorite,
    };
  }
}

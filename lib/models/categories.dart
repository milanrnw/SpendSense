import 'dart:convert';

// Helper function to decode a JSON string into a CategoryModel object
CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

// Helper function to encode a CategoryModel object into a JSON string
String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final String id;
  final String name;
  final String type; // To distinguish between 'expense' and 'income' categories
  String? icon; // Optional: for an icon identifier string
  String? color; // Optional: for a color hex string

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    this.icon,
    this.color,
  });

  // Factory constructor to create an instance from a JSON map
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    icon: json["icon"],
    color: json["color"],
  );

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "icon": icon,
    "color": color,
  };

  // Method to create a copy of the instance with some updated fields
  CategoryModel copyWith({
    String? id,
    String? name,
    String? type,
    String? icon,
    String? color,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}

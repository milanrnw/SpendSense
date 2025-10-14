import 'dart:convert';

// Helper function to decode a JSON string into a BudgetModel object
BudgetModel budgetModelFromJson(String str) =>
    BudgetModel.fromJson(json.decode(str));

// Helper function to encode a BudgetModel object into a JSON string
String budgetModelToJson(BudgetModel data) => json.encode(data.toJson());

class BudgetModel {
  final String id;
  final double amount;
  final String categoryId;
  final DateTime startDate;
  final DateTime endDate;
  String? name;

  BudgetModel({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.startDate,
    required this.endDate,
    this.name,
  });

  // Factory constructor to create an instance from a JSON map
  factory BudgetModel.fromJson(Map<String, dynamic> json) => BudgetModel(
    id: json["id"],
    amount: (json["amount"] as num?)?.toDouble() ?? 0.0,
    categoryId: json["categoryId"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    name: json["name"],
  );

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "categoryId": categoryId,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "name": name,
  };

  // Method to create a copy of the instance with some updated fields
  BudgetModel copyWith({
    String? id,
    double? amount,
    String? categoryId,
    DateTime? startDate,
    DateTime? endDate,
    String? name,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      name: name ?? this.name,
    );
  }
}

import 'dart:convert';

IncomeModel incomeModelFromJson(String str) =>
    IncomeModel.fromJson(json.decode(str));

String incomeModelToJson(IncomeModel data) => json.encode(data.toJson());

class IncomeModel {
  final String id;
  final double amount;
  final DateTime date;
  final String categoryId;
  String? description; // The description of the income

  IncomeModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.categoryId,
    this.description,
  });

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
    id: json["id"],
    amount: (json["amount"] as num?)?.toDouble() ?? 0.0,
    date: DateTime.parse(json["date"]),
    categoryId: json["categoryId"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "date": date.toIso8601String(),
    "categoryId": categoryId,
    "description": description,
  };

  IncomeModel copyWith({
    String? id,
    double? amount,
    DateTime? date,
    String? categoryId,
    String? description,
  }) {
    return IncomeModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
    );
  }
}

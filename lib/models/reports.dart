import 'dart:convert';

ReportModel reportModelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  final String id;
  final DateTime generatedDate;
  final DateTime startDate;
  final DateTime endDate;
  final double totalIncome;
  final double totalExpense;
  final Map<String, double> expensesByCategory;

  ReportModel({
    required this.id,
    required this.generatedDate,
    required this.startDate,
    required this.endDate,
    required this.totalIncome,
    required this.totalExpense,
    required this.expensesByCategory,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    id: json["id"],
    generatedDate: DateTime.parse(json["generatedDate"]),
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    totalIncome: (json["totalIncome"] as num?)?.toDouble() ?? 0.0,
    totalExpense: (json["totalExpense"] as num?)?.toDouble() ?? 0.0,
    expensesByCategory: Map<String, double>.from(json["expensesByCategory"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "generatedDate": generatedDate.toIso8601String(),
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "totalIncome": totalIncome,
    "totalExpense": totalExpense,
    "expensesByCategory": expensesByCategory,
  };

  ReportModel copyWith({
    String? id,
    DateTime? generatedDate,
    DateTime? startDate,
    DateTime? endDate,
    double? totalIncome,
    double? totalExpense,
    Map<String, double>? expensesByCategory,
  }) {
    return ReportModel(
      id: id ?? this.id,
      generatedDate: generatedDate ?? this.generatedDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      expensesByCategory: expensesByCategory ?? this.expensesByCategory,
    );
  }
}

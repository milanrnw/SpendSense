import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String? id; // Unique ID for the transaction
  final String type;
  final double amount;
  final String categoryId;
  final String categoryName;
  final Timestamp date;
  final String? description;
  final String userId;

  TransactionModel({
    this.id,
    required this.type,
    required this.amount,
    required this.categoryId,
    required this.categoryName,
    required this.date,
    this.description,
    required this.userId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json, String id) {
    return TransactionModel(
      id: id,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      date: json['date'] as Timestamp,
      description: json['description'] as String?,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'date': date,
      'description': description,
      'userId': userId,
    };
  }
}

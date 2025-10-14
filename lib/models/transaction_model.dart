import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String? id; // Unique ID for the transaction
  final String type; // 'income' or 'expense'
  final double amount;
  final String categoryId; // e.g., 'food', 'salary'
  final String categoryName; // e.g., 'Food & Dining', 'Salary'
  final Timestamp date; // Firestore uses Timestamp
  final String? description;
  final String userId; // To know who this transaction belongs to

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

  // A factory constructor to create a TransactionModel from a Firestore document
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

  // A method to convert a TransactionModel instance to a Map for Firestore
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

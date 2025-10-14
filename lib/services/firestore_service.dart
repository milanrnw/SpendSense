import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spendsense/models/categories.dart';
import 'package:spendsense/models/transaction_model.dart';
import 'package:spendsense/models/user_details.dart';
import 'package:spendsense/utils/firestore_collection.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- USER METHODS ---

  Future<UserDetails?> getUserDetails() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final docSnap = await _db
        .collection(FirestoreCollection.usersCollection)
        .doc(user.uid)
        .get();
    if (docSnap.exists) {
      return UserDetails.fromJson(docSnap.data()!);
    }
    return null;
  }

  Future<void> updateUserDetails(String firstName, String lastName) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _db
        .collection(FirestoreCollection.usersCollection)
        .doc(user.uid)
        .update({'firstName': firstName, 'lastName': lastName});
  }

  // --- CATEGORY METHODS ---

  Future<List<CategoryModel>> getCategories() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final snapshot = await _db
        .collection(FirestoreCollection.usersCollection)
        .doc(user.uid)
        .collection(FirestoreCollection.categoriesCollection)
        .get();

    return snapshot.docs
        .map((doc) => CategoryModel.fromJson(doc.data()))
        .toList();
  }

  Stream<List<CategoryModel>> getCategoriesStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _db
        .collection(FirestoreCollection.usersCollection)
        .doc(user.uid)
        .collection(FirestoreCollection.categoriesCollection)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => CategoryModel.fromJson(doc.data()))
              .toList();
        });
  }

  Future<void> addCategory(CategoryModel category) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _db
        .collection(FirestoreCollection.usersCollection)
        .doc(user.uid)
        .collection(FirestoreCollection.categoriesCollection)
        .doc(category.id)
        .set(category.toJson());
  }

  Future<void> deleteCategory(String categoryId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _db
        .collection(FirestoreCollection.usersCollection)
        .doc(user.uid)
        .collection(FirestoreCollection.categoriesCollection)
        .doc(categoryId)
        .delete();
  }

  // --- TRANSACTION METHODS ---

  Future<void> addTransaction(TransactionModel transaction) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    try {
      await _db
          .collection(FirestoreCollection.usersCollection)
          .doc(user.uid)
          .collection(FirestoreCollection.transactionsCollection)
          .add(transaction.toJson());
    } catch (e) {
      print("Error adding transaction: $e");
      throw Exception("Could not save transaction. Please try again.");
    }
  }

  // --- TRANSACTION STREAMS ---

  Stream<List<TransactionModel>> getRecentTransactionsStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);
    return _db
        .collection(FirestoreCollection.usersCollection)
        .doc(user.uid)
        .collection(FirestoreCollection.transactionsCollection)
        .orderBy('date', descending: true)
        .limit(10)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Stream<List<TransactionModel>> getMonthlyTransactionsStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);
    return _db
        .collection(FirestoreCollection.usersCollection)
        .doc(user.uid)
        .collection(FirestoreCollection.transactionsCollection)
        .where('date', isGreaterThanOrEqualTo: startOfMonth)
        .where('date', isLessThan: endOfMonth)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Stream<List<TransactionModel>> getAllTransactionsStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);
    return _db
        .collection(FirestoreCollection.usersCollection)
        .doc(user.uid)
        .collection(FirestoreCollection.transactionsCollection)
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }
}

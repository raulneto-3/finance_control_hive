import 'package:hive/hive.dart';
import 'package:finance_control_hive/data/models/transaction_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  final Box<TransactionModel> _transactionBox = Hive.box<TransactionModel>('transactions');

  // Create
  Future<void> insertTransaction(TransactionModel transaction) async {
    await _transactionBox.add(transaction);
  }

  // Read
  List<TransactionModel> getTransactions() {
    return _transactionBox.values.toList();
  }

  // Update
  Future<void> updateTransaction(int index, TransactionModel transaction) async {
    await _transactionBox.putAt(index, transaction);
  }

  // Delete
  Future<void> deleteTransaction(int index) async {
    await _transactionBox.deleteAt(index);
  }
}
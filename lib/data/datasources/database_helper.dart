import 'package:hive/hive.dart';
import 'package:finance_control_hive/data/models/transaction_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  late Box<TransactionModel> _transactionBox;

  Future<void> init() async {
    _transactionBox = await Hive.openBox<TransactionModel>('transactions');
  }

  // Create
  Future<void> insertTransaction(TransactionModel transaction) async {
    await _transactionBox.add(transaction);
  }

  // Read with pagination
  List<TransactionModel> getTransactions({int offset = 0, int limit = 5}) {
    return _transactionBox.values.skip(offset).take(limit).toList();
  }

  // Read all transactions for the current month
  List<TransactionModel> getCurrentMonthTransactions() {
    final now = DateTime.now();
    return _transactionBox.values.where((transaction) =>
        transaction.date.year == now.year && transaction.date.month == now.month).toList();
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
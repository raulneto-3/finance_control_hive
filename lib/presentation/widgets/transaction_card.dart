import 'package:flutter/material.dart';
import '../../data/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(transaction.amount < 0 ? Icons.arrow_downward : Icons.arrow_upward),
        title: Text(transaction.description),
        subtitle: Text(transaction.date.toString()),
        trailing: Text(
          'R\$ ${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: transaction.amount < 0 ? Colors.redAccent : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
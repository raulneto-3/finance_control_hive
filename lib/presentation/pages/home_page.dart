import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:finance_control_hive/core/providers/theme_provider.dart';
import 'package:finance_control_hive/core/routes.dart'; // Importar o arquivo de rotas
import 'package:finance_control_hive/data/datasources/database_helper.dart';
import 'package:finance_control_hive/data/models/transaction_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TransactionModel> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    setState(() {
      _transactions = DatabaseHelper().getTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo Financeiro'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: _transactions.isEmpty
                ? Text('Nenhuma transação encontrada')
                : ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = _transactions[index];
                      return ListTile(
                        title: Text(transaction.description),
                        subtitle: Text(
                            '${transaction.type} - ${transaction.amount.toStringAsFixed(2)}'),
                        trailing: Text(DateFormat('dd/MM/yyyy')
                            .format(transaction.date)),
                      );
                    },
                  ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                final result = await Navigator.pushNamed(
                    context, AppRoutes.addTransaction);
                if (result == true) {
                  _loadTransactions(); // Atualizar a lista de transações
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
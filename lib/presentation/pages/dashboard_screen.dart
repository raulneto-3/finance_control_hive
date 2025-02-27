import 'package:finance_control_hive/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/themes/theme_provider.dart';
import '../widgets/theme_switcher.dart';
import '../widgets/transaction_card.dart';
import '../../data/models/transaction_model.dart';
import '../../data/datasources/database_helper.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<TransactionModel> _transactions = [];
  int _offset = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMoreTransactions();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMoreTransactions();
      }
    });
  }

  Future<void> _loadMoreTransactions() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    final newTransactions = DatabaseHelper().getTransactions(offset: _offset);
    setState(() {
      _transactions.addAll(newTransactions);
      _offset += newTransactions.length;
      _isLoading = false;
    });
  }

  Future<void> _refreshTransactions() async {
    setState(() {
      _transactions.clear();
      _offset = 0;
    });
    await _loadMoreTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentMonthTransactions = DatabaseHelper().getCurrentMonthTransactions();

    // Calcula o saldo atual
    final currentBalance = currentMonthTransactions.fold(0.0, (sum, transaction) => sum + transaction.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: const [ThemeSwitcher()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumo Financeiro
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Saldo Atual', style: theme.textTheme.titleSmall),
                          Text('R\$ ${currentBalance.toStringAsFixed(2)}', 
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: theme.colorScheme.primary,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Transações Recentes
            Text('Transações Recentes', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshTransactions,
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: _transactions.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    if (index == _transactions.length) {
                      return _isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink();
                    }
                    return TransactionCard(transaction: _transactions[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, AppRoutes.addTransaction);
          _refreshTransactions();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
import 'package:flutter/material.dart';
import 'package:finance_control_hive/presentation/pages/home_page.dart';
import 'package:finance_control_hive/presentation/pages/add_transaction_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String addTransaction = '/add-transaction';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case addTransaction:
        return MaterialPageRoute(builder: (_) => AddTransactionPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
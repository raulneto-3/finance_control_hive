import 'package:flutter/material.dart';
import 'package:finance_control_hive/presentation/pages/add_transaction_page.dart';
import 'package:finance_control_hive/presentation/pages/settings_screen.dart'; // Importar a tela de configurações

class AppRoutes {
  static const String home = '/';
  static const String addTransaction = '/add-transaction';
  static const String settings = '/settings'; // Adicionar a constante para a rota de configurações

  static Route<dynamic> generateRoute(RouteSettings route) {
    switch (route.name) {
      case addTransaction:
        return MaterialPageRoute(builder: (_) => AddTransactionPage());
      case settings:
        return MaterialPageRoute(builder: (_) => SettingsScreen()); // Adicionar a rota para a tela de configurações
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${route.name}'),
            ),
          ),
        );
    }
  }
}
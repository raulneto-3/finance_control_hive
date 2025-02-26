import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_control_hive/core/providers/theme_provider.dart';
import 'package:finance_control_hive/core/routes.dart'; // Importar o arquivo de rotas
import 'package:hive_flutter/hive_flutter.dart';
import 'package:finance_control_hive/data/models/transaction_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter()); // Registrar o adaptador
  await Hive.openBox<TransactionModel>('transactions'); // Abrir a caixa como Box<TransactionModel>

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Finance Control',
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
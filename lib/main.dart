import 'package:finance_control_hive/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:finance_control_hive/data/models/transaction_model.dart';
import 'package:finance_control_hive/data/datasources/database_helper.dart';
import 'package:finance_control_hive/presentation/pages/dashboard_screen.dart';
import 'package:finance_control_hive/core/themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registrar o adaptador para TransactionModel
  Hive.registerAdapter(TransactionModelAdapter());

  // Inicializar DatabaseHelper e abrir a caixa de transações
  await DatabaseHelper().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Finance Control Hive',
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: DashboardScreen(),
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
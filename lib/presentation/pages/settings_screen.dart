import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/themes/theme_provider.dart';
import '../widgets/theme_switcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Tema Escuro'),
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) => themeProvider.toggleTheme(),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Moeda'),
            subtitle: const Text('Real Brasileiro (BRL)'),
            onTap: () {}, // Abrir seleção de moeda
          ),
        ],
      ),
    );
  }
}
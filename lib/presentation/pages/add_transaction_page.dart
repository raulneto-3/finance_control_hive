import 'package:finance_control_hive/data/datasources/database_helper.dart';
import 'package:finance_control_hive/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionPage extends StatelessWidget {
  final TextEditingController _descriptionController = TextEditingController(text: 'Test');
  final TextEditingController _amountController = TextEditingController(text: '100.00');
  final TextEditingController _dateController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController _typeController = TextEditingController(text: 'Receita');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um valor';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Data (dd/MM/yyyy)'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma data';
                    }
                    try {
                      DateFormat('dd/MM/yyyy').parseStrict(value);
                    } catch (e) {
                      return 'Formato de data inválido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _typeController,
                  decoration: InputDecoration(labelText: 'Tipo (Receita/Despesa)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um tipo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final transaction = TransactionModel()
                        ..id = DateTime.now().millisecondsSinceEpoch // Gerar um ID único
                        ..description = _descriptionController.text
                        ..amount = double.parse(_amountController.text)
                        ..date = DateFormat('dd/MM/yyyy').parseStrict(_dateController.text)
                        ..type = _typeController.text;

                      DatabaseHelper().insertTransaction(transaction);
                      Navigator.pop(context, true); // Retornar true para indicar que a transação foi adicionada
                    }
                  },
                  child: Text('Salvar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false); // Retornar false para indicar que a transação não foi adicionada
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
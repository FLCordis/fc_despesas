import 'package:fc_despesas/components/adaptative_button.dart';
import 'package:fc_despesas/components/adaptative_datepicker.dart';
import 'package:fc_despesas/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onAddTransaction, {super.key});

  final void Function(String, double, DateTime) onAddTransaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onAddTransaction(title, value, _selectedDate);
    _titleController.clear();
    _valueController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AdaptativeTextField(
              label: 'Título',
              onSubmit: (_) => _submitForm,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            AdaptativeTextField(
              label: 'Valor (R\$)',
              onSubmit: (_) => _submitForm,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            AdaptativeDatePicker(
              selectedDate: _selectedDate,
              onDateChanged: (newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: AdaptativeButton(
                onPressed: _submitForm,
                label: 'Nova Transação',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

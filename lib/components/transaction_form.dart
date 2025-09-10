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
  final _titleFocusNode = FocusNode();
  final _valueFocusNode = FocusNode();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onAddTransaction(title, value, _selectedDate);
    _titleController.clear();
    _valueController.clear();
  }

  //Foco do Android nos inputs, ao clicar em Próximo no teclado, ele chama o próximo foco.
  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    _titleFocusNode.dispose();
    _valueFocusNode.dispose();
    super.dispose();
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
              controller: _titleController,
              focusNode: _titleFocusNode,
              textInputAction: TextInputAction.next,
              onSubmit: (_) => _valueFocusNode.requestFocus(),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            AdaptativeTextField(
              label: 'Valor (R\$)',
              controller: _valueController,
              focusNode: _valueFocusNode,
              textInputAction: TextInputAction.done,
              onSubmit: (_) => _submitForm(),
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  _showDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime.now().subtract(Duration(days: 360)), 
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
            ),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      _selectedDate == null 
                      // ignore: dead_code
                      ? 'Nenhuma data selecionada!' 
                      : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                    child: Text('Selecionar data'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Nova Transação'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fc_despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transactions, required this.onRemove});

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: transactions.isEmpty ? Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text('Nenhuma transação cadastrada!', 
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                      'R\$${tr.value.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
              title: Text(
                tr.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                DateFormat('d MMM y').format(tr.date),
              ),
              trailing: IconButton(
                onPressed: () => onRemove(tr.id),
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
          },
        ),
      );
  }
}

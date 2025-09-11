import 'package:fc_despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Formatação de datas

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.tr, required this.onRemove});

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Sombra do cartão
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5), // Margens
      child: ListTile(
        // Círculo à esquerda com o valor da transação
        leading: CircleAvatar(
          radius: 30, // Raio do círculo
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${tr.value.toStringAsFixed(2)}',
              ), // Valor formatado
            ),
          ),
        ),
        // Título da transação
        title: Text(tr.title, style: Theme.of(context).textTheme.titleMedium),
        // Data da transação formatada
        subtitle: Text(
          DateFormat('d MMM y').format(tr.date),
        ), // Ex: "15 Jan 2025"
        // Botão de exclusão (adaptativo baseado no tamanho da tela)
        trailing: MediaQuery.of(context).size.width > 400
            ? FloatingActionButton.extended(
                // Telas grandes: botão com texto
                onPressed: () => onRemove(tr.id), // Chama função de remoção
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.error, // Cor de erro
                foregroundColor: Colors.white,
                label: const Text('Excluir'),
                icon: const Icon(Icons.delete),
              )
            : IconButton(
                // Telas pequenas: apenas ícone
                onPressed: () => onRemove(tr.id), // Chama função de remoção
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error, // Cor de erro
              ),
      ),
    );
  }
}

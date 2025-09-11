// Importações necessárias
import 'package:fc_despesas/components/transaction_item.dart';
import 'package:fc_despesas/models/transaction.dart'; // Modelo de transação
import 'package:flutter/material.dart'; // Widgets do Flutter

// Componente que exibe a lista de todas as transações do usuário
// Mostra uma imagem quando não há transações ou uma lista rolável quando há
class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.transactions, // Lista de transações para exibir
    required this.onRemove, // Função para remover uma transação
  });

  final List<Transaction> transactions; // Lista das transações
  final void Function(String)
  onRemove; // Função que recebe o ID da transação a ser removida

  // Constrói a interface da lista de transações
  @override
  Widget build(BuildContext context) {
    // Verifica se há transações para exibir
    return transactions.isEmpty
        ? LayoutBuilder(
            // Tela vazia quando não há transações
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Text(
                    'Nenhuma transação cadastrada!',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height:
                        constraints.maxHeight * 0.4, // 40% da altura disponível
                    child: Image.asset(
                      'assets/images/waiting.png', // Imagem de "aguardando"
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            // Lista rolável quando há transações
            itemCount: transactions.length, // Número de itens na lista
            itemBuilder: (ctx, index) {
              // Função que constrói cada item
              final tr = transactions[index]; // Transação atual
              return TransactionItem(tr: tr, onRemove: onRemove);
            },
          );
  }
}

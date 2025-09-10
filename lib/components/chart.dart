// Importações necessárias
import 'package:fc_despesas/components/chart_bar.dart'; // Barras individuais do gráfico
import 'package:fc_despesas/models/transaction.dart';   // Modelo de transação
import 'package:flutter/material.dart';                 // Widgets do Flutter
import 'package:intl/intl.dart';                       // Formatação de datas

// Componente que exibe um gráfico de barras dos gastos dos últimos 7 dias
// Cada barra representa um dia da semana com o total gasto
class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions; // Lista das transações recentes

  // Getter que agrupa as transações por dia da semana dos últimos 7 dias
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      // Calcula a data de cada um dos últimos 7 dias
      final weekDay = DateTime.now().subtract(Duration(days: index));
      // Pega a primeira letra do dia da semana (S, T, Q, Q, S, S, D)
      final dayOfWeek = DateFormat.E().format(weekDay)[0];

      // Soma todas as transações deste dia específico
      double totalSum = 0.0;
      for (var tr in recentTransactions) {
        // Verifica se a transação é do mesmo dia, mês e ano
        if (tr.date.day == weekDay.day &&
            tr.date.month == weekDay.month &&
            tr.date.year == weekDay.year) {
          totalSum += tr.value; // Adiciona o valor da transação
        }
      }

      // Retorna um mapa com o dia e o valor total
      return {'day': dayOfWeek, 'value': totalSum};
    }).reversed.toList(); // Inverte para mostrar do mais antigo para o mais recente
  }

  // Getter que calcula o valor total gasto na semana
  double get _weekTotalValue {
    return groupedTransactions.fold(
      0.0, // Valor inicial
      (sum, tr) => sum + (tr['value'] as double), // Soma cada valor
    );
  }

  // Constrói o gráfico visual com as barras dos 7 dias
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,                    // Sombra do cartão
      margin: EdgeInsets.all(20),      // Margem externa
      child: Padding(
        padding: const EdgeInsets.all(10), // Espaçamento interno
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribui as barras uniformemente
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight, // Cada barra ocupa espaço igual
              child: ChartBar(
                label: tr['day'].toString(),           // Dia da semana (S, T, Q, etc.)
                value: tr['value'] as double,          // Valor gasto no dia
                percentage: _weekTotalValue == 0       // Calcula a porcentagem para altura da barra
                    ? 0                                // Se não há gastos, porcentagem é 0
                    : (tr['value'] as double) / _weekTotalValue, // Valor do dia / total da semana
              ),
            );
          }).toList(), // Converte o map em lista de widgets
        ),
      ),
    );
  }
}

// Importações necessárias
import 'package:fc_despesas/components/chart_bar.dart'; // Barras individuais do gráfico
import 'package:fc_despesas/models/transaction.dart'; // Modelo de transação
import 'package:flutter/material.dart'; // Widgets do Flutter

// Componente que exibe um gráfico de barras dos gastos dos últimos 7 dias
// Cada barra representa um dia da semana com o total gasto
class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions; // Lista das transações recentes

  // Função que retorna as iniciais dos dias baseado na localização do dispositivo
  String _getDayInitial(DateTime date, Locale locale) {
    // Detecta se o idioma é português
    final isPortuguese = locale.languageCode == 'pt';

    // Pega o número do dia da semana (1 = Monday, 7 = Sunday)
    final weekday = date.weekday;

    if (isPortuguese) {
      // Iniciais em português brasileiro
      switch (weekday) {
        case 1:
          return 'S'; // Segunda-feira
        case 2:
          return 'T'; // Terça-feira
        case 3:
          return 'Q'; // Quarta-feira
        case 4:
          return 'Q'; // Quinta-feira
        case 5:
          return 'S'; // Sexta-feira
        case 6:
          return 'S'; // Sábado
        case 7:
          return 'D'; // Domingo
        default:
          return 'S';
      }
    } else {
      // Iniciais em inglês (padrão internacional)
      switch (weekday) {
        case 1:
          return 'M'; // Monday
        case 2:
          return 'T'; // Tuesday
        case 3:
          return 'W'; // Wednesday
        case 4:
          return 'T'; // Thursday
        case 5:
          return 'F'; // Friday
        case 6:
          return 'S'; // Saturday
        case 7:
          return 'S'; // Sunday
        default:
          return 'M';
      }
    }
  }

  // Função que agrupa as transações por dia da semana dos últimos 7 dias
  List<Map<String, Object>> _getGroupedTransactions(BuildContext context) {
    return List.generate(7, (index) {
          // Calcula a data de cada um dos últimos 7 dias
          final weekDay = DateTime.now().subtract(Duration(days: index));

          // Pega a inicial do dia baseada na localização
          final locale = Localizations.localeOf(context);
          final dayOfWeek = _getDayInitial(weekDay, locale);

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
        }).reversed
        .toList(); // Inverte para mostrar do mais antigo para o mais recente
  }

  // Função que calcula o valor total gasto na semana
  double _getWeekTotalValue(List<Map<String, Object>> groupedTransactions) {
    return groupedTransactions.fold(
      0.0, // Valor inicial
      (sum, tr) => sum + (tr['value'] as double), // Soma cada valor
    );
  }

  // Constrói o gráfico visual com as barras dos 7 dias
  @override
  Widget build(BuildContext context) {
    // Obtém as transações agrupadas por dia
    final groupedTransactions = _getGroupedTransactions(context);
    // Calcula o total da semana
    final weekTotalValue = _getWeekTotalValue(groupedTransactions);

    return Card(
      elevation: 6, // Sombra do cartão
      margin: EdgeInsets.all(20), // Margem externa
      child: Padding(
        padding: const EdgeInsets.all(10), // Espaçamento interno
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceAround, // Distribui as barras uniformemente
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight, // Cada barra ocupa espaço igual
              child: ChartBar(
                label: tr['day'].toString(), // Dia da semana (S, T, Q, etc.)
                value: tr['value'] as double, // Valor gasto no dia
                percentage:
                    weekTotalValue ==
                        0 // Calcula a porcentagem para altura da barra
                    ? 0 // Se não há gastos, porcentagem é 0
                    : (tr['value'] as double) /
                          weekTotalValue, // Valor do dia / total da semana
              ),
            );
          }).toList(), // Converte o map em lista de widgets
        ),
      ),
    );
  }
}

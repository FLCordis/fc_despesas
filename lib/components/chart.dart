import 'package:fc_despesas/components/chart_bar.dart';
import 'package:fc_despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions;

  List<Map<String,Object>> get groupedTransactions {
    return List.generate(7, (index) {

      final weekDay = DateTime.now().subtract(Duration(days: index));
      final dayOfWeek = DateFormat.E().format(weekDay)[0];

      double totalSum = 0.0;
      for (var tr in recentTransactions) {
        if (tr.date.day == weekDay.day && tr.date.month == weekDay.month && tr.date.year == weekDay.year) {
          totalSum += tr.value;
        }
      }

      return {
        'day': dayOfWeek,
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) => sum + (tr['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(), 
                value: tr['value'] as double, 
                percentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue,
                ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
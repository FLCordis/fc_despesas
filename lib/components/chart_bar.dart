import 'package:flutter/material.dart';

// Componente que representa uma barra individual do gráfico
// Cada barra mostra os gastos de um dia da semana
class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.label,     // Rótulo da barra (ex: "SEG", "TER")
    required this.value,     // Valor total gasto no dia
    required this.percentage, // Porcentagem em relação ao maior valor
  });

  final String label;      // Dia da semana abreviado
  final double value;      // Valor em reais gasto no dia
  final double percentage; // Valor entre 0.0 e 1.0 para altura da barra

  // Constrói a barra do gráfico com valor, barra visual e rótulo
  @override
  Widget build(BuildContext context) {
    // LayoutBuilder permite que o widget se adapte ao espaço disponível
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            // Área superior: mostra o valor gasto (15% da altura)
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(value.toStringAsFixed(2))), // Valor com 2 casas decimais
            ),
            SizedBox(height: constraints.maxHeight * 0.05), // Espaçamento (5%)
            
            // Área central: a barra visual propriamente dita (60% da altura)
            SizedBox(
              height: constraints.maxHeight * 0.60,
              width: 10, // Largura fixa da barra
              child: Stack(
                alignment: Alignment.bottomCenter, // Alinha a barra colorida na parte inferior
                children: <Widget>[
                  // Fundo da barra (cinza claro)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1), // Borda cinza
                      color: const Color.fromRGBO(220, 220, 220, 1),         // Fundo cinza claro
                      borderRadius: BorderRadius.circular(5),           // Bordas arredondadas
                    ),
                  ),
                  // Parte preenchida da barra (cor do tema)
                  FractionallySizedBox(
                    heightFactor: percentage, // Altura baseada na porcentagem (0.0 a 1.0)
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor, // Cor primária do tema
                        borderRadius: BorderRadius.circular(5), // Bordas arredondadas
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05), // Espaçamento (5%)
            
            // Área inferior: rótulo do dia da semana (15% da altura)
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)), // Dia da semana (SEG, TER, etc.)
            ),
          ],
        );
      },
    );
  }
}

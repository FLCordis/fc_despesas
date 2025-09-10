// Importações necessárias
import 'dart:io'; // Para detectar a plataforma (iOS ou Android)

import 'package:flutter/cupertino.dart'; // Componentes do iOS
import 'package:flutter/material.dart';   // Componentes do Android
import 'package:intl/intl.dart';         // Para formatação de datas

// Seletor de data adaptativo que muda de aparência conforme a plataforma
// No iOS: usa CupertinoDatePicker (roda de seleção)
// No Android: usa showDatePicker (modal de calendário)
class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;           // Data atualmente selecionada
  final Function(DateTime) onDateChanged; // Função chamada quando a data muda

  const AdaptativeDatePicker({
    super.key,
    required this.selectedDate,   // Data selecionada é obrigatória
    required this.onDateChanged,  // Função de mudança é obrigatória
  });

  // Função que mostra o seletor de data do Android (modal de calendário)
  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),                              // Data inicial: hoje
      firstDate: DateTime.now().subtract(Duration(days: 360)), // Data mínima: 360 dias atrás
      lastDate: DateTime.now(),                                 // Data máxima: hoje
    ).then((pickedDate) {
      // Se o usuário cancelou a seleção, pickedDate será null
      if (pickedDate == null) {
        return; // Não faz nada
      }

      // Chama a função para notificar que a data mudou
      onDateChanged(pickedDate);
    });
  }

  // Função que constrói o seletor de data baseado na plataforma
  @override
  Widget build(BuildContext context) {
    // Verifica se é iOS ou Android e retorna o componente apropriado
    return Platform.isIOS
        ? Container( // Versão iOS: roda de seleção
            height: 150, // Altura fixa para a roda
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,                      // Modo: apenas data (sem hora)
              initialDateTime: DateTime.now(),                         // Data inicial: hoje
              minimumDate: DateTime.now().subtract(Duration(days: 360)), // Data mínima: 360 dias atrás
              maximumDate: DateTime.now(),                             // Data máxima: hoje
              onDateTimeChanged: onDateChanged,                        // Função chamada quando muda
            ),
          )
        : Container( // Versão Android: botão que abre modal
            height: 60, // Altura menor para o botão
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça os elementos
              children: <Widget>[
                Expanded(
                  child: Text(
                    // Mostra a data formatada em português (dd/MM/yyyy)
                    'Data: ${DateFormat('dd/MM/y').format(selectedDate)}',
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor, // Cor do tema
                    textStyle: TextStyle(fontWeight: FontWeight.bold), // Texto em negrito
                  ),
                  onPressed: () => _showDatePicker(context), // Abre o modal de calendário
                  child: Text('Selecionar data'),
                ),
              ],
            ),
          );
  }
}

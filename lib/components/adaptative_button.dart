// Importações necessárias
import 'dart:io'; // Para detectar a plataforma (iOS ou Android)
import 'package:flutter/cupertino.dart'; // Componentes do iOS
import 'package:flutter/material.dart';   // Componentes do Android

// Botão adaptativo que muda de aparência conforme a plataforma
// No iOS: usa CupertinoButton (estilo iOS)
// No Android: usa ElevatedButton (Material Design)
class AdaptativeButton extends StatelessWidget {
  final String label;        // Texto que aparece no botão
  final Function() onPressed; // Função chamada quando o botão é pressionado

  const AdaptativeButton({
    super.key,
    required this.label,     // Texto do botão é obrigatório
    required this.onPressed, // Função de clique é obrigatória
  });

  // Função que constrói o botão baseado na plataforma
  @override
  Widget build(BuildContext context) {
    // Verifica se é iOS ou Android e retorna o botão apropriado
    return Platform.isIOS
        ? CupertinoButton( // Botão estilo iOS
            color: Theme.of(context).primaryColor, // Usa a cor primária do tema
            onPressed: onPressed,                  // Função chamada ao pressionar
            child: Text(label, style: const TextStyle(fontSize: 16)), // Texto do botão
          )
        : ElevatedButton( // Botão estilo Android (Material Design)
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,              // Cor do texto: branco
              backgroundColor: Theme.of(context).primaryColor, // Cor de fundo: cor primária
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),  // Bordas levemente arredondadas
              ),
            ),
            onPressed: onPressed,                         // Função chamada ao pressionar
            child: Text(label, style: const TextStyle(fontSize: 16)), // Texto do botão
          );
  }
}

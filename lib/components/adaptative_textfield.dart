// Importações necessárias
import 'dart:io'; // Para detectar a plataforma (iOS ou Android)
import 'package:flutter/cupertino.dart'; // Componentes do iOS
import 'package:flutter/material.dart';   // Componentes do Android

// Campo de texto adaptativo que muda de aparência conforme a plataforma
// No iOS: usa CupertinoTextField (estilo iOS)
// No Android: usa TextField (Material Design)
class AdaptativeTextField extends StatelessWidget {
  final String label;                    // Texto do rótulo (ex: "Título", "Valor")
  final Function(String) onSubmit;       // Função chamada ao pressionar Enter/Done
  final TextInputType keyboardType;      // Tipo de teclado (texto, número, etc.)
  final TextEditingController controller; // Controlador para capturar/definir texto
  final TextInputAction textInputAction; // Ação do botão do teclado (next, done)
  final FocusNode? focusNode;            // Nó de foco para navegação entre campos

  const AdaptativeTextField({
    super.key,
    required this.label,           // Rótulo é obrigatório
    required this.onSubmit,        // Função de submit é obrigatória
    this.keyboardType = TextInputType.text, // Padrão: teclado de texto
    required this.controller,      // Controlador é obrigatório
    required this.textInputAction, // Ação do teclado é obrigatória
    this.focusNode,               // Nó de foco é opcional
  });

  // Função que constrói o widget baseado na plataforma
  @override
  Widget build(BuildContext context) {
    // Verifica se é iOS ou Android e retorna o componente apropriado
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 8.0), // Espaçamento inferior no iOS
            child: CupertinoTextField( // Campo de texto estilo iOS
              controller: controller,           // Controlador do texto
              focusNode: focusNode,            // Nó de foco
              keyboardType: keyboardType,      // Tipo de teclado
              textInputAction: textInputAction, // Ação do botão do teclado
              onSubmitted: onSubmit,           // Função chamada ao submeter
              placeholder: label,              // Texto de placeholder (iOS usa placeholder)
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12), // Espaçamento interno
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Bordas arredondadas
              ),
            ),
          )
        : TextField( // Campo de texto estilo Android (Material Design)
            controller: controller,           // Controlador do texto
            focusNode: focusNode,            // Nó de foco
            keyboardType: keyboardType,      // Tipo de teclado
            textInputAction: textInputAction, // Ação do botão do teclado
            onSubmitted: onSubmit,           // Função chamada ao submeter
            decoration: InputDecoration(
              labelText: label,              // Texto do rótulo (Android usa label)
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Bordas arredondadas
              ),
            ),
          );
  }
}

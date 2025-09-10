// Importações dos componentes necessários
import 'package:fc_despesas/components/adaptative_button.dart';    // Botão adaptativo
import 'package:fc_despesas/components/adaptative_datepicker.dart'; // Seletor de data
import 'package:fc_despesas/components/adaptative_textfield.dart';  // Campo de texto
import 'package:flutter/material.dart'; // Widgets básicos do Flutter

// Formulário para adicionar novas transações
// StatefulWidget porque o formulário tem estado (dados que mudam)
class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onAddTransaction, {super.key});

  // Função que será chamada quando o usuário submeter o formulário
  // Recebe: título (String), valor (double), data (DateTime)
  final void Function(String, double, DateTime) onAddTransaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

// Estado do formulário - contém os dados e lógica
class _TransactionFormState extends State<TransactionForm> {
  // Controladores para capturar o texto digitado nos campos
  final _titleController = TextEditingController(); // Controla o campo "Título"
  final _valueController = TextEditingController(); // Controla o campo "Valor"
  
  // Nós de foco para navegação entre campos no Android
  // Quando o usuário pressiona "próximo" no teclado, o foco muda para o próximo campo
  final _titleFocusNode = FocusNode();  // Foco do campo título
  final _valueFocusNode = FocusNode();  // Foco do campo valor
  
  // Data selecionada pelo usuário (inicia com a data atual)
  DateTime _selectedDate = DateTime.now();

  // Função que processa o envio do formulário
  void _submitForm() {
    final title = _titleController.text; // Pega o texto do campo título
    final value = double.tryParse(_valueController.text) ?? 0.0; // Converte texto para número
    
    // Validação: título não pode estar vazio e valor deve ser maior que zero
    if (title.isEmpty || value <= 0) {
      return; // Sai da função sem fazer nada se a validação falhar
    }
    
    // Chama a função passada pelo widget pai para adicionar a transação
    widget.onAddTransaction(title, value, _selectedDate);
    
    // Limpa os campos após adicionar a transação
    _titleController.clear();
    _valueController.clear();
  }

  // Função chamada quando o widget é removido da árvore
  // Importante para liberar recursos e evitar vazamentos de memória
  @override
  void dispose() {
    _titleController.dispose();  // Libera o controlador do título
    _valueController.dispose();  // Libera o controlador do valor
    _titleFocusNode.dispose();   // Libera o nó de foco do título
    _valueFocusNode.dispose();   // Libera o nó de foco do valor
    super.dispose();
  }

  // Função que constrói a interface do formulário
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Permite rolar se o conteúdo for maior que a tela
      child: Padding(
        padding: EdgeInsets.all(20), // Espaçamento interno de 20 pixels
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ocupa apenas o espaço necessário
          crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os filhos na largura
          children: <Widget>[
            // Campo de texto para o título da transação
            AdaptativeTextField(
              label: 'Título',                    // Rótulo do campo
              controller: _titleController,       // Controlador para capturar o texto
              focusNode: _titleFocusNode,        // Nó de foco para navegação
              textInputAction: TextInputAction.next, // Botão "próximo" no teclado
              onSubmit: (_) => _valueFocusNode.requestFocus(), // Vai para o próximo campo
              keyboardType: TextInputType.text,   // Teclado de texto normal
            ),
            SizedBox(height: 20), // Espaçamento vertical
            
            // Campo de texto para o valor da transação
            AdaptativeTextField(
              label: 'Valor (R\$)',               // Rótulo com símbolo do real
              controller: _valueController,       // Controlador para capturar o valor
              focusNode: _valueFocusNode,        // Nó de foco
              textInputAction: TextInputAction.done, // Botão "concluído" no teclado
              onSubmit: (_) => _submitForm(),     // Submete o formulário
              keyboardType: TextInputType.number, // Teclado numérico
            ),
            SizedBox(height: 20), // Espaçamento vertical
            
            // Seletor de data adaptativo
            AdaptativeDatePicker(
              selectedDate: _selectedDate,        // Data atualmente selecionada
              onDateChanged: (newDate) {          // Função chamada quando a data muda
                setState(() {                     // Atualiza o estado
                  _selectedDate = newDate;        // Define a nova data
                });
              },
            ),
            SizedBox(height: 40), // Espaçamento maior antes do botão
            
            // Botão para submeter o formulário
            SizedBox(
              width: double.infinity, // Ocupa toda a largura disponível
              height: 50,            // Altura fixa de 50 pixels
              child: AdaptativeButton(
                onPressed: _submitForm,      // Função chamada ao pressionar
                label: 'Nova Transação',    // Texto do botão
              ),
            ),
          ],
        ),
      ),
    );
  }
}

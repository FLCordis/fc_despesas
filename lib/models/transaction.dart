// Modelo de dados que representa uma transação financeira
// Esta classe define a estrutura de cada despesa no aplicativo
class Transaction {
  final String id;       // Identificador único da transação (ex: "123.456")
  final String title;    // Título/descrição da transação (ex: "Almoço", "Gasolina")
  final double value;    // Valor da transação em reais (ex: 25.50, 100.00)
  final DateTime date;   // Data quando a transação foi realizada

  // Construtor da classe - todos os campos são obrigatórios (required)
  Transaction({
    required this.id,    // ID deve ser fornecido
    required this.title, // Título deve ser fornecido
    required this.value, // Valor deve ser fornecido
    required this.date   // Data deve ser fornecida
  });

  // Exemplo de uso:
  // Transaction(
  //   id: "1",
  //   title: "Café da manhã",
  //   value: 15.50,
  //   date: DateTime.now()
  // )
}
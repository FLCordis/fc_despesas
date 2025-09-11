// Importações necessárias para o funcionamento do app
import 'dart:io'; // Para detectar se é iOS ou Android
import 'dart:math'; // Para gerar IDs aleatórios

// Importações do Flutter para interface
import 'package:flutter/cupertino.dart'; // Componentes do iOS
import 'package:flutter/material.dart'; // Componentes do Android/Material Design
import 'package:flutter_localizations/flutter_localizations.dart'; // Para localização em português

// Importações de bibliotecas externas
import 'package:url_launcher/url_launcher.dart'; // Para abrir links externos

// Importações dos nossos componentes personalizados
import 'package:fc_despesas/components/chart.dart'; // Gráfico de despesas
import 'components/transaction_form.dart'; // Formulário para adicionar transações
import 'components/transaction_list.dart'; // Lista de transações
import 'models/transaction.dart'; // Modelo de dados da transação

// Função principal que inicia o aplicativo
void main() => runApp(const ExpensesApp());

// Classe principal do aplicativo - define as configurações gerais
class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna o MaterialApp que é a base do aplicativo
    return MaterialApp(
      title: 'Despesas Pessoais FC', // Nome do aplicativo
      
      // Configurações de localização para português brasileiro
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // Textos padrão em português
        GlobalWidgetsLocalizations.delegate,  // Widgets em português
        GlobalCupertinoLocalizations.delegate, // Componentes iOS em português
      ],
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')], // Idiomas suportados
      
      home: const MyHomePage(), // Tela inicial do aplicativo
      
      // Tema visual do aplicativo
      theme: ThemeData(
        primarySwatch: Colors.purple, // Cor principal: roxo
        hintColor: Colors.yellow,     // Cor de destaque: amarelo
        highlightColor: Colors.green, // Cor de realce: verde
        fontFamily: 'Quicksand',      // Fonte padrão do aplicativo
        
        // Configuração dos textos
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: const TextStyle(
            fontFamily: 'OpenSans',     // Fonte para títulos
            fontSize: 18,               // Tamanho da fonte
            fontWeight: FontWeight.bold, // Negrito
            color: Colors.black,        // Cor preta
          ),
        ),
        
        // Configuração da barra superior (AppBar)
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Texto branco na barra superior
          ),
        ),
        
        // Configuração dos botões elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,    // Texto branco
            backgroundColor: Colors.purple[800], // Fundo roxo escuro
            textStyle: const TextStyle(fontWeight: FontWeight.bold), // Texto em negrito
          ),
        ),
      ),
    );
  }
}

// Tela principal do aplicativo - StatefulWidget porque o conteúdo muda
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Estado da tela principal - aqui ficam os dados e a lógica
class _MyHomePageState extends State<MyHomePage> {
  // Lista que armazena todas as transações do usuário
  final List<Transaction> _transactions = [];
  
  // Controla se o gráfico está sendo exibido (usado no modo paisagem)
  bool _showChart = false;

  // Getter que retorna apenas as transações dos últimos 7 dias
  // Usado para mostrar no gráfico apenas dados recentes
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  // Função para adicionar uma nova transação à lista
  _addTransaction(String title, double value, DateTime date) {
    // Cria uma nova transação com os dados recebidos
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(), // Gera um ID único aleatório
      title: title,   // Título da transação (ex: "Almoço")
      value: value,   // Valor da transação (ex: 25.50)
      date: date,     // Data da transação
    );

    // setState() avisa o Flutter que algo mudou e a tela precisa ser redesenhada
    setState(() {
      _transactions.add(newTransaction); // Adiciona a nova transação à lista
    });

    // Fecha o modal do formulário após adicionar a transação
    // Navigator.pop() remove a tela atual da pilha de navegação
    Navigator.of(context).pop();
  }

  // Função para remover uma transação da lista
  _removeTransaction(String id) {
    setState(() {
      // Remove a transação que tem o ID correspondente
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  // Função para abrir links externos (como o GitHub)
  _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // Converte a string em um objeto Uri
    try {
      // Tenta abrir o link em um aplicativo externo (navegador)
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        // Se não conseguir, tenta o modo padrão
        if (!await launchUrl(uri)) {
          throw Exception('Could not launch $url');
        }
      }
    } catch (e) {
      print('Erro ao abrir URL: $e');
      // Mostra uma mensagem de erro para o usuário na parte inferior da tela
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o link'))
      );
    }
  }

  // Função que mostra um diálogo com informações sobre o aplicativo
  _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sobre o App'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Ocupa apenas o espaço necessário
            crossAxisAlignment: CrossAxisAlignment.start, // Alinha à esquerda
            children: [
              const Text(
                'Despesas Pessoais FC',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8), // Espaçamento vertical
              const Text('Desenvolvido por Flávio Cordis'),
              const SizedBox(height: 4),
              // Link clicável para o GitHub
              GestureDetector(
                onTap: () {
                  _launchURL('http://github.com/flcordis'); // Abre o GitHub
                },
                child: const Text(
                  'GitHub/FLCordis',
                  style: TextStyle(
                    color: Colors.blue,              // Cor azul para indicar link
                    decoration: TextDecoration.underline, // Sublinhado
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Copyright © 2025'),
            ],
          ),
          actions: [
            // Botão para fechar o diálogo
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  // Função que abre o formulário para adicionar nova transação em um modal
  _openTransactionFormModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Bordas arredondadas
          ),
          child: TransactionForm(_addTransaction), // Passa a função de adicionar
        );
      },
    );
  }

  // Função que cria botões adaptativos para iOS e Android
  // No iOS usa GestureDetector, no Android usa IconButton
  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))     // iOS: toque simples
        : IconButton(icon: Icon(icon), onPressed: fn);      // Android: botão material
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList = Platform.isIOS ? CupertinoIcons.refresh : Icons.bar_chart;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(_showChart ? iconList : chartList, () {
          setState(() {
            _showChart = !_showChart;
          });
        }),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.info : Icons.info_outline,
        () => _showInfoDialog(context),
      ),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Despesas Pessoais FC',
              textScaler: TextScaler.linear(1.0),
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: actions),
          )
        : AppBar(
            title: const Text(
              'Despesas Pessoais FC',
              textScaler: TextScaler.linear(1.0),
            ),
            actions: actions,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          );

    final availableHeight =
        mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Switch(
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = value;
            //           });
            //         },
            //       ),
            //       Text('Exibir Gráfico'),
            //     ],
            //   ),
            if (_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 0.7 : 0.3),
                child: Chart(recentTransactions: _recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _removeTransaction,
                ),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: actions),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: !isLandscape
                ? FloatingActionButton.extended(
                    onPressed: () => _openTransactionFormModal(context),
                    backgroundColor: Theme.of(context).highlightColor,
                    foregroundColor: Colors.white,
                    label: const Text('Adicionar'),
                    icon: const Icon(Icons.add),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}

import 'package:fc_despesas/components/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Despesas Pessoais FC',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        hintColor: Colors.amber,
        highlightColor: Colors.green[200],
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light().textTheme.titleMedium!.copyWith(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple[800],
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List <Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    //Aqui ele fecha a primeira tela, no caso o Modal, melhor que colocar dentro do Modal, por que no arquivo, ele não sabe que ele é um 'modal'.
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        // Fallback para modo padrão
        if (!await launchUrl(uri)) {
          throw Exception('Could not launch $url');
        }
      }
    } catch (e) {
      print('Erro ao abrir URL: $e');
      // Mostra um snackbar para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir o link')),
      );
    }
  }

  _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sobre o App'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Despesas Pessoais FC', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 8),
              Text('Desenvolvido por Flávio Cordis'),
              SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  _launchURL('http://github.com/flcordis');
                },
                child: Text(
                  'GitHub/FLCordis',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text('Copyright © 2025'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas Pessoais FC',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions: _recentTransactions),
            TransactionList(transactions: _transactions, onRemove: _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).hintColor,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

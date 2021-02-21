import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/main/add_new_transaction.dart';
import 'package:flutter_app/ui/main/chart.dart';
import 'package:flutter_app/ui/main/transaction_list.dart';

import '../../models/Transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        accentColor: Colors.amberAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    /*Transaction(
        id: "t1", title: "New shoes", amount: 69.69, dateTime: DateTime.now()),
    Transaction(
        id: "t2", title: "New Jacket", amount: 10.15, dateTime: DateTime.now())*/
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) => element.dateTime.isAfter(
              DateTime.now().subtract(Duration(days: 7)),
            ))
        .toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime selectedDate) {
    Transaction newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        dateTime: selectedDate,
        id: DateTime.now().toString());

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return InputTransaction(_addTransaction);
        });
  }

  bool _switched = false;

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = _buildAppBar();
    final removedSize =
        appBar.preferredSize.height + MediaQuery.of(context).padding.top;
    final availableSize = MediaQuery.of(context).size.height - removedSize;
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final listContainer = Container(
      height: availableSize * 0.7,
      child: TransactionList(_transactions, _deleteTransaction),
    );

    final body = SafeArea(
      child: SingleChildScrollView(
        child: landscape
            ? Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show Chart',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Switch.adaptive(
                          activeColor: Theme.of(context).accentColor,
                          value: _switched,
                          onChanged: (val) {
                            setState(() {
                              _switched = val;
                            });
                          }),
                    ],
                  ),
                  if (!_switched)
                    Container(
                        height: availableSize * 0.7,
                        child: ChartWidget(_recentTransactions))
                  else
                    listContainer
                ],
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: availableSize * 0.3,
                    child: ChartWidget(_recentTransactions),
                  ),
                  listContainer,
                ],
              ),
      ),
    );

    return (Platform.isIOS)
        ? CupertinoPageScaffold(child: body)
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButton: (!Platform.isIOS)
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                  )
                : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }

  Widget _buildAppBar() {
    final title = const Text('Personal expense');
    return (Platform.isIOS)
        ? CupertinoNavigationBar(
            middle: title,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: title,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          );
  }
}

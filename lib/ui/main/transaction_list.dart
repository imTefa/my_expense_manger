import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/Transaction.dart';
import 'package:flutter_app/ui/main/empty_list_widget.dart';
import 'package:flutter_app/ui/main/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> list;
  final Function _deleteTransaction;

  TransactionList(this.list, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? EmptyListWidget(
            text: 'No transactions added yet!',
            imageAsset: 'assets/images/waiting.png',
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(list[index], _deleteTransaction);
            },
            itemCount: list.length,
          );
  }
}

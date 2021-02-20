import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/common/AdaptiveButton.dart';
import 'package:intl/intl.dart';

class InputTransaction extends StatefulWidget {
  final Function addTransaction;

  InputTransaction(this.addTransaction);

  @override
  _InputTransactionState createState() => _InputTransactionState();
}

class _InputTransactionState extends State<InputTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate;

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date selected'
                            : DateFormat.yMMMd().format(_selectedDate),
                      ),
                    ),
                    AdaptiveButton(
                      onPressed: _showDatePicker(),
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  checkInputs();
                },
                textColor: Theme.of(context).textTheme.button.color,
                child: Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkInputs() {
    String title = _titleController.text;
    double amount = double.parse(_amountController.text);

    if (title.isNotEmpty && amount > 0 && _selectedDate != null) {
      widget.addTransaction(title, amount, _selectedDate);

      Navigator.of(context).pop();
    }
  }
}

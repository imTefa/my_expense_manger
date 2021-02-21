import 'package:flutter/material.dart';
import 'package:flutter_app/models/Transaction.dart';
import 'package:flutter_app/ui/main/bar.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ChartWidget extends StatelessWidget {
  final List<Transaction> _transactions;

  List<Map<String, Object>> _recentTransactionsMap;
  double _totalSpend = 0.0;

  ChartWidget(this._transactions) {
    _calcRecentMap();
    _calcTotalSpend();
  }

  void _calcRecentMap() {
    _recentTransactionsMap = List.generate(7, (index) {
      final weedDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;

      for (var i = 0; i < _transactions.length; i++) {
        if (atTheSameDay(_transactions[i].dateTime, weedDay))
          totalAmount += _transactions[i].amount;
      }

      return {
        'day': DateFormat.E().format(weedDay).substring(0, 1),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  void _calcTotalSpend() {
    _totalSpend = _recentTransactionsMap.fold(
        0.0, (sum, element) => sum + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _recentTransactionsMap.map((e) {
            var percentage =
                _totalSpend > 0.0 ? (e['amount'] as double) / _totalSpend : 0.0;
            print('percentage of day ${e['day']} = $percentage');
            return Flexible(
              fit: FlexFit.tight,
              child: Bar(
                e['day'],
                e['amount'],
                percentage,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

bool atTheSameDay(DateTime d1, DateTime d2) {
  return d1.day == d2.day && d1.month == d2.month && d1.year == d2.year;
}

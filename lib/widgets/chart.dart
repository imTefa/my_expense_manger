import 'package:flutter/material.dart';
import 'package:flutter_app/models/Transaction.dart';
import 'package:flutter_app/widgets/Bar.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  final List<Transaction> _transactions;

  ChartWidget(this._transactions);

  List<Map<String, Object>> get _recentTransactionsMap {
    return List.generate(7, (index) {
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

  double get totalSpend {
    return _recentTransactionsMap.fold(
        0.0, (sum, element) => sum + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _recentTransactionsMap.map((e) {
            var tSpend = totalSpend;
            var percentage =
                tSpend > 0.0 ? (e['amount'] as double) / tSpend : 0.0;
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

import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  String label;
  double amount;
  double percentage;

  Bar(this.label, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    print('from bar percentage of day ${label} = $percentage');

    return LayoutBuilder(
      builder: (context, constraint) {
        final h = constraint.maxHeight;
        return Column(
          children: [
            Container(
              height: h * 0.15,
              child: FittedBox(
                child: Text(
                  amount.toStringAsFixed(0),
                ),
              ),
            ),
            SizedBox(height: h * 0.05),
            Container(
              height: h * 0.60,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        color: Color.fromARGB(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: h * 0.05),
            Container(
              height: h * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            )
          ],
        );
      },
    );
  }
}

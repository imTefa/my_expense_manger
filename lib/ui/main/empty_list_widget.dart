import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;
  final String imageAsset;

  EmptyListWidget({this.text, this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          Container(
            height: constraint.maxHeight * 0.60,
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    });
  }
}

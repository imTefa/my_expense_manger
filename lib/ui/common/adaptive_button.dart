import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {

  final Function onPressed;
  final Widget child;

  AdaptiveButton({this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? CupertinoButton(
            onPressed: onPressed,
            child: child,
          )
        : FlatButton(
            onPressed: onPressed,
            child: child,
          );
  }
}

import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class CardLabelWidget extends StatelessWidget {
  final String? text;
  final Color color;

  CardLabelWidget({this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: -math.pi / 12.0,
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(color: color, width: 4)),
          child: _getText(text),
        ));
  }

  _getText(text) {
    if (text != null) {
      return Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      );
    } else {
      return Container();
    }
  }
}

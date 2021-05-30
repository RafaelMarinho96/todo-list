import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class CardLabelWidget extends StatelessWidget {
  final String? text;

  CardLabelWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: -math.pi / 12.0,
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFDFDFDF), width: 4)),
          child: _getText(text),
        ));
  }

  _getText(text) {
    if (text != null) {
      return Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      );
    } else {
      return Container();
    }
  }
}

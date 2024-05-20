import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget text({required String label, required Color color}){
  return Text(
    label,
    style: TextStyle(color: color),
    textAlign: TextAlign.center,
  );
}

class TextTitle extends StatelessWidget {
  TextTitle({required this.label, required this.size, required this.fontWeight, required this.color });
  String label;
  double size;
  FontWeight fontWeight;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        label,
        style: TextStyle(
            fontSize: size, fontWeight: fontWeight, color: color),textAlign: TextAlign.center,
      ),
    );
  }
}


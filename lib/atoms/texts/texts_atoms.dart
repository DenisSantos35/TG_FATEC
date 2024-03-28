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

Widget textTitle({required String label, required double size, required FontWeight fontWeight, required Color color }){
  return Text(
    label,
    style: TextStyle(
        fontSize: size, fontWeight: fontWeight, color: color),textAlign: TextAlign.center,
  );
}
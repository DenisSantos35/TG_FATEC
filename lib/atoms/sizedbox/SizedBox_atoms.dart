import 'package:flutter/material.dart';

Widget SizeHeight({required double height, required double multiplier}){
  return SizedBox(
    height: height * multiplier,
  );
}

Widget SizeWhidth({required double width, required double multiplier}){
  return SizedBox(
    height: width * multiplier,
  );
}
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../imagens/images_atoms.dart';
import '../texts/texts_atoms.dart';

Widget ContainerDegradee({required Color color1, required Color color2}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
    ),
  );
}

Widget showText(String label, double size) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xff000000),
        fontSize: size,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget menuContainer(
    {required String image,
    required String label,
    required int page,
    required Color color}) {
  return GestureDetector(
    onTap: () => print(page),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        image: DecorationImage(image: AssetImage(image), scale: 5),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget cardProducts(
    {required BuildContext context,
    required double width,
    required double height,
    required Color color,
    required String image,
    required String label,
    required int page}) {
  return GestureDetector(
    onTap: (){
      print(page);
    },
    child: Card(
      shadowColor: Colors.black,
      color: color,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: width * 0.85,
        height: height * 0.15,
        child: Row(
          children: [
            imageCard(context: context, image: image, opacity: 1),
            SizedBox(
              width: width * 0.03,
            ),
            Expanded(
                child: textTitle(
                    label: label,
                    size: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white))
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

import '../imagens/images_atoms.dart';
import '../texts/texts_atoms.dart';

Widget cardSales(
    {required BuildContext context,
    required String image,
    required double width,
    required double height,
    required String label,
    required Color color, required int page}) {
  bool toque = false;
  return Center(
    child: GestureDetector(
      onTap: (){
        print(page);
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: 300),
        curve: Curves.easeInOut,
        child: Card(
          elevation: 20,
          shadowColor: Colors.black,
          color: color,
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            width: width * 0.85,
            height: height * 0.3,
            child: Column(
              children: [
                textTitle(
                    label: label,
                    size: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                SizedBox(
                  height: height * 0.03,
                ),
                imageCardSale(
                    context: context,
                    image: image,
                    opacity: 1),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
